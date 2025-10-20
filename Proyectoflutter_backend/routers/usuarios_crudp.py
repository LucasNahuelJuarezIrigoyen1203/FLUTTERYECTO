from fastapi import APIRouter, HTTPException, Request
from models import UsuarioCreate, UsuarioResponse, UsuarioUpdate, LoginRequest
from db import conn
from datetime import datetime
import bcrypt

router = APIRouter()

# 🔁 GET /usuarios — Listar todos los usuarios activos
@router.get("/usuarios", response_model=list[UsuarioResponse])
def listar_usuarios():
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, correo, created_at, updated_at, activo FROM usuarios WHERE activo = 1")
    rows = cursor.fetchall()
    return [UsuarioResponse(
        id=r[0], nombre=r[1], correo=r[2],
        created_at=r[3], updated_at=r[4], activo=r[5]
    ) for r in rows]

# 🔁 GET /usuarios/{id} — Obtener usuario por ID
@router.get("/usuarios/{id}", response_model=UsuarioResponse)
def obtener_usuario(id: int):
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, correo, created_at, updated_at, activo FROM usuarios WHERE id = ?", (id,))
    r = cursor.fetchone()
    if not r:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return UsuarioResponse(
        id=r[0], nombre=r[1], correo=r[2],
        created_at=r[3], updated_at=r[4], activo=r[5]
    )

# 🔁 POST /usuarios — Crear nuevo usuario
@router.post("/usuarios", response_model=UsuarioResponse)
def crear_usuario(usuario: UsuarioCreate):
    cursor = conn.cursor()
    hashed = bcrypt.hashpw(usuario.contrasena.encode('utf-8'), bcrypt.gensalt())
    try:
        cursor.execute(
            "INSERT INTO usuarios (nombre, correo, contraseña, activo) VALUES (?, ?, ?, ?)",
            (usuario.nombre, usuario.correo, hashed.decode('utf-8'), 1)
        )
        conn.commit()

        cursor.execute("SELECT id, nombre, correo, created_at, updated_at, activo FROM usuarios WHERE id = SCOPE_IDENTITY()")
        r = cursor.fetchone()

        cursor.execute(
            "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
            (r[0], 'usuarios', 'registro')
        )
        conn.commit()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error al registrar: {str(e)}")

# 🔁 PUT /usuarios/{id} — Actualizar usuario
@router.put("/usuarios/{id}", response_model=UsuarioResponse)
def actualizar_usuario(id: int, datos: UsuarioUpdate):
    cursor = conn.cursor()
    campos = []
    valores = []

    if datos.nombre:
        campos.append("nombre = ?")
        valores.append(datos.nombre)
    if datos.correo:
        campos.append("correo = ?")
        valores.append(datos.correo)
    if datos.contrasena:
        hashed = bcrypt.hashpw(datos.contrasena.encode('utf-8'), bcrypt.gensalt())
        campos.append("contraseña = ?")
        valores.append(hashed.decode('utf-8'))
    if datos.activo is not None:
        campos.append("activo = ?")
        valores.append(datos.activo)

    campos.append("updated_at = ?")
    valores.append(datetime.now())

    if not campos:
        raise HTTPException(status_code=400, detail="No se enviaron datos para actualizar")

    valores.append(id)
    query = f"UPDATE usuarios SET {', '.join(campos)} WHERE id = ?"
    cursor.execute(query, valores)
    conn.commit()

    cursor.execute("SELECT id, nombre, correo, created_at, updated_at, activo FROM usuarios WHERE id = ?", (id,))
    r = cursor.fetchone()
    return UsuarioResponse(
        id=r[0], nombre=r[1], correo=r[2],
        created_at=r[3], updated_at=r[4], activo=r[5]
    )

# 🔁 DELETE /usuarios/{id} — Desactivar usuario (soft delete)
@router.delete("/usuarios/{id}")
def desactivar_usuario(id: int):
    cursor = conn.cursor()
    cursor.execute("UPDATE usuarios SET activo = 0, updated_at = GETDATE() WHERE id = ?", (id,))
    conn.commit()

    cursor.execute(
        "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
        (id, 'usuarios', 'desactivado')
    )
    conn.commit()

    return {"mensaje": f"Usuario {id} desactivado correctamente"}

# 🔁 PATCH /usuarios/{id}/activar — Reactivar usuario
@router.patch("/usuarios/{id}/activar")
def reactivar_usuario(id: int):
    cursor = conn.cursor()
    cursor.execute("UPDATE usuarios SET activo = 1, updated_at = GETDATE() WHERE id = ?", (id,))
    conn.commit()

    cursor.execute(
        "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
        (id, 'usuarios', 'reactivado')
    )
    conn.commit()

    return {"mensaje": f"Usuario {id} reactivado correctamente"}

# 🔁 POST /login — Login con IP y dispositivo detectados automáticamente
@router.post("/login", response_model=UsuarioResponse)
def login(datos: LoginRequest, request: Request):
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, nombre, correo, contraseña, created_at, updated_at, activo FROM usuarios WHERE correo = ? AND activo = 1",
        (datos.correo,)
    )
    usuario = cursor.fetchone()

    if not usuario:
        raise HTTPException(status_code=404, detail="Usuario no encontrado o inactivo")

    if not bcrypt.checkpw(datos.contrasena.encode('utf-8'), usuario[3].encode('utf-8')):
        raise HTTPException(status_code=401, detail="Contraseña incorrecta")

    ip = request.headers.get("x-forwarded-for", request.client.host)
    dispositivo = request.headers.get("user-agent")

    cursor.execute(
        "INSERT INTO sesiones (usuario_id, ip, dispositivo) VALUES (?, ?, ?)",
        (usuario[0], ip, dispositivo)
    )
    conn.commit()

    cursor.execute(
        "INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento) VALUES (?, ?, ?)",
        (usuario[0], 'usuarios', 'login_exitoso')
    )
    conn.commit()

    return UsuarioResponse(
        id=usuario[0], nombre=usuario[1], correo=usuario[2],
        created_at=usuario[4], updated_at=usuario[5], activo=usuario[6]
    )
