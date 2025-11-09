from fastapi import APIRouter, HTTPException
from db import conn
from models import Nivel, NivelDetalle

router = APIRouter()

# 🔹 Listar todos los niveles con puntos requeridos
@router.get("/", response_model=list[Nivel])
def listar_niveles(rama_id: int = None, rama_nombre: str = None):
    cursor = conn.cursor()
    niveles = []

    # Priority: if rama_nombre provided, use it; else if rama_id provided, resolve its name.
    if rama_nombre:
        search_name = rama_nombre

        # Buscamos niveles cuyo nombre incluya el nombre de la rama (case-insensitive)
        cursor.execute('''
            SELECT id, nombre, puntos_requeridos
            FROM niveles
            WHERE LOWER(nombre) LIKE '%' + LOWER(?) + '%'
            ORDER BY id
        ''', (search_name,))
        niveles = cursor.fetchall()

        # Si no encontramos niveles por nombre, intentamos buscar por preguntas
        if not niveles:
            cursor.execute('''
                SELECT DISTINCT n.id, n.nombre, n.puntos_requeridos
                FROM niveles n
                JOIN preguntas p ON p.nivel_id = n.id
                JOIN ramas r ON p.rama_id = r.id
                WHERE LOWER(r.nombre) LIKE '%' + LOWER(?) + '%'
                ORDER BY n.id
            ''', (search_name,))
            niveles = cursor.fetchall()

    elif rama_id is None:
        cursor.execute("SELECT id, nombre, puntos_requeridos FROM niveles ORDER BY id")
        niveles = cursor.fetchall()
    else:
        # Resolve rama name and run same logic as rama_nombre
        cursor.execute("SELECT nombre FROM ramas WHERE id = ?", (rama_id,))
        rama_row = cursor.fetchone()
        if not rama_row:
            cursor.close()
            raise HTTPException(status_code=404, detail="Rama no encontrada")
        search_name = rama_row[0]

        cursor.execute('''
            SELECT id, nombre, puntos_requeridos
            FROM niveles
            WHERE LOWER(nombre) LIKE '%' + LOWER(?) + '%'
            ORDER BY id
        ''', (search_name,))
        niveles = cursor.fetchall()

        if not niveles:
            cursor.execute('''
                SELECT DISTINCT n.id, n.nombre, n.puntos_requeridos
                FROM niveles n
                JOIN preguntas p ON p.nivel_id = n.id
                WHERE p.rama_id = ?
                ORDER BY n.id
            ''', (rama_id,))
            niveles = cursor.fetchall()

    cursor.close()

    return [
        {"id": row[0], "nombre": row[1], "puntos": row[2]}
        for row in niveles
    ]


@router.get('/rama/{rama_id}', response_model=list[Nivel])
def listar_niveles_por_rama(rama_id: int):
    cursor = conn.cursor()
    # Devolvemos los niveles que tengan al menos una pregunta asociada a la rama indicada
    cursor.execute('''
        SELECT DISTINCT n.id, n.nombre, n.puntos_requeridos
        FROM niveles n
        JOIN preguntas p ON p.nivel_id = n.id
        WHERE p.rama_id = ?
        ORDER BY n.id
    ''', (rama_id,))
    niveles = cursor.fetchall()
    cursor.close()

    return [{"id": row[0], "nombre": row[1], "puntos": row[2]} for row in niveles]

# 🔸 Obtener detalles enriquecidos de un nivel específico
@router.get("/{nivel_id}", response_model=NivelDetalle)
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
