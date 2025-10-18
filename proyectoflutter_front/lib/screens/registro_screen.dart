import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _nombreController = TextEditingController();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

    void _registrar() async {
    final nombre = _nombreController.text.trim();
    final usuario = _userController.text.trim();
    final correo = _emailController.text.trim();
    final confirmCorreo = _confirmEmailController.text.trim();
    final contrasena = _passController.text;
    final confirmContrasena = _confirmPassController.text;
  
    if (nombre.isEmpty ||
        usuario.isEmpty ||
        correo.isEmpty ||
        confirmCorreo.isEmpty ||
        contrasena.isEmpty ||
        confirmContrasena.isEmpty) {
      _mostrarMensaje('Todos los campos son obligatorios ❗');
    } else if (correo != confirmCorreo) {
      _mostrarMensaje('Los correos no coinciden 📧');
    } else if (contrasena != confirmContrasena) {
      _mostrarMensaje('Las contraseñas no coinciden 🔐');
    } else {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/usuarios'), // IP local del backend
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nombre': nombre,
            'usuario': usuario,
            'correo': correo,
            'contrasena': contrasena,
          }),
        );
  
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final mensaje = data['mensaje'];
        final nombre = data['usuario']['nombre'];
      
        _mostrarMensaje('$mensaje, $nombre! 😎');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context); // Volver al login
          }
        });
      } else {
        final error = jsonDecode(response.body);
        _mostrarMensaje('Error: ${error['detail']}');
      }

      } catch (e) {
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
      backgroundColor: const Color(0xFFA1CDC4), // Fondo pastel
      body: Center(
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
                'Registro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
              ),
              TextField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _confirmEmailController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar correo',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Volver al login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
