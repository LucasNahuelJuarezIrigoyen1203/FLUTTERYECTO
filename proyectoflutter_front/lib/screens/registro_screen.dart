import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../widgets/corner_animals.dart'; // ajustá la ruta si es necesario

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
  bool _loading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _userController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _registrar() async {
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
      return;
    }
    if (correo != confirmCorreo) {
      _mostrarMensaje('Los correos no coinciden 📧');
      return;
    }
    if (contrasena != confirmContrasena) {
      _mostrarMensaje('Las contraseñas no coinciden 🔐');
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuarios'),
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
        final mensaje = data['mensaje'] ?? 'Registrado';
        final nombreResp = data['usuario']?['nombre'] ?? usuario;
        _mostrarMensaje('$mensaje, $nombreResp! 😎');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) Navigator.pop(context);
        });
      } else {
        String detalle = 'Algo salió mal';
        try {
          final error = jsonDecode(response.body);
          detalle = error['detail'] ?? error['mensaje'] ?? detalle;
        } catch (_) {}
        _mostrarMensaje('Error: $detalle');
      }
    } catch (e) {
      _mostrarMensaje('Error de conexión: $e ⚠️');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 400 ? screenWidth * 0.9 : 350.0;

    return Scaffold(
      backgroundColor: const Color(0xFFA1CDC4),
      body: Stack(
        children: [
          const IgnorePointer(child: CornerAnimals()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  width: cardWidth,
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
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _userController,
                        decoration: const InputDecoration(labelText: 'Usuario'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmEmailController,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar correo',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmPassController,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar contraseña',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _registrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[400],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Registrarse'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _loading
                            ? null
                            : () => Navigator.pop(context),
                        child: const Text('Volver al login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
