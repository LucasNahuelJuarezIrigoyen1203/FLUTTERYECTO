from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
from db import conn
import bcrypt
from models import LoginRequest

router = APIRouter()


@router.post("/login")
def login(datos: LoginRequest):
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, correo, contraseña FROM usuarios WHERE correo = ?", (datos.correo,))
    usuario = cursor.fetchone()

    if not usuario:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    contrasena_hash = usuario[3]
    if not bcrypt.checkpw(datos.contrasena.encode('utf-8'), contrasena_hash.encode('utf-8')):
        raise HTTPException(status_code=401, detail="Contraseña incorrecta")

    return {
        "id": usuario[0],
        "nombre": usuario[1],
        "correo": usuario[2],
        "mensaje": "Login exitoso"
    }
