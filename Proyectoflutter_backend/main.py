from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import mascotas
from routers import usuarios_crudp, login, vidas_crudp, respuestas, preguntas, niveles, estado_usuario,ramas


app = FastAPI(
    title="COSO DEL COSITO DEL COSO",
    description="KHROMA APLICATION :D",
    version="1.0.0"
)

# Middleware CORS para permitir conexión desde Flutter Web
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # o restringir a tu localhost
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
app.include_router(vidas_crudp.router, tags=["Vidas"])
app.include_router(preguntas.router, prefix="/niveles", tags=["Preguntas"])
app.include_router(estado_usuario.router, prefix="/estado_usuario", tags=["Estado Usuario"])
app.include_router(ramas.router)
app.include_router(mascotas.router, prefix="/mascotas", tags=["Mascotas"])
