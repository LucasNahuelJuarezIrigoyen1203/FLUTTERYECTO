from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

# 🧬 Base para usuario
class UsuarioBase(BaseModel):
    nombre: str
    correo: EmailStr

# 🧬 Usuario completo (usado en consultas internas)
class Usuario(BaseModel):
    id: int
    nombre: str
    correo: EmailStr

# 🧬 Para crear usuario
class UsuarioCreate(UsuarioBase):
    contrasena: str

# 🧬 Para responder usuario (con timestamps y estado)
class UsuarioResponse(UsuarioBase):
    id: int
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    activo: Optional[bool] = True

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
