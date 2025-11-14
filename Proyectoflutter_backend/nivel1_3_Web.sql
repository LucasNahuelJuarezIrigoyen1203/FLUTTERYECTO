-- =========================
-- Preguntas Nivel Básico (nivel_id = 1)
-- =========================
INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id) VALUES
('¿Cuál es la etiqueta correcta para crear un párrafo en HTML?', 2, 1, 1),
('¿Cómo se seleccionan todos los elementos <h1> en CSS?', 2, 1, 1),
('¿Cuál de estas formas ejecuta código JS cuando se hace clic en un botón HTML?', 2, 1, 1),
('¿Qué atributo se usa para apuntar la fuente de una imagen?', 2, 1, 1),
('¿Qué propiedad CSS controla el espacio exterior entre elementos?', 2, 1, 1),
('¿Cuál es la estructura mínima correcta de un enlace que apunta a https://ejemplo.com?', 2, 1, 1),
('¿Cómo se aplica una clase llamada "boton" en CSS?', 2, 1, 1),
('¿Cuál palabra clave crea una variable cuyo valor puede cambiar?', 2, 1, 1),
('¿Qué type se usa para pedir un correo electrónico y activar validación básica del navegador?', 2, 1, 1),
('¿Cuál es la sintaxis correcta para enlazar style.css dentro del head?', 2, 1, 1);

-- =========================
-- Preguntas Nivel Intermedio (nivel_id = 2)
-- =========================
INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id) VALUES
('¿Qué selector CSS selecciona un input con el atributo required?', 2, 2, 2),
('¿Qué propiedad alinea los elementos a lo largo del eje principal en un contenedor flex?', 2, 2, 2),
('¿Cuál método devuelve el primer elemento que coincide con un selector CSS?', 2, 2, 2),
('¿Cuál ventaja da usar event delegation?', 2, 2, 2),
('¿Cómo se guarda la clave "tema" con valor "oscuro" en localStorage?', 2, 2, 2),
('¿Cuál es la sintaxis básica de una media query que aplica estilos a pantallas de máximo 600px?', 2, 2, 2),
('¿Cuál es la forma correcta de crear una promesa que resuelve con "ok"?', 2, 2, 2),
('¿Qué atributo se usa junto con target="_blank" para mejorar seguridad?', 2, 2, 2),
('¿Qué propiedad define el número y tamaño de columnas en Grid?', 2, 2, 2),
('¿Qué método añade una clase llamada "activo" a un elemento en JS?', 2, 2, 2);

-- =========================
-- Preguntas Nivel Avanzado (nivel_id = 3)
-- =========================
INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id) VALUES
('¿Cuál de estas acciones es más probable que cause un reflow completo en la página?', 2, 3, 3),
('¿Cuál técnica asegura que una función se ejecute sólo después de que el usuario dejó de disparar eventos durante un periodo?', 2, 3, 3),
('¿Qué mecanismo permite que una petición fetch a otro dominio sea aceptada por el navegador?', 2, 3, 3),
('¿Cuál ventaja ofrece el shadow DOM?', 2, 3, 3),
('¿Qué se ejecuta antes en la siguiente secuencia: callbacks de setTimeout y then de una Promise resuelta inmediatamente?', 2, 3, 3),
('¿Qué atributo es importante para indicar el propósito de un botón que solo muestra un icono (sin texto)?', 2, 3, 3),
('¿Cómo se exporta por defecto una función llamada init desde un módulo?', 2, 3, 3),
('¿Cuál es la forma correcta de obtener un JSON desde fetch y manejar el resultado con then?', 2, 3, 3),
('¿Cuál práctica sigue Progressive Enhancement?', 2, 3, 3),
('¿Qué beneficio directo ofrece HTTP/2 frente a HTTP/1.1 para cargar recursos?', 2, 3, 3);

-- Pregunta 61
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(61, '<div>', 0),
(61, '<p>', 1),
(61, '<span>', 0),
(61, '<section>', 0);

-- Pregunta 62
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(62, '.h1', 0),
(62, '#h1', 0),
(62, 'h1', 1),
(62, '*h1', 0);

-- Pregunta 63
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(63, '<button run="miFunc()">', 0),
(63, '<button onload="miFunc()">', 0),
(63, '<button onclick="miFunc()">', 1),
(63, '<button when="miFunc()">', 0);

-- Pregunta 64
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(64, 'href', 0),
(64, 'src', 1),
(64, 'alt', 0),
(64, 'data', 0);

-- Pregunta 65
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(65, 'padding', 0),
(65, 'border', 0),
(65, 'margin', 1),
(65, 'spacing', 0);

-- Pregunta 66
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(66, '<a>https://ejemplo.com</a>', 0),
(66, '<a href="https://ejemplo.com">Enlace</a>', 1),
(66, '<link href="https://ejemplo.com">', 0),
(66, '<a src="https://ejemplo.com">Enlace</a>', 0);

-- Pregunta 67
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(67, 'boton { }', 0),
(67, '#boton { }', 0),
(67, '.boton { }', 1),
(67, '>boton { }', 0);

-- Pregunta 68
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(68, 'const', 0),
(68, 'let', 1),
(68, 'static', 0),
(68, 'fixed', 0);

-- Pregunta 69
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(69, 'text', 0),
(69, 'password', 0),
(69, 'email', 1),
(69, 'mail', 0);

-- Pregunta 70
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(70, '<style src="style.css"></style>', 0),
(70, '<link rel="stylesheet" href="style.css">', 1),
(70, '<script src="style.css"></script>', 0),
(70, '<css src="style.css">', 0);

-- Pregunta 71
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(71, 'input[is="required"]', 0),
(71, 'input:required', 0),
(71, 'input[required]', 1),
(71, 'input.required', 0);

-- Pregunta 72
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(72, 'align-items', 0),
(72, 'flex-direction', 0),
(72, 'justify-content', 1),
(72, 'order', 0);

-- Pregunta 73
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(73, 'getElementById', 0),
(73, 'getElementsByClassName', 0),
(73, 'querySelector', 1),
(73, 'queryAll', 0);

-- Pregunta 74
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(74, 'Aumenta el número de listeners por elemento', 0),
(74, 'Evita que los eventos burbujeen', 0),
(74, 'Permite manejar muchos elementos dinámicos con un solo listener', 1),
(74, 'Cambia el orden de ejecución de los eventos', 0);

-- Pregunta 75
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(75, 'localStorage.set("tema","oscuro")', 0),
(75, 'storage.put("tema","oscuro")', 0),
(75, 'localStorage.setItem("tema","oscuro")', 1),
(75, 'localStorage["tema"] = {value:"oscuro"}', 0);

-- Pregunta 76
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(76, '@media (min-width: 600px) { }', 0),
(76, '@responsive (max-width: 600px) { }', 0),
(76, '@media (max-width: 600px) { }', 1),
(76, '@screen <= 600px { }', 0);

-- Pregunta 77
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(77, 'new Promise(resolve => resolve("ok"))', 1),
(77, 'Promise.create("ok")', 0),
(77, 'new Promise((resolve) => { resolve("ok"); })', 1),
(77, 'Promise.resolveFunction("ok")', 0);

-- Pregunta 78
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(78, 'referrer="no"', 0),
(78, 'target="secure"', 0),
(78, 'rel="noopener"', 1),
(78, 'secure="true"', 0);

-- Pregunta 79
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(79, 'grid-rows', 0),
(79, 'column-count', 0),
(79, 'grid-template-columns', 1),
(79, 'grid-columns', 0);

-- Pregunta 80
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(80, 'element.addClass("activo")', 0),
(80, 'element.class  = "activo"', 0),
(80, 'element.classList.add("activo")', 1),
(80, 'element.setAttributeClass("activo")', 0);

-- Pregunta 81
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(81, 'Cambiar el color de fondo mediante transform', 0),
(81, 'Añadir una clase que solo cambia opacidad', 0),
(81, 'Cambiar el ancho de un elemento dinámicamente', 1),
(81, 'Aplicar transform: translateX(10px)', 0);

-- Pregunta 82
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(82, 'Throttle', 0),
(82, 'async/await', 0),
(82, 'Debounce', 1),
(82, 'Buffer', 0);

-- Pregunta 83
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(83, 'El navegador deshabilita CORS automáticamente', 0),
(83, 'Incluir credentials en la petición', 0),
(83, 'El servidor responde con cabecera Access-Control-Allow-Origin adecuada', 1),
(83, 'Usar localStorage en el cliente', 0);

-- Pregunta 84
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(84, 'Acelerar la conexión a internet', 0),
(84, 'Compartir estilos globales automáticamente', 0),
(84, 'Encapsular estilos y evitar colisiones con el CSS de la página', 1),
(84, 'Reemplazar JavaScript por CSS', 0);

-- Pregunta 85
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(85, 'setTimeout callback', 0),
(85, 'Ambos al mismo tiempo', 0),
(85, 'then de la Promise', 1),
(85, 'Ninguno se ejecuta automáticamente', 0);

-- Pregunta 86
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(86, 'data-icon', 0),
(86, 'title', 0),
(86, 'aria-label', 1),
(86, 'role-id', 0);

-- Pregunta 87
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(87, 'export { init }', 0),
(87, 'export default function init() {}', 1),
(87, 'module.exports = init', 0),
(87, 'export * init', 0);

-- Pregunta 88
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(88, 'fetch(url).then(res => res.text()).then(data => ...)', 0),
(88, 'fetch(url).then(data => data.json()).then(json => ...)', 0),
(88, 'fetch(url).then(res => res.json()).then(json => ...)', 1),
(88, 'fetch.json(url).then(...)', 0);

-- Pregunta 89
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(89, 'Cargar toda la UI solo con JS y no incluir HTML semántico', 0),
(89, 'Construir la estructura HTML funcional y añadir mejoras con JS', 1),
(89, 'Evitar el uso de etiquetas semánticas para mayor flexibilidad', 0),
(89, 'Depender de frameworks para renderizar en cliente siempre', 0);

-- Pregunta 90
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(90, 'Requiere más conexiones TCP para cada recurso', 0),
(90, 'Bloquea paralelismo de recursos', 0),
(90, 'Permite multiplexación de múltiples solicitudes en la misma conexión', 1),
(90, 'Elimina la necesidad de HTTPS', 0);
