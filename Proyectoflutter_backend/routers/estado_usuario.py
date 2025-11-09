from fastapi import APIRouter, HTTPException
from models import RamaEstado, EstadoUsuarioResponse
from db import conn

router = APIRouter()

@router.get("/{id}/estado", response_model=EstadoUsuarioResponse)
def obtener_estado_usuario(id: int):
    cursor = conn.cursor()

    # 🔍 Verificar existencia del usuario
    cursor.execute("SELECT 1 FROM usuarios WHERE id = ?", (id,))
    if not cursor.fetchone():
        cursor.close()
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    # 🧠 Obtener vidas actuales
    cursor.execute("""
        SELECT TOP 1 cantidad
        FROM vidas
        WHERE usuario_id = ?
        ORDER BY updated_at DESC
    """, (id,))
    vidas_row = cursor.fetchone()
    vidas = vidas_row[0] if vidas_row else 5  # valor por defecto

    # 📊 Obtener estado por rama
    cursor.execute("""
        SELECT r.id, r.nombre,
            ISNULL(MAX(q.nivel_id), 1) AS nivel_actual,
            CAST(SUM(CASE WHEN p.respondio_correctamente = 1 THEN 1 ELSE 0 END) AS FLOAT) /
            NULLIF(COUNT(p.id), 0) AS progreso
        FROM ramas r
        LEFT JOIN preguntas q ON q.rama_id = r.id
        LEFT JOIN progreso p ON p.pregunta_id = q.id AND p.usuario_id = ?
        GROUP BY r.id, r.nombre
    """, (id,))
    
    ramas_estado = []
    for rama_id, rama_nombre, nivel_actual, progreso in cursor.fetchall():
        ramas_estado.append(RamaEstado(
            rama_id=rama_id,
            rama_nombre=rama_nombre,
            nivel_actual=nivel_actual or 1,
            progreso=round(progreso or 0.0, 2)
        ))

    cursor.close()
    return EstadoUsuarioResponse(vidas=vidas, ramas_estado=ramas_estado)
