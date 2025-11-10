INSERT INTO ramas (nombre)
VALUES 
  ('Aplicaciones Móviles'),
  ('Redes'),
  ('Destock');


INSERT INTO dificultades (nombre, multiplicador)
VALUES 
  ('Fácil', 1.0),
  ('Intermedio', 1.5),
  ('Difícil', 2.0);


-- Aplicaciones Móviles (rama_id = 1)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Aplicaciones Móviles', 100, 1),
  ('Nivel 2 - Aplicaciones Móviles', 200, 1),
  ('Nivel 3 - Aplicaciones Móviles', 300, 1);

-- Redes (rama_id = 2)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Redes', 100, 2),
  ('Nivel 2 - Redes', 200, 2),
  ('Nivel 3 - Redes', 300, 2);

-- Destock (rama_id = 3)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Destock', 100, 3),
  ('Nivel 2 - Destock', 200, 3),
  ('Nivel 3 - Destock', 300, 3);

INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
  ('¿Qué lenguaje de programación utiliza Flutter?', 1, 1, 1),
  ('¿Qué son los widgets en Flutter?', 1, 1, 1),
  ('¿Cuál tipo de widget se usa cuando el contenido cambia durante la ejecución?', 1, 1, 1),
  ('¿Qué función inicia la ejecución de la aplicación Flutter?', 1, 1, 1),
  ('¿Qué widget se usa para iniciar una aplicación con estilo Material Design?', 1, 1, 1),
  ('¿Qué widget sirve como base para crear la estructura visual principal de una pantalla?', 1, 1, 1),
  ('¿Qué widget se usa para mostrar texto en Flutter?', 1, 1, 1),
  ('¿Qué widget muestra una imagen en la interfaz?', 1, 1, 1),
  ('¿Qué widget usarías para agregar fondo y margen a otro widget?', 1, 1, 1),
  ('Si quieres colocar elementos uno debajo del otro, ¿qué widget usas?', 1, 1, 1);


-- Pregunta 1
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(1, 'Java', 0),
(1, 'Dart', 1),
(1, 'Kotlin', 0),
(1, 'Swift', 0);

-- Pregunta 2
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(2, 'Funciones que controlan la red', 0),
(2, 'Bloques básicos de la interfaz', 1),
(2, 'Librerías externas', 0),
(2, 'Archivos de configuración', 0);

-- Pregunta 3
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(3, 'StatelessWidget', 0),
(3, 'StatefulWidget', 1),
(3, 'MainWidget', 0),
(3, 'ChangeWidget', 0);

-- Pregunta 4
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(4, 'startApp()', 0),
(4, 'runApp()', 1),
(4, 'begin()', 0),
(4, 'startFlutter()', 0);

-- Pregunta 5
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(5, 'AppRoot', 0),
(5, 'MaterialApp', 1),
(5, 'FlutterApp', 0),
(5, 'DesignApp', 0);

-- Pregunta 6
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(6, 'Container', 0),
(6, 'Scaffold', 1),
(6, 'Column', 0),
(6, 'Body', 0);

-- Pregunta 7
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(7, 'Label', 0),
(7, 'Text', 1),
(7, 'Title', 0),
(7, 'Paragraph', 0);

-- Pregunta 8
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(8, 'Picture', 0),
(8, 'Image', 1),
(8, 'Photo', 0),
(8, 'Asset', 0);

-- Pregunta 9
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(9, 'Box', 0),
(9, 'Container', 1),
(9, 'Scaffold', 0),
(9, 'Frame', 0);

-- Pregunta 10
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(10, 'Row', 0),
(10, 'Stack', 0),
(10, 'Column', 1),
(10, 'Layout', 0);
