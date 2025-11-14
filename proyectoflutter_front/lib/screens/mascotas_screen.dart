import 'package:flutter/material.dart';
import '../models/mascota.dart';
import '../service/mascota_service.dart';
import '../models/usuario_activo.dart';

class MascotasScreen extends StatefulWidget {
  const MascotasScreen({super.key});

  @override
  State<MascotasScreen> createState() => _MascotasScreenState();
}

class _MascotasScreenState extends State<MascotasScreen> {
  List<Mascota> mascotas = [];
  bool cargando = true;
  int? mascotaSeleccionada; // para marcar la mascota activa

  @override
  void initState() {
    super.initState();
    cargarMascotas();
  }

  Future<void> cargarMascotas() async {
    try {
      final lista = await fetchTodasLasMascotas();
      setState(() {
        mascotas = lista;
        cargando = false;
      });
    } catch (e) {
      print('Error al cargar mascotas: $e');
      setState(() => cargando = false);
    }
  }

  Future<void> seleccionarMascota(Mascota mascota) async {
    try {
      await actualizarMascotaPorNombre(UsuarioActivo.id, mascota.nombre);
      setState(() {
        mascotaSeleccionada = mascota.id;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Mascota actualizada a ${mascota.nombre}"),
          backgroundColor: Colors.teal,
        ),
      );
    } catch (e) {
      print("Error al actualizar mascota: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al actualizar mascota"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas las Mascotas'),
        backgroundColor: Colors.teal,
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mascotas.length,
              itemBuilder: (context, index) {
                final mascota = mascotas[index];
                final seleccionada = mascotaSeleccionada == mascota.id;

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: seleccionada ? Colors.teal : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => seleccionarMascota(mascota),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🔹 Ajusta según si usás assets o URLs
                        Image.asset(
                          'assets/images/${mascota.imagen}',
                          height: 80,
                          width: 80,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.pets, size: 80),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mascota.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
