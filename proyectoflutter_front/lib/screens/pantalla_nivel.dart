import 'package:flutter/material.dart';
import '/api.dart';
import '/models/models.dart';
import '/models/usuario_activo.dart';

class PantallaNivel extends StatefulWidget {
  final int nivelId;

  const PantallaNivel({super.key, required this.nivelId});

  @override
  State<PantallaNivel> createState() => _PantallaNivelState();
}

class _PantallaNivelState extends State<PantallaNivel> {
  int vidas = UsuarioActivo.vidas;
  double progreso = UsuarioActivo.progreso;
  Pregunta? pregunta;
  bool cargando = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!UsuarioActivo.estaLogueado) {
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
      print('Error al cargar pregunta: $e');
      setState(() => cargando = false);
    }
  }

  Future<void> responder(int opcionId) async {
    setState(() => cargando = true);
    try {
      final resultado = await enviarRespuesta(
        usuarioId: UsuarioActivo.id,
        preguntaId: pregunta!.id,
        opcionId: opcionId,
      );

      setState(() {
        vidas = resultado.vidasRestantes ?? vidas;
        progreso = resultado.progreso;
      });

      // Actualizar UsuarioActivo
      UsuarioActivo.vidas = vidas;
      UsuarioActivo.progreso = progreso;

      await cargarPregunta(); // siguiente pregunta
    } catch (e) {
      print('Error al responder: $e');
    } finally {
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const int totalVidas = 5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : pregunta == null
              ? const Center(child: Text('No hay preguntas disponibles'))
              : Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalVidas, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Image.asset(
                            index < vidas
                                ? 'assets/images/corazon_normal.gif'
                                : 'assets/images/corazon_roto.gif',
                            height: 40,
                            width: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                index < vidas ? Icons.favorite : Icons.favorite_border,
                                color: index < vidas ? Colors.red : Colors.grey,
                                size: 40,
                              );
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          pregunta!.texto,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: pregunta!.opciones.map((opcion) {
                          return OpcionButton(
                            texto: opcion.texto,
                            onTap: () => responder(opcion.id),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: progreso,
                          minHeight: 12,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class OpcionButton extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;

  const OpcionButton({super.key, required this.texto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
