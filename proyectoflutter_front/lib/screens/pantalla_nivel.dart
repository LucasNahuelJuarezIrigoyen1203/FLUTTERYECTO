import 'package:flutter/material.dart';
import '/api.dart';
import '/models/models.dart';
import '/models/usuario_estado.dart';

/// 🔹 Mapea el nombre de la rama a un asset de fondo
String fondoPorRama(String ramaNombre) {
  final nombre = ramaNombre.trim().toLowerCase();
  if (nombre.contains('aplicaciones moviles')) {
    return 'assets/images/fondo_cuervo.png';
  }
  if (nombre.contains('web')) {
    return 'assets/images/fondo_panda.png';
  }
  if (nombre.contains('desktop') || nombre.contains('escritorio')) {
    return 'assets/images/fondo_ballena.png';
  }
  return 'assets/images/fondo_default.png';
}

class PantallaNivel extends StatefulWidget {
  final int nivelId;
  final UsuarioEstado usuarioEstado;
  final String ramaNombre;

  const PantallaNivel({
    super.key,
    required this.nivelId,
    required this.usuarioEstado,
    required this.ramaNombre,
  });

  @override
  State<PantallaNivel> createState() => _PantallaNivelState();
}

class _PantallaNivelState extends State<PantallaNivel> {
  late UsuarioEstado usuarioEstado;
  Pregunta? pregunta;
  bool cargando = true;
  bool procesandoRespuesta = false;

  @override
  void initState() {
    super.initState();
    usuarioEstado = widget.usuarioEstado;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (usuarioEstado.id == 0) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        cargarPregunta();
      }
    });
  }

  Future<void> cargarPregunta({int? preguntaId}) async {
    setState(() => cargando = true);
    try {
      final p = await fetchPregunta(widget.nivelId, preguntaId: preguntaId);
      setState(() {
        pregunta = p;
        cargando = false;
      });
    } catch (e) {
      debugPrint('Error al cargar pregunta: $e');
      setState(() => cargando = false);
    }
  }

  Future<void> responder(int opcionId) async {
    setState(() => procesandoRespuesta = true);
    try {
      final resultado = await enviarRespuesta(
        usuarioId: usuarioEstado.id,
        preguntaId: pregunta?.id ?? 0,
        opcionId: opcionId,
      );

      setState(() {
        usuarioEstado = usuarioEstado.copyWith(
          vidas: resultado.vidasRestantes ?? usuarioEstado.vidas,
          progreso: resultado.progreso,
        );
      });

      // 🔹 Mostrar alerta según resultado
      if (resultado.correcta == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Respuesta incorrecta ❌ ¡Has perdido una vida!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Correcto! 🎉'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
      setState(() {
        usuarioEstado = usuarioEstado.copyWith(
          vidas: resultado.vidasRestantes ?? usuarioEstado.vidas,
          progreso: resultado.progreso,
        );
      });

      // 🔹 Verificar si el progreso llegó al 100%
      if (usuarioEstado.progreso >= 1.0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("¡Nivel terminado! 🎉"),
            content: const Text(
              "Has completado el nivel. Volverás a la pantalla inicial.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/paginainicial',
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Aceptar"),
              ),
            ],
          ),
        );
        return; // 👈 no cargar más preguntas
      }
      // 🔹 Verificar si se quedó sin vidas
      if (usuarioEstado.sinVidas) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("¡Sin vidas!"),
            content: const Text(
              "No podés seguir jugando. Volverás a la pantalla inicial.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/paginainicial',
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Aceptar"),
              ),
            ],
          ),
        );
        return; // 👈 no cargar más preguntas
      }

      await cargarPregunta(); // siguiente pregunta
    } catch (e) {
      debugPrint('Error al responder: $e');
    } finally {
      setState(() => procesandoRespuesta = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const int totalVidas = 5;
    final fondo = fondoPorRama(widget.ramaNombre);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(fondo),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
        child: cargando
            ? const Center(child: CircularProgressIndicator())
            : pregunta == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¡Nivel completado!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/paginainicial',
                        );
                      },
                      child: const Text('Volver al menú'),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 16),
                  // Encabezado con nombre de la rama
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.ramaNombre,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Vidas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalVidas, (index) {
                      final viva = index < usuarioEstado.vidas;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          viva
                              ? 'assets/images/corazon_normal.gif'
                              : 'assets/images/corazon_roto.gif',
                          height: 40,
                          width: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              viva ? Icons.favorite : Icons.favorite_border,
                              color: viva ? Colors.red : Colors.grey,
                              size: 40,
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // Pregunta
                  if (pregunta != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          pregunta?.texto ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  // Opciones
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children:
                          pregunta?.opciones.map((opcion) {
                            return OpcionButton(
                              texto: opcion.texto,
                              onTap: () => responder(opcion.id),
                              enabled: !procesandoRespuesta,
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                  // Progreso
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: (usuarioEstado.progreso ?? 0).clamp(
                              0.0,
                              1.0,
                            ),
                            minHeight: 12,
                            backgroundColor: Colors.white.withOpacity(0.6),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${((usuarioEstado.progreso ?? 0) * 100).clamp(0, 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class OpcionButton extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;
  final bool enabled;

  const OpcionButton({
    super.key,
    required this.texto,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black54,
          elevation: 3,
        ),
        child: Text(texto, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
