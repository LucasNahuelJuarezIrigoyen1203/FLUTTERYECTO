import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registro_screen.dart';
import '../config.dart';
import '../widgets/corner_animals.dart'; // Asegurate de importar tu widget

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _login() async {
    final correo = _userController.text.trim();
    final contrasena = _passController.text;

    if (correo.isEmpty || contrasena.isEmpty) {
      _mostrarMensaje('Completá todos los campos 📝');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': correo, 'contrasena': contrasena}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _mostrarMensaje(
          '¡Bienvenido a khroma, un gusto recibirte ${data['nombre']}! 🎉',
        );
        Navigator.pushReplacementNamed(context, '/paginainicial');
      } else {
        _mostrarMensaje('Login fallido: ${response.body} ❌');
      }
    } catch (e) {
      if (mounted) {
        _mostrarMensaje('Error de conexión: $e ⚠️');
      }
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA1CDC4),
      body: Stack(
        children: [
          const CornerAnimals(
            padding: 0,
            size: 200,
          ), // 🐾 Animalitos decorativos
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _userController,
                    decoration: const InputDecoration(labelText: 'Correo'),
                  ),
                  TextField(
                    controller: _passController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Ingresar'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistroScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[200],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Registrarse'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
