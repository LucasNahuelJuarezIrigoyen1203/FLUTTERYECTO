from fastapi import APIRouter
from fastapi.responses import JSONResponse
from db import conn  # Usamos la conexión global que ya definiste

router = APIRouter()

@router.get("/ramas")
def obtener_ramas():
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT id, nombre FROM ramas")
        rows = cursor.fetchall()
        cursor.close()

        ramas = [{"id": row.id, "nombre": row.nombre} for row in rows]
        return JSONResponse(content=ramas)

    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})
