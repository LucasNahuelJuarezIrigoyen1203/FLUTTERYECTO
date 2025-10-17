import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: const Center(
        child: Text(
          'Pantalla de registro en construcción 🚧',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
