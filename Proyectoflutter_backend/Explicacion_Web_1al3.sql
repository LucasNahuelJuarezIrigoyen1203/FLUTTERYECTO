-- Pregunta 61: ¿Cual es la etiqueta correcta para crear un parrafo en HTML?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La etiqueta <p> define un parrafo en HTML. Es un elemento de bloque que organiza texto en secciones y aporta semantica a la pagina.',
  61, 2, 4
);

-- Pregunta 62: ¿Como se seleccionan todos los elementos <h1> en CSS?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El selector h1 aplica estilos a todos los elementos de encabezado <h1>. Ejemplo: h1 { color: blue; }.',
  62, 2, 4
);

-- Pregunta 63: ¿Cual de estas formas ejecuta codigo JS cuando se hace clic en un boton HTML?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se puede usar el atributo onclick en el boton o agregar un event listener en JavaScript. Ejemplo: document.getElementById("btn").addEventListener("click", miFuncion).',
  63, 2, 4
);

-- Pregunta 64: ¿Que atributo se usa para apuntar la fuente de una imagen?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El atributo src indica la ruta de la imagen. Ejemplo: <img src="foto.png" alt="descripcion">.',
  64, 2, 4
);

-- Pregunta 65: ¿Que propiedad CSS controla el espacio exterior entre elementos?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La propiedad margin controla el espacio exterior de un elemento respecto a otros. Se puede definir en pixeles, porcentajes o unidades relativas.',
  65, 2, 4
);

-- Pregunta 66: ¿Cual es la estructura minima correcta de un enlace que apunta a https://ejemplo.com?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Un enlace basico se define con <a href="https://ejemplo.com">Texto</a>. El atributo href indica la direccion destino.',
  66, 2, 4
);

-- Pregunta 67: ¿Como se aplica una clase llamada "boton" en CSS?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se usa el selector de clase: .boton { ... }. Esto aplica estilos a todos los elementos con class="boton".',
  67, 2, 4
);

-- Pregunta 68: ¿Cual palabra clave crea una variable cuyo valor puede cambiar?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La palabra clave let en JavaScript crea una variable mutable. A diferencia de const, permite reasignar valores.',
  68, 2, 4
);

-- Pregunta 69: ¿Que type se usa para pedir un correo electronico y activar validacion basica del navegador?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El atributo type="email" en un input activa validacion automatica de formato de correo electronico.',
  69, 2, 4
);

-- Pregunta 70: ¿Cual es la sintaxis correcta para enlazar style.css dentro del head?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se usa <link rel="stylesheet" href="style.css"> dentro de la seccion <head>. Esto carga la hoja de estilos externa.',
  70, 2, 4
);

-- Pregunta 71: ¿Que selector CSS selecciona un input con el atributo required?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El selector input[required] aplica estilos a todos los campos de entrada que tengan el atributo required. Es util para resaltar campos obligatorios en formularios.',
  71, 2, 5
);

-- Pregunta 72: ¿Que propiedad alinea los elementos a lo largo del eje principal en un contenedor flex?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La propiedad justify-content controla la alineacion de los elementos en el eje principal de un contenedor flex. Permite distribuir espacio y posicionar elementos de forma flexible.',
  72, 2, 5
);

-- Pregunta 73: ¿Cual metodo devuelve el primer elemento que coincide con un selector CSS?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El metodo document.querySelector("selector") devuelve el primer elemento que coincide con el selector CSS especificado. Es mas moderno y versatil que getElementById.',
  73, 2, 5
);

-- Pregunta 74: ¿Cual ventaja da usar event delegation?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Event delegation permite manejar eventos en elementos hijos desde un padre comun. Reduce el consumo de memoria y simplifica el codigo al evitar listeners individuales en cada elemento.',
  74, 2, 5
);

-- Pregunta 75: ¿Como se guarda la clave "tema" con valor "oscuro" en localStorage?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se usa localStorage.setItem("tema", "oscuro"). Esto almacena datos persistentes en el navegador y se mantiene incluso despues de cerrar la pagina.',
  75, 2, 5
);

-- Pregunta 76: ¿Cual es la sintaxis basica de una media query que aplica estilos a pantallas de maximo 600px?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  '@media (max-width: 600px) { ... } define estilos que se aplican solo en pantallas con ancho menor o igual a 600px. Es clave para diseño responsivo.',
  76, 2, 5
);

-- Pregunta 77: ¿Cual es la forma correcta de crear una promesa que resuelve con "ok"?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se puede crear con new Promise(resolve => resolve("ok")). Esto devuelve una promesa resuelta inmediatamente y es util para pruebas rapidas.',
  77, 2, 5
);

-- Pregunta 78: ¿Que atributo se usa junto con target="_blank" para mejorar seguridad?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El atributo rel="noopener noreferrer" evita que la pagina abierta acceda al objeto window.opener, protegiendo contra ataques de seguridad.',
  78, 2, 5
);

-- Pregunta 79: ¿Que propiedad define el numero y tamaño de columnas en Grid?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La propiedad grid-template-columns define el numero y tamaño de columnas en un contenedor CSS Grid. Permite layouts complejos y responsivos.',
  79, 2, 5
);

-- Pregunta 80: ¿Que metodo añade una clase llamada "activo" a un elemento en JS?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El metodo element.classList.add("activo") añade la clase activo al elemento especificado. Es la forma moderna de manipular clases en JavaScript.',
  80, 2, 5
);

-- Pregunta 81: ¿Cual de estas acciones es mas probable que cause un reflow completo en la pagina?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Modificar propiedades que afectan el layout como width, height o margin provoca un reflow completo. El navegador recalcula posiciones y tamaños de todos los elementos, lo que impacta rendimiento.',
  81, 2, 6
);

-- Pregunta 82: ¿Cual tecnica asegura que una funcion se ejecute solo despues de que el usuario dejo de disparar eventos durante un periodo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La tecnica debounce retrasa la ejecucion de una funcion hasta que el usuario deja de disparar eventos por un tiempo definido. Es comun en inputs y scroll para optimizar rendimiento.',
  82, 2, 6
);

-- Pregunta 83: ¿Que mecanismo permite que una peticion fetch a otro dominio sea aceptada por el navegador?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El mecanismo CORS (Cross-Origin Resource Sharing) permite que un navegador acepte peticiones a otro dominio si el servidor incluye cabeceras de autorizacion adecuadas.',
  83, 2, 6
);

-- Pregunta 84: ¿Cual ventaja ofrece el shadow DOM?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El shadow DOM encapsula estilos y estructura de un componente, evitando colisiones con CSS global. Permite crear Web Components reutilizables y predecibles.',
  84, 2, 6
);

-- Pregunta 85: ¿Que se ejecuta antes en la siguiente secuencia: callbacks de setTimeout y then de una Promise resuelta inmediatamente?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El then de una Promise resuelta se ejecuta antes que los callbacks de setTimeout. Esto ocurre porque las promesas usan la microtask queue, que tiene prioridad sobre la task queue.',
  85, 2, 6
);

-- Pregunta 86: ¿Que atributo es importante para indicar el proposito de un boton que solo muestra un icono?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El atributo aria-label describe la funcion de un boton sin texto. Es esencial para accesibilidad y lectores de pantalla.',
  86, 2, 6
);

-- Pregunta 87: ¿Como se exporta por defecto una funcion llamada init desde un modulo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se usa export default function init() { ... }. Esto marca la funcion init como exportacion principal del modulo.',
  87, 2, 6
);

-- Pregunta 88: ¿Cual es la forma correcta de obtener un JSON desde fetch y manejar el resultado con then?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se usa fetch("url").then(res => res.json()).then(data => { ... }). Esto convierte la respuesta en objeto JSON y lo procesa.',
  88, 2, 6
);

-- Pregunta 89: ¿Cual practica sigue Progressive Enhancement?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Progressive Enhancement consiste en construir primero una version basica funcional y luego agregar mejoras como CSS avanzado o JavaScript. Garantiza accesibilidad en navegadores antiguos.',
  89, 2, 6
);

-- Pregunta 90: ¿Que beneficio directo ofrece HTTP/2 frente a HTTP/1.1 para cargar recursos?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'HTTP/2 permite multiplexar multiples solicitudes en una sola conexion, reduciendo latencia y mejorando velocidad de carga de recursos.',
  90, 2, 6
);
