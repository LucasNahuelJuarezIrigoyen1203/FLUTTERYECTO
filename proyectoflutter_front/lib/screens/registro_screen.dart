import 'package:flutter/material.dart';

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

  void _registrar() {
    final nombre = _nombreController.text;
    final user = _userController.text;
    final email = _emailController.text;
    final confirmEmail = _confirmEmailController.text;
    final pass = _passController.text;
    final confirmPass = _confirmPassController.text;

    if (nombre.isEmpty ||
        user.isEmpty ||
        email.isEmpty ||
        confirmEmail.isEmpty ||
        pass.isEmpty ||
        confirmPass.isEmpty) {
      _mostrarMensaje('Todos los campos son obligatorios ❗');
    } else if (email != confirmEmail) {
      _mostrarMensaje('Los correos no coinciden 📧');
    } else if (pass != confirmPass) {
      _mostrarMensaje('Las contraseñas no coinciden 🔐');
    } else {
      _mostrarMensaje('Registro exitoso 🎉');
      // Aquí podrías guardar el usuario o navegar a otra pantalla
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
