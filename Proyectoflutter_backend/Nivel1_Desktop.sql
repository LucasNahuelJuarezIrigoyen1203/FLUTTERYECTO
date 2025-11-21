INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
    ('¿Que elemento de UI se usa para permitir que el usuario escriba una sola línea de texto?', 3, 1, 7),
    ('¿Como se llama la ventana principal o contenedor de la aplicacion de escritorio?', 3, 1, 7),
    ('¿Que control permite al usuario seleccionar una o varias opciones de una lista desplegable?', 3, 1, 7),
    ('¿Que control se utiliza para agrupar visualmente controles relacionados y aplicarles un título?', 3, 1, 7),
    ('¿Cual es el componente de UI que activa una acción al hacer clic sobre él?', 3, 1, 7),
    ('¿Que control muestra una imagen estática o un logo dentro de la aplicacion?', 3, 1, 7),
    ('¿Que control permite al usuario marcar una opción como activada o desactivada (Sí/No, On/Off)?', 3, 1, 7),
    ('¿Que tipo de evento se dispara cuando el usuario hace clic en un boton?', 3, 1, 7),
    ('¿Cual de estos controles se usa para mostrar texto estático que no puede ser modificado por el usuario?', 3, 1, 7),
    ('¿Que elemento se usa para ofrecer una navegación jerárquica con comandos en la parte superior de la ventana?', 3, 1, 7); 
-- Pregunta 31
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(31, 'TextBox', 1),
(31, 'Label', 0 ),
(31, 'TextArea', 0),
(31, 'ComboBox', 0);

-- Pregunta 32
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(32, 'Frame', 1),
(32, 'Panel', 0),
(32, 'Container', 0),
(32, 'Layout', 0);

-- Pregunta 33
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(33, 'TextBox', 0),
(33, 'ComboBox', 1),
(33, 'ListBox', 0),
(33, 'Button', 0);

-- Pregunta 34
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(34, 'GroupBox', 1),
(34, 'Panel', 0),
(34, 'Container', 0),
(34, 'Section', 0);

-- Pregunta 35
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(35, 'TextBox', 0),
(35, 'Label', 0),
(35, 'ProgressBar', 0),
(35, 'Button', 1);

-- Pregunta 36
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(36, 'ImageControl', 1),
(36, 'Picture', 0),
(36, 'PhotoBox', 0),
(36, 'Display', 0);

-- Pregunta 37
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(37, 'RadioButton', 0),
(37, 'CheckBox', 1),
(37, 'Toggle', 0),
(37, 'SelectBox', 0);

-- Pregunta 38
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(38, 'Event_OnLoad', 0),
(38, 'Event_Changed', 0),
(38, 'Event_Click', 1),
(38, 'Event_Focus', 0);

-- Pregunta 39
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(39, 'Label', 1),
(39, 'TextControl', 0),
(39, 'DisplayBox', 0),
(39, 'InfoText', 0);

-- Pregunta 40
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(40, 'SideBar', 0),
(40, 'ToolBox', 0),
(40, 'MenuBar', 1),
(40, 'StatusBar', 0);