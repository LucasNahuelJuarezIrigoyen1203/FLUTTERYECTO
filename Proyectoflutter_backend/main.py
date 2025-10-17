# main.py

from fastapi import FastAPI
from routers import usuarios,login

app = FastAPI(
    title="Proyectoflutter API",
    description="Backend modular para Proyectoflutter",
    version="1.0.0"
)

app.include_router(usuarios.router)
app.include_router(login.router)