INSERT INTO preguntas (texto, rama_id, dificultad_id, nivel_id)
VALUES 
('¿Cual es el objetivo principal del patrón de diseño **MVVM** (Model-View-ViewModel) en el desarrollo de escritorio?', 3, 3, 8),
('¿Que técnica es fundamental para actualizar un elemento de la UI desde un hilo de trabajo (background thread)?', 3, 3, 8),
('En aplicaciones basadas en eventos, ¿qué es un **"Event Aggregator"** o **"Mediator"**?', 3, 3, 8),
('¿Cual es la principal ventaja de utilizar la inyección de dependencias (DI) en el desarrollo de aplicaciones de escritorio?', 3, 3, 8),
('¿Que diferencia a un **"Control de Usuario"** de un **"Control Estándar"**?', 3, 3, 8),
('¿Que es el **"Marshalling"** en el contexto de la comunicación entre hilos en una UI?', 3, 3, 8),
('¿Cual es un desafío común al desplegar una aplicación de escritorio que una aplicación web no suele enfrentar?', 3, 3, 8),
('¿Que es la **"Virtualización de UI"** en un control de lista (como DataGrid)?', 3, 3, 8),
('¿Que patrón se usa para manejar la navegación entre múltiples vistas sin acoplamiento fuerte en arquitecturas desacopladas?', 3, 3, 8),
('¿Que es un **"Sideloading"** en el contexto de instalación y despliegue de aplicaciones de escritorio?', 3, 3, 8);

-- Pregunta 51
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(51, 'Unificar la lógica de negocio y la presentación en el Model.', 0),
(51, 'Separar la View (UI) de la lógica de presentación (ViewModel) para facilitar pruebas.', 1),
(51, 'Reducir el número de clases en la aplicación.', 0),
(51, 'Eliminar completamente el uso de Data Binding.', 0);

-- Pregunta 52
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(52, 'Usar la función Thread.Sleep().', 0),
(52, 'Acceder directamente a la propiedad del control de UI.', 0),
(52, 'Invocar un método de sincronización (como Invoke/Dispatch) del hilo de UI.', 1),
(52, 'Poner el hilo en pausa hasta que la UI esté disponible.', 0);

-- Pregunta 53
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(53, 'Un componente que simplifica la comunicación entre componentes desacoplados.', 1),
(53, 'Un objeto que gestiona todas las rutas de navegación.', 0),
(53, 'Una clase que maneja la validación de todos los formularios.', 0),
(53, 'El objeto principal que contiene la vista y el modelo.', 0);

-- Pregunta 54
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(54, 'Acelerar el tiempo de carga de la aplicación al inicio.', 0),
(54, 'Mejorar la modularidad, la testeabilidad y la flexibilidad del código.', 1),
(54, 'Eliminar la necesidad de cualquier archivo de configuración.', 0),
(54, 'Restringir el acceso a ciertos recursos del sistema.', 0);

-- Pregunta 55
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(55, 'El Control de Usuario es un control que requiere la intervención del sistema operativo.', 0),
(55, 'El Control de Usuario es una composición de Controles Estándar en una unidad reutilizable.', 1),
(55, 'El Control de Usuario solo puede ser usado en una sola aplicación.', 0),
(55, 'El Control de Usuario tiene su propio hilo de ejecución.', 0);

-- Pregunta 56
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(56, 'El proceso de convertir un objeto de UI en binario para guardarlo.', 0),
(56, 'La técnica para transferir llamadas a métodos o datos de un hilo a otro (hilo de UI).', 1),
(56, 'La optimización de la memoria caché de la UI.', 0),
(56, 'La gestión de la serialización de datos del modelo.', 0);

-- Pregunta 57
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(57, 'La necesidad de gestionar la memoria RAM directamente.', 0),
(57, 'La gestión de dependencias de tiempo de ejecución (runtimes) y bibliotecas en el sistema del usuario.', 1),
(57, 'El diseño de la UI para diferentes resoluciones.', 0),
(57, 'La falta de un patrón de diseño adecuado para la lógica de negocio.', 0);

-- Pregunta 58
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(58, 'La optimización que solo renderiza los elementos visibles en pantalla en lugar de todos los elementos de la lista.', 1),
(58, 'El uso de un contenedor transparente en lugar de un contenedor sólido.', 0),
(58, 'La carga de datos en segundo plano antes de que el usuario haga scroll.', 0),
(58, 'El uso de un DataGrid que solo muestra texto sin imágenes.', 0);

-- Pregunta 59
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(59, 'Patrón de repositorio.', 0),
(59, 'Inyección de vistas (View Injection) o Regiones.', 1),
(59, 'Patrón Singleton.', 0),
(59, 'Patrón Strategy.', 0);

-- Pregunta 60
INSERT INTO respuestas (pregunta_id, texto, es_correcta) VALUES
(60, 'El proceso de obtener código de un repositorio Git.', 0),
(60, 'La instalación de una aplicación de escritorio fuera de una tienda de aplicaciones oficial (como Microsoft Store).', 1),
(60, 'La carga dinámica de componentes de UI en tiempo de ejecución.', 0),
(60, 'La gestión de la seguridad de los archivos de configuración.', 0);