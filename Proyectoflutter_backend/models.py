from __future__ import annotations
from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime

# 🧍 Base para usuario
class UsuarioBase(BaseModel):
    nombre: str
    correo: EmailStr

# 🧍 Usuario completo (usado en consultas internas)
class Usuario(BaseModel):
    id: int
    nombre: str
    correo: EmailStr
    vidas: int
    nivel_actual: int
    progreso: float

# 🧍 Crear usuario
class UsuarioCreate(BaseModel):
    nombre: str
    correo: str
    contrasena: str
    vidas: int = 5
    nivel_actual: int = 1
    progreso: float = 0.0

# 🧍 Actualizar usuario
class UsuarioUpdate(BaseModel):
    nombre: Optional[str] = None
    correo: Optional[str] = None
    contrasena: Optional[str] = None
    activo: Optional[bool] = None
    vidas: Optional[int] = None
    nivel_actual: Optional[int] = None
    progreso: Optional[float] = None

# 🧍 Respuesta de usuario (usada en endpoints)
class UsuarioResponse(BaseModel):
    id: int
    nombre: str
    correo: str
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    activo: bool
    vidas: int
    nivel_actual: int
    progreso: float
    ramas_estado: list[RamaEstado]

# 🧬 Login
class LoginRequest(BaseModel):
    correo: EmailStr
    contrasena: str

# 🧬 Evaluación de nivel
class EvaluacionNivel(BaseModel):
    puntaje_obtenido: int
    puntaje_maximo: int
    nivel: int
    tema: str
    modo: str

# 🧬 Vida
class VidaCreate(BaseModel):
    puntos: int = 100

class VidaUpdate(BaseModel):
    puntos: Optional[int] = None
    activa: Optional[bool] = None

class VidaResponse(BaseModel):
    id: int
    usuario_id: int
    puntos: int
    created_at: datetime
    updated_at: datetime
    activa: bool

# 🧬 Respuesta a pregunta
class RespuestaInput(BaseModel):
    usuario_id: int
    pregunta_id: int
    opcion_seleccionada: int

class RespuestaOutput(BaseModel):
    correcta: bool
    nivel_actual: int
    progreso: float
    vidas_restantes: Optional[int] = None

# 🧠 Preguntas y opciones
class Opcion(BaseModel):
    id: int
    texto: str

class PreguntaConOpciones(BaseModel):
    id: int
    texto: str
    opciones: list[Opcion]

# 📊 Niveles
class Nivel(BaseModel):
    id: int
    nombre: str
    puntos: int

class NivelDetalle(BaseModel):
    id: int
    nombre: str
    puntos: int
    rama: str
    dificultad: str
    multiplicador: float

# 🌿 Estado por rama
class RamaEstado(BaseModel):
    rama_id: int
    rama_nombre: str
    nivel_actual: int
    progreso: float
    activo: Optional[bool] = True
    vidas: Optional[int] = 5

    
# 🐾 Mascota y estado de usuario
class Mascota(BaseModel):
    id: int
    nombre: str
    imagen: str

class RamaEstado(BaseModel):
    rama_id: int
    rama_nombre: str
    nivel_actual: int
    progreso: float

class EstadoUsuarioResponse(BaseModel):
    usuario_id: int
    nombre: str
    correo: str
    vidas: int
    mascota_activa: Optional[Mascota]
    ramas_estado: List[RamaEstado]
