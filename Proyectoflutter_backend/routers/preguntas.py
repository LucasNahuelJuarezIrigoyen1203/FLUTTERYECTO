from fastapi import APIRouter, HTTPException
from models import PreguntaConOpciones
from db import conn

router = APIRouter()

@router.get("/niveles/{nivel_id}/pregunta", response_model=PreguntaConOpciones)
def obtener_pregunta_por_nivel(nivel_id: int):
    cursor = conn.cursor()

    # 🔍 Buscar pregunta activa para el nivel
    cursor.execute("""
        SELECT TOP 1 id, texto
        FROM preguntas
        WHERE nivel_id = ? AND activo = 1
        ORDER BY NEWID()  -- aleatoriza si hay varias preguntas por nivel
    """, (nivel_id,))
    pregunta = cursor.fetchone()

    if not pregunta:
        raise HTTPException(status_code=404, detail="No hay pregunta activa para este nivel")

    pregunta_id, texto = pregunta

    # 🔍 Obtener opciones asociadas
    cursor.execute("""
        SELECT id, texto
        FROM opciones
        WHERE pregunta_id = ?
        ORDER BY id
    """, (pregunta_id,))
    opciones = cursor.fetchall()

    return PreguntaConOpciones(
        id=pregunta_id,
        texto=texto,
        opciones=[{"id": o[0], "texto": o[1]} for o in opciones]
    )
