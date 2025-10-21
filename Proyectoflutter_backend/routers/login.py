from fastapi import APIRouter, HTTPException, Request
from models import LoginRequest, UsuarioResponse
from db import conn
import bcrypt

router = APIRouter()

@router.post("/login", response_model=UsuarioResponse)
def login(datos: LoginRequest, request: Request):
    cursor = conn.cursor()

    # Buscar usuario por correo
    cursor.execute(
        "SELECT id, nombre, correo, contraseña, created_at, updated_at, activo FROM usuarios WHERE correo = ?",
        (datos.correo,)
    )
    usuario = cursor.fetchone()

    if not usuario:
        raise HTTPException(status_code=404, detail="Usuario no registrado")

    if not usuario[6]:  # activo == 0
        raise HTTPException(status_code=403, detail="Usuario inactivo. Verificá tu cuenta o contactá soporte")

    # Validar contraseña
    if not bcrypt.checkpw(datos.contrasena.encode('utf-8'), usuario[3].encode('utf-8')):
        raise HTTPException(status_code=401, detail="Contraseña incorrecta")

    # Detectar IP y dispositivo
    ip = request.headers.get("x-forwarded-for") or request.client.host
    dispositivo = request.headers.get("user-agent")

    # Registrar sesión
    cursor.execute(
        "INSERT INTO sesiones (usuario_id, ip, dispositivo) VALUES (?, ?, ?)",
        (usuario[0], ip, dispositivo)
    )
    conn.commit()

    # Registrar evento
    cursor.execute(
        "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
        (usuario[0], 'usuarios', 'login_exitoso')
    )
    conn.commit()

    # Respuesta estructurada
    return UsuarioResponse(
        id=usuario[0],
        nombre=usuario[1],
        correo=usuario[2],
        created_at=usuario[4],
        updated_at=usuario[5],
        activo=usuario[6]
    )
