import 'package:flutter/material.dart';
import '/api.dart';
import '/models/models.dart';

class PantallaNivel extends StatefulWidget {
  final int usuarioId;
  final int nivelId;

  const PantallaNivel({super.key, required this.usuarioId, required this.nivelId});

  @override
  State<PantallaNivel> createState() => _PantallaNivelState();
}

class _PantallaNivelState extends State<PantallaNivel> {
  int vidas = 5;
  double progreso = 0.0;
  Pregunta? pregunta;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarPregunta();
  }

  Future<void> cargarPregunta() async {
    try {
      final p = await fetchPregunta(widget.nivelId);
      setState(() {
        pregunta = p;
        cargando = false;
      });
    } catch (e) {
      print('Error al cargar pregunta: $e');
    }
  }

  Future<void> responder(int opcionId) async {
    try {
      final r = await enviarRespuesta(
        usuarioId: widget.usuarioId,
        preguntaId: pregunta!.id,
        opcionId: opcionId,
      );

      setState(() {
        progreso = r.progreso;
        vidas = r.vidasRestantes ?? vidas;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(r.correcta ? '¡Correcto!' : 'Incorrecto'),
          content: Text(r.correcta
              ? 'Avanzaste al nivel ${r.nivelActual}'
              : 'Te quedan $vidas vidas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (r.correcta) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PantallaNivel(
                        usuarioId: widget.usuarioId,
                        nivelId: r.nivelActual,
                      ),
                    ),
                  );
                } else {
                  cargarPregunta();
                }
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error al enviar respuesta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalVidas = 5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: cargando
            ? const Center(child: CircularProgressIndicator())
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
                          height: 48,
                          width: 48,
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
