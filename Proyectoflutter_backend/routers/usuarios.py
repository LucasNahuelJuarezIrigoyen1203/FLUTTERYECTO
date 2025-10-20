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

@router.post("/usuarios")
def crear_usuario(usuario: UsuarioCreate):
    cursor = conn.cursor()
    hashed = bcrypt.hashpw(usuario.contrasena.encode('utf-8'), bcrypt.gensalt())
    try:
        cursor.execute(
            "INSERT INTO usuarios (nombre, correo, contraseña, activo) VALUES (?, ?, ?, ?)",
            (usuario.nombre, usuario.correo, hashed.decode('utf-8'), 1)
        )
        conn.commit()

        cursor.execute("SELECT id, nombre, correo FROM usuarios WHERE id = SCOPE_IDENTITY()")
        r = cursor.fetchone()

        # Auditoría (opcional)
        cursor.execute(
            "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
            (r[0], 'usuarios', 'registro')
        )
        conn.commit()

        return {
            "usuario": {
                "id": r[0],
                "nombre": r[1],
                "correo": r[2]
            },
            "mensaje": "Registro exitoso"
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error al registrar: {str(e)}")



