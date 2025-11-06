from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import usuarios_crudp, login, vidas_crudp, respuestas, preguntas, niveles, estado_usuario, ramas

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

@app.get("/healthcheck")
def healthcheck():
    return {"status": "ok"}

# Rutas


app.include_router(respuestas.router, prefix="/respuestas", tags=["Respuestas"])
app.include_router(niveles.router, prefix="/niveles", tags=["Niveles"])
app.include_router(usuarios_crudp.router)
app.include_router(login.router)
app.include_router(vidas_crudp.router) 
app.include_router(preguntas.router, prefix="/preguntas", tags=["Preguntas"])
app.include_router(estado_usuario.router, prefix="/usuarios", tags=["Estado Usuario"])
app.include_router(ramas.router)
