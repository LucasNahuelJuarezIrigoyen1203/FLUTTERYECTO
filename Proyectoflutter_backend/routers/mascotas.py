from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List
from db import conn

router = APIRouter()

class MascotaNombreRequest(BaseModel):
    nombre: str

# 🔹 Endpoint para actualizar mascota activa por nombre
@router.post("/usuarios/{usuario_id}/mascota_por_nombre")
def actualizar_mascota_por_nombre(usuario_id: int, request: MascotaNombreRequest):
    cursor = conn.cursor()

    # Buscar mascota por nombre
    cursor.execute("SELECT id FROM mascotas WHERE nombre = ?", (request.nombre,))
    mascota = cursor.fetchone()

    if not mascota:
        cursor.close()
        raise HTTPException(status_code=404, detail="Mascota no encontrada")

    mascota_id = mascota[0]

    # Actualizar usuario con la mascota activa
    cursor.execute("""
        UPDATE usuarios
        SET mascota_activa_id = ?
        WHERE id = ?
    """, (mascota_id, usuario_id))

    conn.commit()
    cursor.close()  # ✅ solo cerramos el cursor

    return {
        "mensaje": f"Mascota actualizada a '{request.nombre}'",
        "mascota_id": mascota_id
    }

# 🔹 Endpoint para listar todas las mascotas
@router.get("", response_model=List[dict])
def listar_mascotas():
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, imagen FROM mascotas")
    rows = cursor.fetchall()
    cursor.close()

    return [{"id": r[0], "nombre": r[1], "imagen": r[2]} for r in rows]

