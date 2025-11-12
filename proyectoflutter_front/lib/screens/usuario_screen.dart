import 'package:flutter/material.dart';
import '../models/usuario_activo.dart';
import '../service/usuario_service.dart'; // ✅ para llamar al backend

class UsuarioScreen extends StatefulWidget {
  final String nombre;
  final String correo;

  const UsuarioScreen({
    super.key,
    required this.nombre,
    required this.correo,
  });

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final List<String> avatares = [
    'assets/images/ballena_azul.png',
    'assets/images/ballena_gris.png',
    'assets/images/ballena_morada.png',
    'assets/images/ballena_rosa.png',
    'assets/images/cuervo_azul.png',
    'assets/images/cuervo_gris.png',
    'assets/images/cuervo_rosa.png',
    'assets/images/cuervo_verde.png',
    'assets/images/gato_azul.png',
    'assets/images/gato_purpura.png',
    'assets/images/gato_rosa.png',
    'assets/images/gato_verde.png',
    'assets/images/panda_azul.png',
    'assets/images/panda_gris.png',
    'assets/images/panda_rosa.png',
    'assets/images/panda_verde.png',
    'assets/images/panda.png',
    'assets/images/gato.png',
    'assets/images/cuervo.png',
    'assets/images/ballena.png',
  ];

  // ✅ Lista paralela con los nombres de las mascotas
  final List<String> nombresMascotas = [
    'Ballena Azul',
    'Ballena Gris',
    'Ballena Morada',
    'Ballena Rosa',
    'Cuervo Azul',
    'Cuervo Gris',
    'Cuervo Rosa',
    'Cuervo Verde',
    'Gato Azul',
    'Gato Púrpura',
    'Gato Rosa',
    'Gato Verde',
    'Panda Azul',
    'Panda Gris',
    'Panda Rosa',
    'Panda Verde',
    'Panda',
    'Gato',
    'Cuervo',
    'Ballena',
  ];

  int avatarIndex = 0;

  // ✅ Cambiar avatar y sincronizar con backend
  void cambiarAvatar() async {
    setState(() {
      avatarIndex = (avatarIndex + 1) % avatares.length;
    });

    final nombreMascota = nombresMascotas[avatarIndex];

    try {
      await actualizarMascotaPorNombre(UsuarioActivo.id, nombreMascota);
      print('Mascota actualizada a: $nombreMascota');
    } catch (e) {
      print('Error al actualizar mascota: $e');
    }
  }

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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      avatares[avatarIndex],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ✅ Mostrar nombre del usuario
                  Text(
                    widget.nombre,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ✅ Mostrar correo
                  Text(
                    widget.correo,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  // ✅ Mostrar nombre de la mascota activa
                  Text(
                    nombresMascotas[avatarIndex],
                    style: TextStyle(fontSize: 16, color: Colors.teal[600]),
                  ),
                  const SizedBox(height: 24),
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
                      UsuarioActivo.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Cerrar sesión'),
                  ),
                ],
              ),

              // 🔄 Botón para cambiar avatar
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  color: Colors.teal,
                  onPressed: cambiarAvatar,
                  tooltip: 'Cambiar avatar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
