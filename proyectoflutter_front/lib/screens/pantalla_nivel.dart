import 'package:flutter/material.dart';

class PantallaNivel extends StatelessWidget {
  const PantallaNivel({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de progreso y vidas
    final int vidas = 4;
    final int totalVidas = 5;
    final double progreso = 0.5; // 50%

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 🔴 Vidas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalVidas, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Image.asset(
                    index < vidas
                      ? 'assets/images/corazon_normal.gif'
                      : 'assets/images/corazon_roto.gif',
                    height: 48, // antes era 28
                    width: 48,
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // 📄 Pregunta
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
                child: const Text(
                  '¿Cuál es el propósito principal de Flutter?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🟪 Opciones
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  OpcionButton(texto: 'Crear apps móviles nativas'),
                  OpcionButton(texto: 'Diseñar bases de datos'),
                  OpcionButton(texto: 'Gestionar servidores'),
                  OpcionButton(texto: 'Editar imágenes en tiempo real'),
                ],
              ),
            ),

            // 🟩 Barra de progreso
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

// Botón de opción
class OpcionButton extends StatelessWidget {
  final String texto;

  const OpcionButton({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          // Acción al seleccionar respuesta
        },
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
