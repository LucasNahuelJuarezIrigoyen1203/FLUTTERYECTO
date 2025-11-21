-- Pregunta 1
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El desarrollo movil puede ser nativo o multiplataforma. Flutter es un framework multiplataforma creado por Google que permite escribir una sola base de codigo para Android, iOS (y ademas Web y Desktop). Flutter usa un motor grafico propio, lo que le da control total sobre la UI y rendimiento cercano al nativo. El lenguaje que disenaron para usar con Flutter es Dart, pensado para ser simple, con tipado opcional y buenas herramientas para UI reactiva.',
  1, 1, 1
);

-- Pregunta 2
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'En Flutter todo es un widget: no hay distincion rigida entre componentes de UI y contenedores. Un widget describe la configuracion visual y, combinado con otros widgets, forma la interfaz completa. Los widgets se componen y anidan; por ejemplo, un Container puede contener un Column que a su vez tiene varios Text. Este enfoque hace que la UI sea declarativa y predecible: describes como debe verse en un momento dado y Flutter se encarga de dibujarlo.',
  2, 1, 1
);

-- Pregunta 3
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Los widgets pueden ser Stateless o Stateful. Un StatelessWidget representa una parte de la UI que no cambia por si sola (por ejemplo, un titulo fijo). Un StatefulWidget aloja un objeto State donde se guardan datos que pueden cambiar y provocar una reconstruccion. La separacion ayuda a optimizar: solo las partes con estado se vuelven a dibujar cuando cambian sus datos.',
  3, 1, 1
);

-- Pregunta 4
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El archivo main.dart suele contener la funcion main(), que es el punto de entrada de la app. Dentro se llama a runApp() con el widget raiz (por ejemplo, MaterialApp). runApp() monta la jerarquia de widgets y enlaza el motor de Flutter a la ventana del sistema operativo, poniendo en marcha el ciclo de vida de la aplicacion.',
  4, 1, 1
);

-- Pregunta 5
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'MaterialApp es un widget de alto nivel que configura cosas como tema (colores, tipografia), rutas y el titulo de la app. Al usar MaterialApp obtienes por defecto muchos comportamientos y animaciones de Material Design (la guia de diseno de Google), ademas de integracion con Scaffold, AppBar, y el sistema de rutas. Es la forma comun de arrancar apps con apariencia consistente y componentes predefinidos.',
  5, 1, 1
);

-- Pregunta 6
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Scaffold proporciona la plantilla visual basica de una pantalla: fondo, AppBar (barra superior), FloatingActionButton, area de contenido y bandejas de navegacion. Usarlo evita recrear manualmente la estructura y asegura que tu UI siga patrones de usabilidad comunes. Es especialmente util para prototipado rapido y coherencia entre pantallas.',
  6, 1, 1
);

-- Pregunta 7
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El widget Text muestra cadenas en pantalla y se puede personalizar con propiedades de estilo (TextStyle) como tamano, peso, color y espaciado. Aunque es simple, Text es muy flexible: admite alineacion, maxLines, overflow y estilos variados, por lo que es la base del contenido textual en Flutter. Saber como aplicarle TextStyle y combinarlo con RichText para partes con estilos distintos es importante para interfaces accesibles.',
  7, 1, 1
);

-- Pregunta 8
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Image permite mostrar imagenes tanto desde assets locales como desde una URL remota. Para assets debes declararlos en pubspec.yaml. Flutter maneja diferentes resoluciones (2x, 3x) si incluyes variantes en carpetas especificas, lo que ayuda a que las imagenes se vean nitidas en distintos tamanos de pantalla. Ademas, Image soporta fit, alignment y placeholders.',
  8, 1, 1
);

-- Pregunta 9
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Container es un widget versatil que funciona como caja: permite aplicar padding, margin (con EdgeInsets), fondo (decoration), bordes y tamano. Es ideal para agrupar, dar estilo o posicionar otros widgets. Aunque util, abusar de Container puede sobrecargar la jerarquia; a veces Padding, SizedBox o DecoratedBox son alternativas mas ligeras.',
  9, 1, 1
);

-- Pregunta 10
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Column y Row son widgets de layout fundamentales: Column apila hijos verticalmente y Row horizontalmente. Permiten controlar alineacion y espacio usando propiedades como mainAxisAlignment y crossAxisAlignment. Comprender el eje principal (main axis) y el eje cruzado (cross axis) es clave para disenar layouts responsivos y evitar sorpresas al rotar la pantalla o cambiar tamanos.',
  10, 1, 1
);

-- Pregunta 11: ¿Qué método se usa para abrir una nueva pantalla?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'La navegacion en Flutter se basa en una pila de rutas manejada por Navigator. Al hacer Navigator.push() agregas una nueva ruta (pantalla) encima de la pila y con Navigator.pop() la quitas, volviendo a la anterior. Existen rutas anonimas y rutas nombradas: las nombradas facilitan el manejo cuando la app crece, porque centralizan las rutas y simplifican la navegacion desde cualquier parte.',
  11, 1, 2
);

-- Pregunta 12: ¿Qué widget se usa para escribir texto en un campo editable?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'TextField es el widget para entrada de texto; se puede enlazar a un TextEditingController para leer y modificar su valor programaticamente. Los InputDecoration permiten agregar etiquetas, iconos y mensajes de error. Ademas, TextFormField combinado con Form y validadores es util para formularios con validacion compleja y manejo centralizado.',
  12, 1, 2
);

-- Pregunta 13: ¿Qué función actualiza la interfaz de un StatefulWidget?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'En un StatefulWidget, setState() es la forma estandar de notificar a Flutter que el estado interno cambio y que el widget debe reconstruirse. Dentro de setState() actualizas variables y Flutter vuelve a ejecutar el metodo build() para reflejar los cambios en pantalla. Es sencillo pero se debe usar con cuidado: actualizaciones muy frecuentes o demasiado amplias pueden afectar el rendimiento.',
  13, 1, 2
);

-- Pregunta 14: ¿Con qué propiedad se define el estilo global en un MaterialApp?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'ThemeData define el tema global de la app: colores primarios, secundarios, tipografias y estilos por defecto para widgets Material. Configurarlo al inicio con MaterialApp(theme: ThemeData(...)) asegura coherencia visual y facilita cambios de look & feel (por ejemplo, modo oscuro) sin modificar cada widget individualmente.',
  14, 1, 2
);

-- Pregunta 15: ¿Qué widget muestra una lista de elementos con desplazamiento vertical?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'ListView permite construir listas desplazables que pueden contener cientos o miles de elementos. Con ListView.builder creas los items bajo demanda (lazy), lo que mejora la memoria y el rendimiento. Es ideal para feeds, listas de mensajes o catalogos, y se puede combinar con separadores, refresco por deslizamiento y paginacion.',
  15, 1, 2
);

-- Pregunta 16: ¿Qué widget crea la barra superior con título en una pantalla Flutter?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'AppBar es parte del patron Material: una barra superior donde va el titulo, acciones y navegacion (por ejemplo, boton de retroceso). Pares AppBar + Scaffold constituyen la estructura estandar de una pantalla. Personalizar el AppBar ayuda a la usabilidad: iconos de accion, menus y titulos claros mejoran la experiencia.',
  16, 1, 2
);

-- Pregunta 17: ¿Cuál de estos widgets crea un botón flotante circular?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'FloatingActionButton (FAB) es un boton circular que representa la accion principal de la pantalla (por ejemplo, crear nuevo elemento). Ubicado generalmente en la esquina inferior derecha, destaca por su forma y elevacion. El uso consistente del FAB ayuda a los usuarios a identificar la accion mas importante de una vista.',
  17, 1, 2
);

-- Pregunta 18: ¿Qué widget se usa para agregar espacio alrededor de otro widget?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Padding es un widget ligero que anade espacio interior alrededor de un hijo. A diferencia de Container, esta optimizado solo para espaciado y por eso suele ser preferible cuando solo necesitas separar visualmente elementos. Comprender cuando usar Padding, Margin (implicito en Container) y SizedBox mejora la limpieza del arbol de widgets.',
  18, 1, 2
);

-- Pregunta 19: ¿Qué widget usarías para dejar un espacio vacío entre dos elementos?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'SizedBox es un widget sencillo para definir un tamano fijo o un espacio vacio. Es util para separar elementos por una distancia exacta o forzar dimensiones de componentes. Spacer en cambio toma el espacio disponible y lo reparte entre elementos; ambos tienen usos concretos en layouts flexibles.',
  19, 1, 2
);

-- Pregunta 20: ¿Cómo se llama la técnica que usa nombres para identificar pantallas en la navegación?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Las named routes (rutas nombradas) permiten referenciar pantallas por una clave (string) en lugar de construir instancias en linea. Esto centraliza la configuracion de rutas en MaterialApp(routes: {...}), facilita la navegacion desde cualquier parte y es util para deep links o pruebas. Son preferidas en apps medianas o grandes por su organizacion.',
  20, 1, 2
);

-- Pregunta 21: Cual de estas opciones no es una herramienta de gestion de estado en Flutter?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'El manejo de estado es crucial al escalar una app. Existen muchas soluciones: Provider (ligero y recomendado para la mayoria), Bloc (patron mas estructurado que separa UI y logica con streams), Redux (inspirado en web, con un store global), y Riverpod (evolucion de Provider con mas seguridad y testabilidad). Algunas tecnicas propias de otras plataformas (por ejemplo, ContextAPI de React) no son parte del ecosistema Flutter.',
  21, 1, 3
);

-- Pregunta 22: Que paquete se usa para realizar solicitudes HTTP en Flutter?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Para comunicarte con APIs REST se usa comunmente el paquete http, que proporciona funciones para GET, POST, PUT, DELETE y manejo de cabeceras y cuerpos. Para proyectos mas complejos puedes usar paquetes como dio que ofrecen interceptores, cancelacion y mejor manejo de errores. Entender como autenticar peticiones y gestionar tokens es igualmente importante.',
  22, 1, 3
);

-- Pregunta 23: Que funcion convierte una respuesta JSON en un objeto de Dart?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'jsonDecode() (del paquete dart:convert) transforma una cadena JSON en Map/List de Dart, lo que permite acceder a datos con claves y crear modelos a partir de esa estructura. Es buena practica convertir esos mapas a clases Dart con metodos fromJson y validar campos para evitar errores en tiempo de ejecucion.',
  23, 1, 3
);

-- Pregunta 24: Como se llama la funcion de Flutter que permite ver cambios instantaneos en el codigo?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Hot reload es una caracteristica de Flutter que recompila partes del codigo de la UI y las aplica en caliente sin reiniciar la app ni perder el estado. Es ideal para cambios de diseno y logica UI; sin embargo, cambios en la firma de clases, inicializadores estaticos o dependencias pueden requerir un hot restart o reinicio completo. Esto acelera enormemente el ciclo de desarrollo.',
  24, 1, 3
);

-- Pregunta 25: Que tipo de objeto representa una operacion asincronica en Dart?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'En Dart, Future representa el resultado de una operacion asincronica que completara en el futuro (por ejemplo, la respuesta de una peticion HTTP). Se maneja con async/await o con then() y catchError(). Entender como encadenar y capturar errores en Futures es fundamental para evitar estados inconsistentes y mejorar la experiencia de usuario con indicadores de carga.',
  25, 1, 3
);

-- Pregunta 26: Que widget se usa para mostrar datos provenientes de una operacion asincronica?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'FutureBuilder es un widget que reconstruye su subarbol en funcion del estado de un Future: muestra loading, datos o error segun corresponda. Es util para casos sencillos, pero en apps grandes conviene separar la logica asincronica en capas (repositorios / servicios) y no mezclar demasiada logica de negocio en la UI.',
  26, 1, 3
);

-- Pregunta 27: Que representa un Stream en Flutter?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Un Stream es una secuencia asincronica de eventos (datos) que pueden llegar a lo largo del tiempo; se usa para notificaciones, datos en tiempo real o eventos multiples. StreamBuilder permite construir la UI en funcion de los eventos del stream. Comparado con Future, que entrega un unico resultado, Stream puede emitir muchos.',
  27, 1, 3
);

-- Pregunta 28: Que palabra clave mejora el rendimiento al indicar que un widget no cambia?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Marcar widgets con const ayuda al compilador a identificar instancias inmutables y evita que se reconstruyan innecesariamente, mejorando rendimiento. Ademas, el uso de const promueve codigo mas predecible y seguro en cuanto a inmutabilidad. Identifica que widgets no cambian y declaralos const siempre que sea posible.',
  28, 1, 3
);

-- Pregunta 29: Que patron usa streams para manejar el estado y la logica de negocio?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Bloc (Business Logic Component) es un patron que separa la logica de negocio de la UI usando Streams y Sinks. Cada bloque expone streams de estado y recibe eventos; la UI solo manda eventos y escucha cambios. Esto hace la app mas testeable y favorece arquitecturas escalables, aunque anade complejidad inicial.',
  29, 1, 3
);

-- Pregunta 30: Que paquete se usa para manejar bases de datos locales en Flutter?
INSERT INTO explicacion (texto, pregunta_id, rama_id, nivel_id)
VALUES (
  'Las apps suelen necesitar almacenamiento local: para datos persistentes, configuraciones o caching. sqflite es un paquete popular que provee acceso a SQLite en Flutter, permitiendo ejecutar consultas SQL, transacciones y manejar bases relacionales locales. Alternativas incluyen hive (NoSQL, muy rapida) o shared_preferences (clave-valor simple).',
  30, 1, 3
);
