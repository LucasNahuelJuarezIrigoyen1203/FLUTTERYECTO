import 'package:flutter/material.dart';
import '../widgets/avatar_por_defecto.dart';
import '../models/usuario_activo.dart';

class UsuarioScreen extends StatelessWidget {
  final String nombre;
  final String correo;

  const UsuarioScreen({
    super.key,
    required this.nombre,
    required this.correo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA1CDC4),
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.teal[400],
      ),
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
              const AvatarPorDefecto(size: 100),
              const SizedBox(height: 16),
              Text(
                nombre,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                correo,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),

              // 🔑 Botón de cerrar sesión
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  UsuarioActivo.logout(); // limpia datos en memoria
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
