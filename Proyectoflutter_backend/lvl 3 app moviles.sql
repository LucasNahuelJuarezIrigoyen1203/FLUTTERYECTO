INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
  #21('¿Cual de estas opciones no es una herramienta de gestión de estado en Flutter?', 1, 3, 3),
  #22('¿Que paquete se usa para realizar sollicitudes de el protocolo de hipertexto en flutter?', 1, 3, 3),
  #23('¿Que función convierte una respuesta JSON en codigo Dart?', 1, 3, 3),
  #24('¿Como se llama la funcion de Flutter que permite ver cambios instanteos en el codigo?', 1, 3, 3),
  #25('¿Que tipo de objeto representa una operacion Asincronica en Dart?', 1, 3, 3),
  #26('¿Que widget se usa para mostrar datos provenientes de una operacion asincronica?', 1, 3, 3),
  #27('¿Que representa un Stream en Flutter?', 1, 3, 3),
  #28('¿Que palabra clave mejora el rendimiento al indicar que un widget no cambia?', 1, 3, 3),
  #29('¿Que patron usa streams para manejar el estado y la logica de negocio?', 1, 3, 3),
  #30('¿Que paquete se usa para manejar bases de datos locales en Flutter?', 1, 3, 3);


-- Pregunta 1
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(21, 'Bloc', 0),
(21, 'Provider', 0 ),
(21, 'Redux', 0),
(21, 'ContexAPI', 1);

-- Pregunta 3
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(22, 'connect', 0),
(22, 'network', 0),
(22, 'fetch', 0),
(22, 'http', 1);

-- Pregunta 3
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(23, 'JsonOpen()', 0),
(23, 'JsonDecode()', 1),
(23, 'toMap()', 0),
(23, 'parseJson()', 0);

-- Pregunta 4
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(24, 'Hot Reload', 1),
(24, 'Live Update', 0),
(24, 'Code Sync', 0),
(24, 'Instant Run', 0);

-- Pregunta 5
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(25, 'Async', 0),
(25, 'Thread', 0),
(25, 'Future', 1),
(25, 'Wait', 0);

-- Pregunta 6
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(26, 'AsyncWidget', 0),
(26, 'FutureBuilder', 1),
(26, 'SteamBuilder', 0),
(26, 'LoadWidget', 0);

-- Pregunta 7
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(27, 'Una lista fija', 0),
(27, 'Una lista Variable', 0),
(27, 'Una secuencia de datos continuos', 1),
(27, 'Una secuencia de datos discontinuos', 0);

-- Pregunta 8
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(28, 'Static', 0),
(28, 'Final', 0),
(28, 'Fixed', 0),
(28, 'Const', 1);

-- Pregunta 9
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(29, 'BLOC', 1),
(29, 'MVC', 0),
(29, 'MVP', 0),
(29, 'MVVM', 0);

-- Pregunta 10
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(30, 'LocalDB', 0),
(30, 'SQLPackage', 0),
(30, 'Database_Flutter', 0),
(30, 'SQLFlite', 1);
