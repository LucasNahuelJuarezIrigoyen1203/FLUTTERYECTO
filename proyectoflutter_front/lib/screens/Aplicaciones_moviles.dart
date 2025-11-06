import 'package:flutter/material.dart';
import '../models/models.dart';
import '../models/usuario_estado.dart';
import '../models/usuario_activo.dart';
import '../service/nivel_service.dart';
import '../service/usuario_service.dart';

class AplicacionesMoviles extends StatelessWidget {
  const AplicacionesMoviles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            fetchNiveles(),
            fetchEstadoUsuario(UsuarioActivo.id),
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final niveles = snapshot.data![0] as List<Nivel>;
            final estado = snapshot.data![1] as UsuarioEstado;

            UsuarioActivo.cargarDesdeEstado(estado);

            final rama = UsuarioActivo.ramasEstado.firstWhere(
              (r) => r.ramaNombre == 'Aplicaciones Móviles',
              orElse: () => RamaEstado(
                ramaId: 3,
                ramaNombre: 'Aplicaciones Móviles',
                nivelActual: 1,
                progreso: 0.0,
              ),
            );

            return Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  rama.ramaNombre,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: niveles.map((nivel) {
                      final desbloqueado = nivel.id <= rama.nivelActual;
                      return NivelCard(
                        nivel: nivel.nombre,
                        icon: desbloqueado ? Icons.play_circle_fill : Icons.lock,
                        color: desbloqueado ? Colors.green : Colors.grey,
                        stars: desbloqueado ? 3 : 0,
                        locked: !desbloqueado,
                        onTap: () {
                          Navigator.pushNamed(context, '/nivel${nivel.id}_teoria');
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Logros'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
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
        leading: Icon(icon, size: 40, color: color),
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
