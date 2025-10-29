from fastapi import APIRouter, HTTPException
from models import RespuestaInput, RespuestaOutput
from db import conn
from datetime import datetime

router = APIRouter()

@router.post("/respuestas", response_model=RespuestaOutput)
def validar_respuesta(data: RespuestaInput):
    cursor = conn.cursor()

    # 🔍 Obtener pregunta y opción correcta
    cursor.execute("""
        SELECT o.id
        FROM opciones o
        WHERE o.pregunta_id = ? AND o.es_correcta = 1
    """, (data.pregunta_id,))
    correcta = cursor.fetchone()
    if not correcta:
        raise HTTPException(status_code=404, detail="Pregunta no encontrada o sin opción correcta")

    # 🔍 Obtener usuario
    cursor.execute("SELECT nivel_actual, progreso FROM usuarios WHERE id = ?", (data.usuario_id,))
    usuario = cursor.fetchone()
    if not usuario:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    nivel_actual, progreso = usuario
    acierto = data.opcion_seleccionada == correcta[0]

    if acierto:
        nivel_actual += 1
        progreso += 0.1  # Ajustable según tu lógica
        cursor.execute("""
            UPDATE usuarios SET nivel_actual = ?, progreso = ?, updated_at = ?
            WHERE id = ?
        """, (nivel_actual, progreso, datetime.now(), data.usuario_id))
        conn.commit()
        vidas_restantes = None
    else:
        # 🔻 Desactivar una vida si falla
        cursor.execute("""
            SELECT TOP 1 id FROM vidas
            WHERE usuario_id = ? AND activa = 1
            ORDER BY created_at DESC
        """, (data.usuario_id,))
        vida = cursor.fetchone()
        if vida:
            cursor.execute("UPDATE vidas SET activa = 0, updated_at = ? WHERE id = ?", (datetime.now(), vida[0]))
            conn.commit()

        cursor.execute("SELECT COUNT(*) FROM vidas WHERE usuario_id = ? AND activa = 1", (data.usuario_id,))
        vidas_restantes = cursor.fetchone()[0]

    cursor.close()

    return RespuestaOutput(
        correcta=acierto,
        nivel_actual=nivel_actual if acierto else usuario[0],
        progreso=progreso if acierto else usuario[1],
        vidas_restantes=vidas_restantes
    )
