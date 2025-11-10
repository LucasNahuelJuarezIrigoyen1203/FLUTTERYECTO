INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
('¿Qué patrón de diseño separa la lógica de negocio de la interfaz de usuario para mejorar la mantenibilidad?', 3, 2, 8),
('¿Cuál es el término para la técnica de diseño que asegura que la UI se adapte a diferentes tamaños de ventana?', 3, 2, 8),
('¿Cómo se llama el proceso de enviar datos desde la UI a una capa de lógica de negocio o modelo?', 3, 2, 8),
('¿Qué mecanismo se usa típicamente para evitar que una aplicación de escritorio se "congele" al realizar una operación larga?', 3, 2, 8),
('¿Qué tipo de control es ideal para mostrar datos tabulares grandes con capacidades de ordenación y filtrado?', 3, 2, 8),
('¿Qué concepto se aplica para configurar un control para que un cambio en los datos se refleje automáticamente en la UI?', 3, 2, 8),
('¿Qué tipo de diálogo se usa para notificar al usuario sobre un error crítico que requiere su atención inmediata?', 3, 2, 8),
('¿Qué significa el término "Thread de UI" o "Hilo de interfaz de usuario"?', 3, 2, 8),
('¿Qué componente de UI se utiliza a menudo para mostrar un progreso indeterminado de una operación en segundo plano?', 3, 2, 8);
('¿Cuál de estas es una limitación principal de una aplicación de escritorio en comparación con una web?', 3, 2, 8),

-- Pregunta 41
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(41, 'Model-View-Controller (MVC)', 1),
(41, 'Factory Pattern', 0),
(41, 'Singleton Pattern', 0),
(41, 'Observer Pattern', 0);    

-- Pregunta 42
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(42, 'Dynamic Sizing', 0),
(42, 'Anchoring y Docking', 1),
(42, 'Fixed Layout', 0),
(42, 'Absolute Positioning', 0);

-- Pregunta 43
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(43, 'Data Binding', 0),
(43, 'Data Flow', 0),
(43, 'Validation', 0),
(43, 'Data Submission', 1);

-- Pregunta 44
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(44, 'Hilos de Trabajo (Worker Threads)', 1),
(44, 'Bloqueo Asíncrono', 0),
(44, 'Polling Activo', 0),
(44, 'Timeouts', 0);

-- Pregunta 45
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(45, 'ListBox', 0),
(45, 'DataGrid / TableView', 1),
(45, 'ComboBox', 0),
(45, 'ListView', 0);

-- Pregunta 46
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(46, 'Data Serialization', 0),
(46, 'Data Mapping', 0),
(46, 'Data Linking', 0),
(46, 'Data Binding', 1);

-- Pregunta 47
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(47, 'Confirmation Dialog', 0),
(47, 'Modal Dialog', 1),
(47, 'Information Dialog', 0),
(47, 'Non-Modal Dialog', 0);

-- Pregunta 48
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(48, 'El hilo que ejecuta lógica de negocio pesada.', 0),
(48, 'El único hilo permitido para manipular directamente los elementos de UI.', 1),
(48, 'Un hilo que maneja la persistencia de datos.', 0),
(48, 'Un hilo que solo maneja la entrada del teclado.', 0);

-- Pregunta 49
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(49, 'Mayor dificultad para distribuir actualizaciones automáticamente.', 1),
(49, 'La necesidad de compilación específica del sistema operativo.', 0),
(49, 'Acceso limitado a recursos del sistema operativo.', 0),
(49, 'Imposibilidad de usar bases de datos.', 0);

-- Pregunta 50
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(50, 'Activity Indicator', 0),
(50, 'Progress Bar (Indeterminada)', 1),
(50, 'Status Bar', 0),
(50, 'Timer', 0);