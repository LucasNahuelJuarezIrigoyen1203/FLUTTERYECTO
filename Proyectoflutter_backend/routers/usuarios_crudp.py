from fastapi import APIRouter, HTTPException
from models import UsuarioCreate, UsuarioResponse, RamaEstado
from db import conn
from datetime import datetime
import bcrypt

router = APIRouter()

@router.post("/usuarios", response_model=UsuarioResponse)
def crear_usuario(usuario: UsuarioCreate):
    try:
        cursor = conn.cursor()

        # Verificar si el correo ya está registrado
        cursor.execute("SELECT id FROM usuarios WHERE correo = ?", (usuario.correo,))
        if cursor.fetchone():
            cursor.close()
            raise HTTPException(status_code=409, detail="El correo ya está registrado")

        # Hashear la contraseña
        hashed = bcrypt.hashpw(usuario.contrasena.encode('utf-8'), bcrypt.gensalt())

        # Insertar usuario
        cursor.execute("""
            INSERT INTO usuarios (nombre, correo, contraseña, vidas, nivel_actual, progreso, activo, created_at)
            OUTPUT INSERTED.id
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            usuario.nombre,
            usuario.correo,
            hashed.decode('utf-8'),
            usuario.vidas,
            usuario.nivel_actual,
            usuario.progreso,
            1,
            datetime.now()
        ))
        usuario_id = cursor.fetchone()[0]

        # Inicializar estado por rama (obteniendo id y nombre)
        cursor.execute("SELECT id, nombre FROM ramas")
        ramas = cursor.fetchall()

        for rama in ramas:
            cursor.execute("""
                INSERT INTO usuario_estado (usuario_id, rama_id, nivel_actual, progreso, activo, vidas, created_at)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """, (
                usuario_id,
                rama[0],
                1,       # nivel_actual
                0.0,     # progreso
                1,       # activo
                5,       # vidas
                datetime.now()
            ))

        # Obtener datos del usuario recién creado
        cursor.execute("""
            SELECT id, nombre, correo, vidas, nivel_actual, progreso, created_at, updated_at, activo
            FROM usuarios
            WHERE id = ?
        """, (usuario_id,))
        r = cursor.fetchone()

        # Obtener ramas_estado para la respuesta
        # Obtener ramas_estado con el nombre de la rama para la respuesta
        cursor.execute("""
            SELECT ue.rama_id, r.nombre, ue.nivel_actual, ue.progreso, ue.activo, ue.vidas
            FROM usuario_estado ue
            JOIN ramas r ON r.id = ue.rama_id
            WHERE ue.usuario_id = ?
        """, (usuario_id,))
        ramas_estado = [
            RamaEstado(
                rama_id=row[0],
                rama_nombre=row[1],
                nivel_actual=row[2],
                progreso=row[3],
                activo=bool(row[4]),
                vidas=row[5]
            )
            for row in cursor.fetchall()
        ]

        # Registrar evento en auditoría
        cursor.execute("""
            INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
            VALUES (?, ?, ?)
        """, (usuario_id, 'usuarios', 'registro'))

        conn.commit()
        cursor.close()

        return UsuarioResponse(
            id=r[0], nombre=r[1], correo=r[2],
            vidas=r[3], nivel_actual=r[4], progreso=r[5],
            created_at=r[6], updated_at=r[7], activo=r[8],
            ramas_estado=ramas_estado
        )

    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error al registrar: {str(e)}")
