CREATE DATABASE Proyectoflutter;
GO

USE Proyectoflutter;
GO

-- Catálogo de mascotas
CREATE TABLE mascotas (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(500),
    activo BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
    imagen NVARCHAR(255);
);

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(100) NOT NULL,
    correo NVARCHAR(100) UNIQUE NOT NULL,
    contraseña NVARCHAR(255) NOT NULL,
    vidas INT DEFAULT 5,
    nivel_actual INT DEFAULT 1,
    progreso FLOAT DEFAULT 0.0,
    activo BIT DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL
    mascota_activa_id INT NULL FOREIGN KEY REFERENCES mascotas(id);

);

-- Tabla de ramas
CREATE TABLE ramas (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(100) NOT NULL
);

-- Tabla de niveles
CREATE TABLE niveles (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(50) NOT NULL,
    puntos_requeridos INT NOT NULL,
    ramas_id INT FOREIGN KEY REFERENCES ramas(id)
);

-- Tabla de dificultades
CREATE TABLE dificultades (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(50) NOT NULL,
    multiplicador FLOAT NOT NULL
);

-- Tabla de preguntas
CREATE TABLE preguntas (
    id INT PRIMARY KEY IDENTITY,
    texto NVARCHAR(500) NOT NULL,
    rama_id INT FOREIGN KEY REFERENCES ramas(id),
    dificultad_id INT FOREIGN KEY REFERENCES dificultades(id),
    nivel_id INT FOREIGN KEY REFERENCES niveles(id),
    activo BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME NULL
);

-- Tabla de respuestas
CREATE TABLE respuestas (
    id INT PRIMARY KEY IDENTITY,
    pregunta_id INT FOREIGN KEY REFERENCES preguntas(id),
    texto NVARCHAR(255) NOT NULL,
    es_correcta BIT NOT NULL
);



-- Condiciones de desbloqueo de mascotas
CREATE TABLE desbloqueos_mascotas (
    id INT PRIMARY KEY IDENTITY,
    mascota_id INT FOREIGN KEY REFERENCES mascotas(id),
    rama_id INT FOREIGN KEY REFERENCES ramas(id),
    dificultad_id INT NULL FOREIGN KEY REFERENCES dificultades(id),
    nivel_id INT NULL FOREIGN KEY REFERENCES niveles(id),
    condicion NVARCHAR(255) NULL
);

-- Mascotas desbloqueadas por usuario
CREATE TABLE usuarios_mascotas (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    mascota_id INT FOREIGN KEY REFERENCES mascotas(id),
    activa BIT DEFAULT 0,
    desbloqueada_en DATETIME DEFAULT GETDATE()
);

-- Vidas actuales del usuario
CREATE TABLE vidas (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    cantidad INT NOT NULL,
    ultima_recuperacion DATETIME NOT NULL,
    updated_at DATETIME NULL,
    CONSTRAINT chk_cantidad_positiva CHECK (cantidad >= 0)
);

-- Historial de cambios en vidas
CREATE TABLE historial_vidas (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    cambio INT NOT NULL,
    motivo NVARCHAR(255),
    fecha DATETIME DEFAULT GETDATE()
);

-- Observaciones del usuario
CREATE TABLE observaciones (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    texto NVARCHAR(500),
    fecha DATETIME DEFAULT GETDATE()
);

-- Progreso del usuario
CREATE TABLE progreso (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    pregunta_id INT FOREIGN KEY REFERENCES preguntas(id),
    respondio_correctamente BIT,
    fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT uq_progreso UNIQUE (usuario_id, pregunta_id)
);

-- Auditoría de eventos
CREATE TABLE auditoria_eventos (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    tabla_afectada NVARCHAR(100),
    tipo_evento NVARCHAR(50),
    fecha DATETIME DEFAULT GETDATE()
);

-- Logros y desbloqueos
CREATE TABLE logros (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(255)
);
--usuarios y sus logros 
CREATE TABLE usuarios_logros (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    logro_id INT FOREIGN KEY REFERENCES logros(id),
    fecha DATETIME DEFAULT GETDATE()
);

-- Sesiones de usuario
CREATE TABLE sesiones (
    id INT PRIMARY KEY IDENTITY,
    usuario_id INT FOREIGN KEY REFERENCES usuarios(id),
    ip NVARCHAR(50),
    dispositivo NVARCHAR(512),  -- Aumentado para evitar truncamiento
    fecha DATETIME DEFAULT GETDATE()
);

CREATE TABLE usuario_estado (
  id INT PRIMARY KEY IDENTITY(1,1),
  usuario_id INT NOT NULL,
  rama_id INT NOT NULL,
  nivel_actual INT DEFAULT 1,
  progreso FLOAT DEFAULT 0.0,
  activo BIT DEFAULT 1,
  vidas INT DEFAULT 5,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (rama_id) REFERENCES ramas(id)
);

-- Índices para rendimiento
CREATE INDEX idx_usuario_correo ON usuarios(correo);
CREATE INDEX idx_pregunta_rama ON preguntas(rama_id);
CREATE INDEX idx_vidas_usuario ON vidas(usuario_id);
CREATE INDEX idx_progreso_usuario ON progreso(usuario_id);
CREATE INDEX idx_mascota_usuario ON usuarios_mascotas(usuario_id);
CREATE INDEX idx_historial_vidas_usuario ON historial_vidas(usuario_id);
CREATE INDEX idx_sesiones_usuario ON sesiones(usuario_id);
