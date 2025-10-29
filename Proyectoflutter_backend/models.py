from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

# Base para usuario
class UsuarioBase(BaseModel):
    nombre: str
    correo: EmailStr

# Usuario completo (usado en consultas internas)
class Usuario(BaseModel):
    id: int
    nombre: str
    correo: EmailStr
    vidas: int
    nivel_actual: int
    progreso: float

# Para crear usuario
class UsuarioCreate(BaseModel):
    nombre: str
    correo: str
    contrasena: str
    vidas: int = 5
    nivel_actual: int = 1
    progreso: float = 0.0

# Para responder al frontend
class UsuarioResponse(BaseModel):
    id: int
    nombre: str
    correo: str
    created_at: datetime | None
    updated_at: datetime | None
    activo: bool
    vidas: int
    nivel_actual: int
    progreso: float

# Para actualizar usuario
class UsuarioUpdate(BaseModel):
    nombre: str | None = None
    correo: str | None = None
    contrasena: str | None = None
    activo: bool | None = None
    vidas: int | None = None
    nivel_actual: int | None = None
    progreso: float | None = None
    
# 🧬 Para login
class LoginRequest(BaseModel):
    correo: EmailStr
    contrasena: str

# 🧬 Evaluación de nivel (usado en sistema de vidas)
class EvaluacionNivel(BaseModel):
    puntaje_obtenido: int
    puntaje_maximo: int
    nivel: int
    tema: str
    modo: str

# 🧬 Crear vida (uniforme)
class VidaCreate(BaseModel):
    puntos: int = 100  # Valor fijo para todas las vidas

# 🧬 Actualizar vida
class VidaUpdate(BaseModel):
    puntos: Optional[int] = None
    activa: Optional[bool] = None

# 🧬 Respuesta de vida
class VidaResponse(BaseModel):
    id: int
    usuario_id: int
    puntos: int
    created_at: datetime
    updated_at: datetime
    activa: bool


class RespuestaInput(BaseModel):
    usuario_id: int
    pregunta_id: int
    opcion_seleccionada: int

class RespuestaOutput(BaseModel):
    correcta: bool
    nivel_actual: int
    progreso: float
    vidas_restantes: int | None = None

class Opcion(BaseModel):
    id: int
    texto: str

class PreguntaConOpciones(BaseModel):
    id: int
    texto: str
    opciones: list[Opcion]
