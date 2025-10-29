from fastapi import APIRouter, HTTPException, Request
from models import UsuarioCreate, UsuarioResponse, UsuarioUpdate, LoginRequest
from db import conn
from datetime import datetime
import bcrypt

router = APIRouter()

# 🔁 GET /usuarios — Listar todos los usuarios activos
@router.get("/usuarios", response_model=list[UsuarioResponse])
def listar_usuarios():
    try:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE activo = 1
        """)
        rows = cursor.fetchall()
        cursor.close()

        return [UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        ) for r in rows]

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al listar usuarios: {str(e)}")

# 🔁 GET /usuarios/{id} — Obtener usuario por ID
@router.get("/usuarios/{id}", response_model=UsuarioResponse)
def obtener_usuario(id: int):
    try:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (id,))
        r = cursor.fetchone()
        cursor.close()

        if not r:
            raise HTTPException(status_code=404, detail="Usuario no encontrado")

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener usuario: {str(e)}")

# 🔁 POST /usuarios — Crear nuevo usuario
@router.post("/usuarios", response_model=UsuarioResponse)
def crear_usuario(usuario: UsuarioCreate):
    try:
        cursor = conn.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE correo = ?", (usuario.correo,))
        if cursor.fetchone():
            cursor.close()
            raise HTTPException(status_code=409, detail="El correo ya está registrado")

        hashed = bcrypt.hashpw(usuario.contrasena.encode('utf-8'), bcrypt.gensalt())

        cursor.execute("""
            INSERT INTO usuarios (nombre, correo, contraseña, activo, created_at)
            OUTPUT INSERTED.id
            VALUES (?, ?, ?, ?, ?)
        """, (usuario.nombre, usuario.correo, hashed.decode('utf-8'), 1, datetime.now()))
        usuario_id = cursor.fetchone()[0]

        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (usuario_id,))
        r = cursor.fetchone()

        cursor.execute("""
            INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
            VALUES (?, ?, ?)
        """, (usuario_id, 'usuarios', 'registro'))
        conn.commit()
        cursor.close()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )

    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error al registrar: {str(e)}")

# 🔁 PUT /usuarios/{id} — Actualizar usuario
@router.put("/usuarios/{id}", response_model=UsuarioResponse)
def actualizar_usuario(id: int, datos: UsuarioUpdate):
    try:
        cursor = conn.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE id = ?", (id,))
        if not cursor.fetchone():
            cursor.close()
            raise HTTPException(status_code=404, detail="Usuario no encontrado")

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
            cursor.close()
            raise HTTPException(status_code=400, detail="No se enviaron datos para actualizar")

        valores.append(id)
        query = f"UPDATE usuarios SET {', '.join(campos)} WHERE id = ?"
        cursor.execute(query, valores)
        conn.commit()

        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (id,))
        r = cursor.fetchone()

        cursor.execute("""
            INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
            VALUES (?, ?, ?)
        """, (id, 'usuarios', 'actualizacion'))
        conn.commit()
        cursor.close()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al actualizar usuario: {str(e)}")

# 🔁 DELETE /usuarios/{id} — Desactivar usuario (soft delete)
@router.delete("/usuarios/{id}", response_model=UsuarioResponse)
def desactivar_usuario(id: int):
    try:
        cursor = conn.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE id = ?", (id,))
        if not cursor.fetchone():
            cursor.close()
            raise HTTPException(status_code=404, detail="Usuario no encontrado")

        cursor.execute("UPDATE usuarios SET activo = 0, updated_at = ? WHERE id = ?", (datetime.now(), id))
        conn.commit()

        cursor.execute("""
            INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
            VALUES (?, ?, ?)
        """, (id, 'usuarios', 'desactivado'))
        conn.commit()

        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (id,))
        r = cursor.fetchone()
        cursor.close()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al desactivar usuario: {str(e)}")

# 🔁 PATCH /usuarios/{id}/activar — Reactivar usuario
@router.patch("/usuarios/{id}/activar", response_model=UsuarioResponse)
def reactivar_usuario(id: int):
    try:
        cursor = conn.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE id = ?", (id,))
        if not cursor.fetchone():
            cursor.close()
            raise HTTPException(status_code=404, detail="Usuario no encontrado")

        cursor.execute("UPDATE usuarios SET activo = 1, updated_at = ? WHERE id = ?", (datetime.now(), id))
        conn.commit()

        cursor.execute("""
            INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
            VALUES (?, ?, ?)
        """, (id, 'usuarios', 'reactivado'))
        conn.commit()

        cursor.execute("""
            SELECT id, nombre, correo, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (id,))
        r = cursor.fetchone()
        cursor.close()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            created_at=r[3], updated_at=r[4], activo=r[5]
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al reactivar usuario: {str(e)}")
