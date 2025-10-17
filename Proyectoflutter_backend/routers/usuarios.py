from fastapi import APIRouter, HTTPException
from db import conn
from models import Usuario, UsuarioCreate
import bcrypt

router = APIRouter()

@router.get("/usuarios", response_model=list[Usuario])
def listar_usuarios():
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, correo FROM usuarios")
    rows = cursor.fetchall()
    return [Usuario(id=r[0], nombre=r[1], correo=r[2]) for r in rows]

@router.post("/usuarios", response_model=Usuario)
def crear_usuario(usuario: UsuarioCreate):
    cursor = conn.cursor()
    hashed = bcrypt.hashpw(usuario.contraseña.encode('utf-8'), bcrypt.gensalt())
    try:
        cursor.execute(
            "INSERT INTO usuarios (nombre, correo, contraseña) VALUES (?, ?, ?)",
            usuario.nombre, usuario.correo, hashed.decode('utf-8')
        )
        conn.commit()
        cursor.execute("SELECT TOP 1 id, nombre, correo FROM usuarios ORDER BY id DESC")
        r = cursor.fetchone()
        return Usuario(id=r[0], nombre=r[1], correo=r[2])
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
