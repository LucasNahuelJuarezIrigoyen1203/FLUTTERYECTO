from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import pyodbc
from db import get_db_connection

router = APIRouter()

class MascotaNombreRequest(BaseModel):
    nombre: str

@router.post("/usuarios/{usuario_id}/mascota_por_nombre")
def actualizar_mascota_por_nombre(usuario_id: int, request: MascotaNombreRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id FROM mascotas WHERE nombre = ?", (request.nombre,))
    mascota = cursor.fetchone()

    if not mascota:
        raise HTTPException(status_code=404, detail="Mascota no encontrada")

    mascota_id = mascota[0]

    cursor.execute("""
        UPDATE usuarios
        SET mascota_activa_id = ?
        WHERE id = ?
    """, (mascota_id, usuario_id))

    conn.commit()
    cursor.close()
    conn.close()

    return {"mensaje": f"Mascota actualizada a '{request.nombre}'"}
