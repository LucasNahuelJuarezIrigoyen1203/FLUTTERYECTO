from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import usuarios_crudp, login, vidas_crudp 

app = FastAPI(
    title="Proyectoflutter API",
    description="Backend modular para Proyectoflutter",
    version="1.0.0"
)

# Middleware CORS para permitir conexión desde Flutter Web
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Podés restringir a ["http://localhost:7237"] si querés
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Rutas
app.include_router(usuarios_crudp.router)
app.include_router(login.router)
app.include_router(vidas_crudp.router) 
