-- Pregunta 31: ¿Que elemento de UI se usa para permitir que el usuario escriba una sola linea de texto?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control TextBox de una sola linea permite al usuario ingresar texto simple. Es comun en formularios para nombres, correos o campos cortos. Se puede configurar con propiedades como MaxLength para limitar caracteres y validar la entrada.',
  31, 3, 7
);

-- Pregunta 32: ¿Como se llama la ventana principal o contenedor de la aplicacion de escritorio?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La ventana principal se conoce como Form o Window segun el framework. Es el contenedor base donde se agregan menus, barras de herramientas y controles. Define el ciclo de vida de la aplicacion y suele incluir metodos para inicializar la UI.',
  32, 3, 7
);

-- Pregunta 33: ¿Que control permite al usuario seleccionar una o varias opciones de una lista desplegable?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control ComboBox muestra una lista desplegable de opciones. Permite seleccionar un valor unico y en algunos entornos habilita edicion directa. Para multiples selecciones se usan ListBox o CheckedListBox. Es ideal para campos con valores predefinidos.',
  33, 3, 7
);

-- Pregunta 34: ¿Que control se utiliza para agrupar visualmente controles relacionados y aplicarles un titulo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control GroupBox agrupa controles relacionados bajo un mismo marco con titulo. Mejora la organizacion visual y semantica de formularios, separando secciones como datos personales o configuraciones. No altera la logica, solo la presentacion.',
  34, 3, 7
);

-- Pregunta 35: ¿Cual es el componente de UI que activa una accion al hacer clic sobre el?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control Button dispara acciones al hacer clic. Puede ejecutar eventos como guardar, enviar o cancelar. Se personaliza con texto, iconos y estilos. En frameworks modernos admite comandos y accesibilidad mediante teclas rapidas.',
  35, 3, 7
);

-- Pregunta 36: ¿Que control muestra una imagen estatica o un logo dentro de la aplicacion?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control PictureBox o ImageView se usa para mostrar imagenes estaticas, logos o iconos. Soporta formatos comunes como PNG y JPG, y propiedades para ajustar tamaño, alineacion y modo de escalado. Es util para branding y decoracion.',
  36, 3, 7
);

-- Pregunta 37: ¿Que control permite al usuario marcar una opcion como activada o desactivada?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control CheckBox permite marcar o desmarcar una opcion binaria (Si/No, On/Off). Puede usarse individualmente o en grupos para multiples selecciones. Su estado se consulta en logica de negocio para habilitar funciones o preferencias.',
  37, 3, 7
);

-- Pregunta 38: ¿Que tipo de evento se dispara cuando el usuario hace clic en un boton?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El evento Click se dispara al presionar un boton. Es el mas comun en interfaces graficas y se asocia a metodos que ejecutan acciones. Puede complementarse con eventos MouseDown o MouseUp para interacciones mas detalladas.',
  38, 3, 7
);

-- Pregunta 39: ¿Cual de estos controles se usa para mostrar texto estatico que no puede ser modificado por el usuario?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control Label muestra texto estatico en la interfaz. Se usa para titulos, descripciones o instrucciones. No admite edicion por parte del usuario, pero puede estilizarse con fuentes, colores y alineacion para mejorar la claridad.',
  39, 3, 7
);

-- Pregunta 40: ¿Que elemento se usa para ofrecer una navegacion jerarquica con comandos en la parte superior de la ventana?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control MenuStrip o MenuBar ofrece navegacion jerarquica en la parte superior de la ventana. Organiza comandos en menus y submenus como Archivo, Editar o Ayuda. Mejora la usabilidad y sigue convenciones de aplicaciones de escritorio.',
  40, 3, 7
);

-- Pregunta 41: ¿Que patron de diseño separa la logica de negocio de la interfaz de usuario para mejorar la mantenibilidad?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El patron MVC (Model-View-Controller) y sus variantes como MVVM separan la logica de negocio de la UI. Esto mejora la mantenibilidad y testeo, ya que la vista solo muestra datos, el modelo los gestiona y el controlador o ViewModel coordina la interaccion.',
  41, 3, 8
);

-- Pregunta 42: ¿Cual es el termino para la tecnica de diseño que asegura que la UI se adapte a diferentes tamaños de ventana?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La tecnica se llama diseño responsivo. Consiste en usar layouts flexibles, anclajes y controles adaptativos para que la UI se ajuste automaticamente a distintos tamaños de ventana o resoluciones, mejorando la experiencia en diversos dispositivos.',
  42, 3, 8
);

-- Pregunta 43: ¿Como se llama el proceso de enviar datos desde la UI a una capa de logica de negocio o modelo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Ese proceso se conoce como data binding o enlace de datos. Permite que los valores introducidos en controles de la UI se transfieran automaticamente al modelo o logica de negocio, reduciendo codigo repetitivo y errores de sincronizacion.',
  43, 3, 8
);

-- Pregunta 44: ¿Que mecanismo se usa tipicamente para evitar que una aplicacion de escritorio se congele al realizar una operacion larga?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se utilizan hilos secundarios o tareas asincronicas para ejecutar operaciones largas sin bloquear el hilo de UI. Esto mantiene la interfaz responsiva mientras se procesa en segundo plano, evitando que la aplicacion parezca congelada.',
  44, 3, 8
);

-- Pregunta 45: ¿Que tipo de control es ideal para mostrar datos tabulares grandes con capacidades de ordenacion y filtrado?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El control DataGrid o GridView es ideal para mostrar datos tabulares grandes. Ofrece ordenacion, filtrado y edicion en celdas. Es comun en aplicaciones de escritorio para manejar listas extensas de registros con funcionalidades avanzadas.',
  45, 3, 8
);

-- Pregunta 46: ¿Que concepto se aplica para configurar un control para que un cambio en los datos se refleje automaticamente en la UI?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El concepto es data binding bidireccional. Permite que los cambios en el modelo se reflejen en la UI y viceversa. Esto asegura sincronizacion constante entre datos y controles, reduciendo la necesidad de actualizar manualmente la interfaz.',
  46, 3, 8
);

-- Pregunta 47: ¿Que tipo de dialogo se usa para notificar al usuario sobre un error critico que requiere su atencion inmediata?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Se utiliza un MessageBox o dialogo modal de error critico. Bloquea la interaccion hasta que el usuario lo cierre y muestra informacion clara sobre el problema. Es fundamental para alertar sobre fallos graves que requieren accion inmediata.',
  47, 3, 8
);

-- Pregunta 48: ¿Que significa el termino Thread de UI o Hilo de interfaz de usuario?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El hilo de UI es el hilo principal donde se ejecutan las operaciones graficas y eventos de la interfaz. Debe permanecer libre de tareas pesadas para que la aplicacion responda fluidamente. Otros hilos manejan procesos en segundo plano.',
  48, 3, 8
);

-- Pregunta 49: ¿Que componente de UI se utiliza a menudo para mostrar un progreso indeterminado de una operacion en segundo plano?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El ProgressBar en modo indeterminado muestra que una operacion esta en curso sin indicar tiempo exacto. Es util para procesos cuyo fin no se puede calcular, dando retroalimentacion visual al usuario mientras se ejecuta en segundo plano.',
  49, 3, 8
);

-- Pregunta 50: ¿Cual de estas es una limitacion principal de una aplicacion de escritorio en comparacion con una web?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Una limitacion principal es la dependencia de instalacion y actualizacion manual en cada dispositivo. A diferencia de las aplicaciones web, que se actualizan centralmente en el servidor, las de escritorio requieren distribucion de nuevas versiones.',
  50, 3, 8
);

-- Pregunta 51: ¿Cual es el objetivo principal del patron de diseño MVVM en el desarrollo de escritorio?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El patron MVVM (Model-View-ViewModel) busca separar la logica de negocio de la interfaz de usuario. El modelo gestiona datos, la vista muestra la UI y el ViewModel actua como intermediario con data binding. Esto mejora mantenibilidad, testeo y reutilizacion de componentes.',
  51, 3, 8
);

-- Pregunta 52: ¿Que tecnica es fundamental para actualizar un elemento de la UI desde un hilo de trabajo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La tecnica fundamental es invocar al hilo de UI mediante mecanismos como Invoke o Dispatcher. Esto asegura que las actualizaciones graficas ocurran en el hilo principal, evitando errores de concurrencia y garantizando que la interfaz responda correctamente.',
  52, 3, 8
);

-- Pregunta 53: En aplicaciones basadas en eventos, ¿que es un Event Aggregator o Mediator?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Un Event Aggregator o Mediator es un patron que centraliza la comunicacion entre componentes desacoplados. Permite que emisores y receptores de eventos interactuen sin referencias directas, reduciendo dependencias y mejorando la escalabilidad de la aplicacion.',
  53, 3, 8
);

-- Pregunta 54: ¿Cual es la principal ventaja de utilizar la inyeccion de dependencias en aplicaciones de escritorio?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La inyeccion de dependencias (DI) facilita el desacoplamiento entre clases y servicios. Permite sustituir implementaciones facilmente, mejora la testabilidad mediante mocks y promueve arquitecturas flexibles donde los componentes dependen de interfaces en lugar de instancias concretas.',
  54, 3, 8
);

-- Pregunta 55: ¿Que diferencia a un Control de Usuario de un Control Estandar?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Un Control Estandar es parte de la libreria base del framework, como botones o cajas de texto. Un Control de Usuario es personalizado y combina varios controles estandar en una unidad reutilizable. Esto permite encapsular logica y diseño especifico para escenarios concretos.',
  55, 3, 8
);

-- Pregunta 56: ¿Que es el Marshalling en el contexto de la comunicacion entre hilos en una UI?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El marshalling es el proceso de transferir la ejecucion de una llamada desde un hilo secundario al hilo de UI. Se usa para garantizar que las actualizaciones graficas ocurran en el contexto correcto, evitando errores y asegurando consistencia en la interfaz.',
  56, 3, 8
);

-- Pregunta 57: ¿Cual es un desafio comun al desplegar una aplicacion de escritorio que una web no suele enfrentar?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Un desafio comun es la distribucion y actualizacion en cada dispositivo. A diferencia de las aplicaciones web que se actualizan centralmente, las de escritorio requieren instaladores, parches y gestion de versiones en cada equipo, lo que aumenta complejidad de mantenimiento.',
  57, 3, 8
);

-- Pregunta 58: ¿Que es la Virtualizacion de UI en un control de lista como DataGrid?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La virtualizacion de UI es una tecnica que renderiza solo los elementos visibles de una lista o DataGrid. Esto reduce consumo de memoria y mejora rendimiento al manejar miles de registros, ya que los elementos fuera de pantalla no se dibujan hasta ser necesarios.',
  58, 3, 8
);

-- Pregunta 59: ¿Que patron se usa para manejar la navegacion entre multiples vistas sin acoplamiento fuerte?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El patron Navigator o Router abstrae la navegacion entre vistas. Permite cambiar pantallas sin acoplar directamente las clases, usando rutas o identificadores. Esto favorece arquitecturas desacopladas y facilita pruebas y mantenimiento.',
  59, 3, 8
);

-- Pregunta 60: ¿Que es un Sideloading en el contexto de instalacion y despliegue de aplicaciones de escritorio?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El sideloading es la instalacion manual de una aplicacion fuera de los canales oficiales de distribucion. Se usa para pruebas internas o despliegues controlados, pero puede implicar riesgos de seguridad y requiere configuraciones adicionales en el sistema operativo.',
  60, 3, 8
);
