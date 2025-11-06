from fastapi import APIRouter, HTTPException
from db import conn
from models import Nivel, NivelDetalle

router = APIRouter()

# 🔹 Listar todos los niveles con puntos requeridos
@router.get("/niveles", response_model=list[Nivel])
def listar_niveles():
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, puntos_requeridos FROM niveles ORDER BY id")
    niveles = cursor.fetchall()
    cursor.close()

    return [
        {"id": row[0], "nombre": row[1], "puntos": row[2]}
        for row in niveles
    ]

# 🔸 Obtener detalles enriquecidos de un nivel específico
@router.get("/niveles/{nivel_id}", response_model=NivelDetalle)
def obtener_nivel(nivel_id: int):
    cursor = conn.cursor()

    # Verificamos que el nivel exista
    cursor.execute("SELECT id, nombre, puntos_requeridos FROM niveles WHERE id = ?", (nivel_id,))
    nivel = cursor.fetchone()
    if not nivel:
        cursor.close()
        raise HTTPException(status_code=404, detail="Nivel no encontrado")

    # Obtenemos combinaciones únicas de rama + dificultad + multiplicador
    cursor.execute("""
        SELECT DISTINCT r.nombre, d.nombre, d.multiplicador
        FROM preguntas p
        JOIN ramas r ON p.rama_id = r.id
        JOIN dificultades d ON p.dificultad_id = d.id
        WHERE p.nivel_id = ?
    """, (nivel_id,))
    combinaciones_raw = cursor.fetchall()
    cursor.close()

    # Si hay al menos una combinación, devolvemos la primera (puede adaptarse a lista si querés)
    if not combinaciones_raw:
        raise HTTPException(status_code=404, detail="No hay preguntas asociadas a este nivel")

    rama, dificultad, multiplicador = combinaciones_raw[0]

    return {
        "id": nivel[0],
        "nombre": nivel[1],
        "puntos": nivel[2],
        "rama": rama,
        "dificultad": dificultad,
        "multiplicador": multiplicador
    }
