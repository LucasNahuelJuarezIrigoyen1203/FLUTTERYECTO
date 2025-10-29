from fastapi import APIRouter, HTTPException, Request
from models import LoginRequest, UsuarioResponse, RamaEstado
from db import conn
import bcrypt

router = APIRouter()

@router.post("/login", response_model=UsuarioResponse)
def login(datos: LoginRequest, request: Request):
    cursor = conn.cursor()

    # 🔍 Buscar usuario por correo
    cursor.execute("""
        SELECT id, nombre, correo, contraseña, created_at, updated_at, activo
        FROM usuarios
        WHERE correo = ?
    """, (datos.correo,))
    usuario = cursor.fetchone()

    if not usuario:
        cursor.close()
        raise HTTPException(status_code=404, detail="Usuario no registrado")

    if not usuario[6]:  # activo == 0
        cursor.close()
        raise HTTPException(status_code=403, detail="Usuario inactivo. Verificá tu cuenta o contactá soporte")

    # 🔐 Validar contraseña
    if not bcrypt.checkpw(datos.contrasena.encode('utf-8'), usuario[3].encode('utf-8')):
        cursor.close()
        raise HTTPException(status_code=401, detail="Contraseña incorrecta")

    # 🌐 Detectar IP y dispositivo
    ip = request.headers.get("x-forwarded-for") or request.client.host
    dispositivo = request.headers.get("user-agent")

    # 📝 Registrar sesión
    cursor.execute("""
        INSERT INTO sesiones (usuario_id, ip, dispositivo)
        VALUES (?, ?, ?)
    """, (usuario[0], ip, dispositivo))

    # 🧾 Registrar evento
    cursor.execute("""
        INSERT INTO auditoria_eventos (usuario_id, tabla_afectada, tipo_evento)
        VALUES (?, ?, ?)
    """, (usuario[0], 'usuarios', 'login_exitoso'))

    # 🧠 Obtener vidas actuales
    cursor.execute("""
        SELECT cantidad FROM vidas
        WHERE usuario_id = ?
        ORDER BY updated_at DESC
    """, (usuario[0],))
    vidas_row = cursor.fetchone()
    vidas = vidas_row[0] if vidas_row else 5  # default inicial

    # 📊 Obtener estado por rama
    cursor.execute("""
        SELECT r.id, r.nombre,
            ISNULL(MAX(n.nivel_id), 1) AS nivel_actual,
            CAST(SUM(CASE WHEN p.respondio_correctamente = 1 THEN 1 ELSE 0 END) AS FLOAT) /
            NULLIF(COUNT(p.id), 0) AS progreso
        FROM ramas r
        LEFT JOIN preguntas q ON q.rama_id = r.id
        LEFT JOIN progreso p ON p.pregunta_id = q.id AND p.usuario_id = ?
        LEFT JOIN preguntas n ON p.pregunta_id = n.id
        GROUP BY r.id, r.nombre
    """, (usuario[0],))
    ramas_estado = []
    for fila in cursor.fetchall():
        ramas_estado.append(RamaEstado(
            rama_id=fila[0],
            rama_nombre=fila[1],
            nivel_actual=int(fila[2]) if fila[2] is not None else 1,
            progreso=float(fila[3]) if fila[3] is not None else 0.0
        ))

    # 🧮 Calcular nivel y progreso global
    nivel_actual = max((r.nivel_actual for r in ramas_estado), default=1)
    progreso = sum((r.progreso for r in ramas_estado)) / len(ramas_estado) if ramas_estado else 0.0

    conn.commit()
    cursor.close()

    return UsuarioResponse(
        id=usuario[0],
        nombre=usuario[1],
        correo=usuario[2],
        created_at=usuario[4],
        updated_at=usuario[5],
        activo=usuario[6],
        vidas=vidas,
        nivel_actual=nivel_actual,
        progreso=progreso,
        ramas_estado=ramas_estado
    )
