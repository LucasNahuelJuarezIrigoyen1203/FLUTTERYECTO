from pydantic import BaseModel, EmailStr

class Usuario(BaseModel):
    id: int
    nombre: str
    correo: EmailStr

class UsuarioCreate(BaseModel):
    nombre: str
    correo: EmailStr
    contrasena: str
