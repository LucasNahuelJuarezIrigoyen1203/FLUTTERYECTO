INSERT INTO ramas (nombre)
VALUES 
  ('Aplicaciones Moviles'),
  ('Web'),
  ('Desktop');


INSERT INTO dificultades (nombre, multiplicador)
VALUES 
  ('Facil', 1.0),
  ('Intermedio', 1.5),
  ('Difícil', 2.0);


-- Aplicaciones Móviles (rama_id = 1)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Aplicaciones Moviles', 100, 1),
  ('Nivel 2 - Aplicaciones Moviles', 200, 1),
  ('Nivel 3 - Aplicaciones Moviles', 300, 1);

-- Redes (rama_id = 2)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Web', 100, 2),
  ('Nivel 2 - Web', 200, 2),
  ('Nivel 3 - Web', 300, 2);

-- Destock (rama_id = 3)
INSERT INTO niveles (nombre, puntos_requeridos, ramas_id)
VALUES 
  ('Nivel 1 - Desktop', 100, 3),
  ('Nivel 2 - Desktop', 200, 3),
  ('Nivel 3 - Desktop', 300, 3);

INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
  ('¿Que lenguaje de programacion utiliza Flutter?', 1, 1, 1),
  ('¿Que son los widgets en Flutter?', 1, 1, 1),
  ('¿Cual tipo de widget se usa cuando el contenido cambia durante la ejecucion?', 1, 1, 1),
  ('¿Que funcion inicia la ejecucion de la aplicación Flutter?', 1, 1, 1),
  ('¿Que widget se usa para iniciar una aplicación con estilo Material Design?', 1, 1, 1),
  ('¿Que widget sirve como base para crear la estructura visual principal de una pantalla?', 1, 1, 1),
  ('¿Que widget se usa para mostrar texto en Flutter?', 1, 1, 1),
  ('¿Que widget muestra una imagen en la interfaz?', 1, 1, 1),
  ('¿Que widget usarias para agregar fondo y margen a otro widget?', 1, 1, 1),
  ('Si quieres colocar elementos uno debajo del otro, ¿que widget usas?', 1, 1, 1);


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
(2, 'Libreriaas externas', 0),
(2, 'Archivos de configuracon', 0);

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
