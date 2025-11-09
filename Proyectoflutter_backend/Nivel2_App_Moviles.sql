INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
  ('¿Qué método se usa para abrir una nueva pantalla?', 1, 2, 2),
  ('¿Qué widget se usa para escribir texto en un campo editable?', 1, 2, 2),
  ('¿Qué función actualiza la interfaz de un StatefulWidget?', 1, 2, 2),
  ('¿Con qué propiedad se define el estilo global (colores, tipografía) en un MaterialApp?', 1, 2, 2),
  ('¿Qué widget muestra una lista de elementos con desplazamiento vertical?', 1, 2, 2),
  ('¿Qué widget crea la barra superior con título en una pantalla Flutter?', 1, 2, 2),
  ('¿Cuál de estos widgets crea un botón flotante circular?', 1, 2, 2),
  ('¿Qué widget se usa para agregar espacio alrededor de otro widget?', 1, 2, 2),
  ('¿Qué widget usarías para dejar un espacio vacío entre dos elementos?', 1, 2, 2),
  ('¿Cómo se llama la técnica que usa nombres para identificar pantallas en la navegación?', 1, 2, 2);


-- Pregunta 1
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(11, 'Navigator.push()', 1),
(11, 'Navigator.goTo', 0 ),
(11, 'Navigator.add', 0),
(11, 'Navigator.open', 0);

-- Pregunta 2
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(12, 'Text', 0),
(12, 'Label', 0),
(12, 'InputBox', 0),
(12, 'TextField', 1);

-- Pregunta 3
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(13, 'rebuild()', 0),
(13, 'refresh()', 0),
(13, 'setState', 1),
(13, 'updateUI', 0);

-- Pregunta 4
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(14, 'Decoration', 0),
(14, 'Style', 0),
(14, 'ThemeData', 1),
(14, 'Format', 0);

-- Pregunta 5
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(15, 'Column', 0),
(15, 'ListView', 1),
(15, 'Scrollable', 0),
(15, 'ArrayWidget', 0);

-- Pregunta 6
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(16, 'Toolbar', 0),
(16, 'AppBar', 1),
(16, 'Header', 0),
(16, 'Scaffold', 0);

-- Pregunta 7
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(17, 'FloatingActionButton', 1),
(17, 'RoundButton', 0),
(17, 'CircleButton', 0),
(17, 'ActionWidget', 0);

-- Pregunta 8
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(18, 'Container', 0),
(18, 'Margin', 0),
(18, 'Padding', 1),
(18, 'SizedBox', 0);

-- Pregunta 9
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(19, 'Spacer', 0),
(19, 'SizedBox', 1),
(19, 'EmptyBox', 0),
(19, 'Gap', 0);

-- Pregunta 10
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(20, 'Dynamic Routing', 0),
(20, 'Route Mapping', 0),
(20, 'App Links', 0),
(20, 'Name Routes', 1);
