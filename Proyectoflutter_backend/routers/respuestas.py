from fastapi import APIRouter, HTTPException
from models import RespuestaInput, RespuestaOutput
from db import conn
from datetime import datetime

router = APIRouter()

@router.post("/", response_model=RespuestaOutput)
def validar_respuesta(data: RespuestaInput):
    cursor = conn.cursor()

    # 🔍 Obtener opción correcta
    cursor.execute("""
        SELECT id FROM respuestas
        WHERE pregunta_id = ? AND es_correcta = 1
    """, (data.pregunta_id,))
    correcta = cursor.fetchone()
    if not correcta:
        cursor.close()
        raise HTTPException(status_code=404, detail="Pregunta no encontrada o sin opción correcta")

    # 🔍 Obtener datos del usuario y nivel actual de la pregunta
    cursor.execute("""
        SELECT u.nivel_actual, u.progreso, p.nivel_id
        FROM usuarios u
        CROSS JOIN preguntas p
        WHERE u.id = ? AND p.id = ?
    """, (data.usuario_id, data.pregunta_id))
    usuario = cursor.fetchone()
    if not usuario:
        cursor.close()
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    nivel_actual, progreso, pregunta_nivel_id = usuario
    acierto = data.opcion_seleccionada == correcta[0]

    if acierto:
        # Buscar la siguiente pregunta del nivel
        cursor.execute("""
            SELECT TOP 1 id
            FROM preguntas 
            WHERE nivel_id = ? AND id > ?
            ORDER BY id
        """, (pregunta_nivel_id, data.pregunta_id))
        siguiente = cursor.fetchone()
        siguiente_pregunta_id = siguiente[0] if siguiente else None

        if not siguiente_pregunta_id:
            # Si no hay más preguntas, subir de nivel
            nivel_actual += 1
            progreso += 0.1  # Ajustable según tu lógica
        cursor.execute("""
            UPDATE usuarios
            SET nivel_actual = ?, progreso = ?, updated_at = ?
            WHERE id = ?
        """, (nivel_actual, progreso, datetime.now(), data.usuario_id))
        conn.commit()
        vidas_restantes = None
    else:
        # ❌ Error: restar una vida del usuario (tabla usuarios.vidas)
        cursor.execute("SELECT vidas FROM usuarios WHERE id = ?", (data.usuario_id,))
        row = cursor.fetchone()
        if not row:
            cursor.close()
            raise HTTPException(status_code=404, detail="Usuario no encontrado")

        vidas_actual = row[0] if row[0] is not None else 0
        if vidas_actual > 0:
            nuevas = vidas_actual - 1
            cursor.execute("""
                UPDATE usuarios
                SET vidas = ?, updated_at = ?
                WHERE id = ?
            """, (nuevas, datetime.now(), data.usuario_id))
            # Registrar en historial_vidas
            cursor.execute("""
                INSERT INTO historial_vidas (usuario_id, cambio, motivo)
                VALUES (?, ?, ?)
            """, (data.usuario_id, -1, 'Respuesta incorrecta'))
            conn.commit()
            vidas_restantes = nuevas
        else:
            vidas_restantes = 0

    cursor.close()

    return RespuestaOutput(
        correcta=acierto,
        nivel_actual=nivel_actual if acierto else usuario[0],
        progreso=progreso if acierto else usuario[1],
        vidas_restantes=vidas_restantes,
        siguiente_pregunta_id=siguiente_pregunta_id if acierto else None
    )
