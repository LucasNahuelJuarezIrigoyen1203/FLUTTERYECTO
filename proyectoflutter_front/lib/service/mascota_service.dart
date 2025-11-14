import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/mascota.dart';

/// 🔹 Obtener todas las mascotas
Future<List<Mascota>> fetchTodasLasMascotas() async {
  final response = await http.get(Uri.parse('$baseUrl/mascotas'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Mascota.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar mascotas: ${response.body}');
  }
}

/// 🔹 Actualizar mascota activa del usuario por nombre
Future<void> actualizarMascotaPorNombre(
  int usuarioId,
  String nombreMascota,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/mascotas/usuarios/$usuarioId/mascota_por_nombre'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'nombre': nombreMascota}),
  );

  if (response.statusCode == 200) {
    print("✅ Mascota actualizada a $nombreMascota para usuario $usuarioId");
  } else {
    throw Exception('Error al actualizar mascota por nombre: ${response.body}');
  }
}
