from fastapi import APIRouter, HTTPException
from db import conn
from models import Nivel, NivelDetalle

router = APIRouter()

# 🔹 Listar todos los niveles
@router.get("/niveles", response_model=list[Nivel])
def listar_niveles():
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre FROM niveles ORDER BY id")
    niveles = cursor.fetchall()
    cursor.close()

    return [{"id": n[0], "nombre": n[1]} for n in niveles]

# 🔸 Obtener detalles de un nivel específico
@router.get("/niveles/{nivel_id}", response_model=NivelDetalle)
def obtener_nivel(nivel_id: int):
    cursor = conn.cursor()
    cursor.execute("""
        SELECT n.id, n.nombre, r.nombre, d.nombre, d.multiplicador
        FROM niveles n
        JOIN preguntas p ON p.nivel_id = n.id
        JOIN ramas r ON p.rama_id = r.id
        JOIN dificultades d ON p.dificultad_id = d.id
        WHERE n.id = ?
    """, (nivel_id,))
    fila = cursor.fetchone()
    cursor.close()

    if not fila:
        raise HTTPException(status_code=404, detail="Nivel no encontrado")

    return {
        "id": fila[0],
        "nombre": fila[1],
        "rama": fila[2],
        "dificultad": fila[3],
        "multiplicador": fila[4]
    }
