from fastapi import APIRouter, HTTPException, Request
from models import VidaCreate, VidaResponse, VidaUpdate, EvaluacionNivel
from db import conn
from datetime import datetime, timedelta

router = APIRouter()

# 🔁 GET /usuarios/{usuario_id}/vidas — Estado actual de vidas + regeneración
@router.get("/usuarios/{usuario_id}/vidas")
def vidas_con_estado(usuario_id: int):
    cursor = conn.cursor()
    ahora = datetime.now()

    # Vidas activas
    cursor.execute("SELECT COUNT(*) FROM vidas WHERE usuario_id = ? AND activa = 1", (usuario_id,))
    activas = cursor.fetchone()[0]

    # Buscar vida en regeneración
    cursor.execute(
        "SELECT TOP 1 id, updated_at FROM vidas WHERE usuario_id = ? AND activa = 0 ORDER BY updated_at DESC",
        (usuario_id,)
    )
    vida = cursor.fetchone()
    restante = None

    if vida:
        tiempo_pasado = (ahora - vida[1]).total_seconds()
        if tiempo_pasado < 180:
            restante = int(180 - tiempo_pasado)
        else:
            # Reactivar automáticamente
            cursor.execute("UPDATE vidas SET activa = 1, updated_at = ? WHERE id = ?", (ahora, vida[0]))
            conn.commit()
            restante = 0

    return {
        "vidas_activas": activas,
        "vida_en_regeneracion": {
            "id": vida[0],
            "restante_segundos": restante
        } if restante else None
    }

# 🔁 POST /usuarios/{usuario_id}/vidas — Crear nueva vida
@router.post("/usuarios/{usuario_id}/vidas", response_model=VidaResponse)
def crear_vida(usuario_id: int, vida: VidaCreate):
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO vidas (usuario_id, puntos, activa) VALUES (?, ?, ?)",
        (usuario_id, vida.puntos, 1)
    )
    conn.commit()

    cursor.execute("SELECT id, usuario_id, puntos, created_at, updated_at, activa FROM vidas WHERE id = SCOPE_IDENTITY()")
    r = cursor.fetchone()

    return VidaResponse(
        id=r[0], usuario_id=r[1], puntos=r[2],
        created_at=r[3], updated_at=r[4], activa=r[5]
    )

# 🔁 GET /vidas/{id} — Obtener vida por ID
@router.get("/vidas/{id}", response_model=VidaResponse)
def obtener_vida(id: int):
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, usuario_id, puntos, created_at, updated_at, activa FROM vidas WHERE id = ?",
        (id,)
    )
    r = cursor.fetchone()
    if not r:
        raise HTTPException(status_code=404, detail="Vida no encontrada")
    return VidaResponse(
        id=r[0], usuario_id=r[1], puntos=r[2],
        created_at=r[3], updated_at=r[4], activa=r[5]
    )

# 🔁 PUT /vidas/{id} — Actualizar vida
@router.put("/vidas/{id}", response_model=VidaResponse)
def actualizar_vida(id: int, datos: VidaUpdate):
    cursor = conn.cursor()
    campos = []
    valores = []

    if datos.puntos is not None:
        campos.append("puntos = ?")
        valores.append(datos.puntos)
    if datos.activa is not None:
        campos.append("activa = ?")
        valores.append(datos.activa)

    campos.append("updated_at = ?")
    valores.append(datetime.now())

    if not campos:
        raise HTTPException(status_code=400, detail="No se enviaron datos para actualizar")

    valores.append(id)
    query = f"UPDATE vidas SET {', '.join(campos)} WHERE id = ?"
    cursor.execute(query, valores)
    conn.commit()

    cursor.execute("SELECT id, usuario_id, puntos, created_at, updated_at, activa FROM vidas WHERE id = ?", (id,))
    r = cursor.fetchone()
    return VidaResponse(
        id=r[0], usuario_id=r[1], puntos=r[2],
        created_at=r[3], updated_at=r[4], activa=r[5]
    )

# 🔁 DELETE /vidas/{id} — Desactivar vida (soft delete)
@router.delete("/vidas/{id}")
def desactivar_vida(id: int):
    cursor = conn.cursor()
    cursor.execute("UPDATE vidas SET activa = 0, updated_at = GETDATE() WHERE id = ?", (id,))
    conn.commit()
    return {"mensaje": f"Vida {id} desactivada correctamente"}

# 🔁 PATCH /vidas/{id}/activar — Reactivar vida manualmente
@router.patch("/vidas/{id}/activar")
def reactivar_vida(id: int):
    cursor = conn.cursor()
    cursor.execute("UPDATE vidas SET activa = 1, updated_at = GETDATE() WHERE id = ?", (id,))
    conn.commit()
    return {"mensaje": f"Vida {id} reactivada correctamente"}

# 🔁 POST /usuarios/{usuario_id}/vidas/evaluar — Evaluar nivel y descontar vida si falla
@router.post("/usuarios/{usuario_id}/vidas/evaluar")
def evaluar_nivel(usuario_id: int, datos: EvaluacionNivel, request: Request):
    cursor = conn.cursor()

    porcentaje = (datos.puntaje_obtenido / datos.puntaje_maximo) * 100

    if porcentaje < 45:
        cursor.execute(
            "SELECT TOP 1 id FROM vidas WHERE usuario_id = ? AND activa = 1 ORDER BY created_at DESC",
            (usuario_id,)
        )
        vida = cursor.fetchone()
        if not vida:
            raise HTTPException(status_code=404, detail="No hay vidas activas para este usuario")

        cursor.execute("UPDATE vidas SET activa = 0, updated_at = GETDATE() WHERE id = ?", (vida[0],))
        conn.commit()

        return {
            "mensaje": "Evaluación fallida. Vida perdida.",
            "porcentaje": porcentaje
        }

    return {
        "mensaje": "Evaluación superada. Vida conservada.",
        "porcentaje": porcentaje
    }
