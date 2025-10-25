import 'package:flutter/material.dart';

class Tema2Page extends StatelessWidget {
  const Tema2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Sistemas Operativos y Redes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
            ),
            const SizedBox(height: 32),

            // Niveles
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  NivelCard(
                    nivel: 'Nivel 1',
                    icon: Icons.play_circle_fill,
                    color: Colors.green,
                    stars: 2,
                    locked: false,
                    onTap: () {
                      Navigator.pushNamed(context, '/nivel1_teoria');
                    },
                  ),
                  NivelCard(
                    nivel: 'Nivel 2',
                    icon: Icons.lock,
                    color: Colors.amber,
                    stars: 2,
                    locked: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/nivel2_teoria');
                    }, // bloqueado
                  ),
                  NivelCard(
                    nivel: 'Nivel 3',
                    icon: Icons.lock,
                    color: Colors.redAccent,
                    stars: 3,
                    locked: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/nivel3_teoria');
                    }, // bloqueado
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Footer
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/logros');
              break;
            case 1:
              Navigator.pushNamed(context, '/paginainicial');
              break;
            case 2:
              Navigator.pushNamed(context, '/perfil');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Widget para cada nivel
class NivelCard extends StatelessWidget {
  final String nivel;
  final IconData icon;
  final Color color;
  final int stars;
  final bool locked;
  final VoidCallback onTap;

  const NivelCard({
    super.key,
    required this.nivel,
    required this.icon,
    required this.color,
    required this.stars,
    required this.locked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: color,
        ),
        title: Text(
          nivel,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Row(
          children: List.generate(
            stars,
            (index) => const Icon(Icons.star, size: 20, color: Colors.black87),
          ),
        ),
        trailing: locked
            ? const Icon(Icons.lock_outline, color: Color.fromARGB(255, 175, 175, 175))
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: locked ? null : onTap,
      ),
    );
  }
}
