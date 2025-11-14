import 'package:flutter/material.dart';
import '../screens/usuario_screen.dart';
import '../models/usuario_activo.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TemaCard(
              title: 'Desarrollo Móvil',
              imagePath: 'assets/images/3.png',
              animalPath: 'assets/images/cuervo.png',
              onTap: () {
                Navigator.pushNamed(context, '/tema1');
              },
            ),
            TemaCard(
              title: 'Desarrollo Web',
              imagePath: 'assets/images/1.png',
              animalPath: 'assets/images/panda_rojo.png',
              onTap: () {
                Navigator.pushNamed(context, '/tema2');
              },
            ),
            TemaCard(
              title: 'Desarrollo de Escritorio',
              imagePath: 'assets/images/2.png',
              animalPath: 'assets/images/ballena.png',
              onTap: () {
                Navigator.pushNamed(context, '/tema3');
              },
            ),
          ],
        ),
      ),
            bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/mascotas');
              break;
            case 1:
              // Ya estás en inicio
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsuarioScreen(
                    nombre: UsuarioActivo.nombre,
                    correo: UsuarioActivo.correo,
                  ),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Widget TemaCard
class TemaCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String animalPath;
  final VoidCallback onTap;

  const TemaCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.animalPath,
    required this.onTap,
  });

  @override
  State<TemaCard> createState() => _TemaCardState();
}

class _TemaCardState extends State<TemaCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? 1.05 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Fondo principal
                  Image.asset(widget.imagePath, fit: BoxFit.cover),

                  // Animal en el lado izquierdo
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Image.asset(
                        widget.animalPath,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Texto centrado con sombra
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
