import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/usuario_estado.dart';

Future<UsuarioEstado> fetchEstadoUsuario(int usuarioId) async {
  // If no user is logged in (id == 0) return a guest/default state locally
  if (usuarioId == 0) {
    return Future.value(UsuarioEstado(
      id: 0,
      nombre: 'Invitado',
      correo: '',
      activo: true,
      vidas: 5,
      nivelActual: 1,
      progreso: 0.0,
      ramasEstado: [
        RamaEstado(
          ramaId: 3,
          ramaNombre: 'Aplicaciones Móviles',
          nivelActual: 1,
          progreso: 0.0,
        ),
      ],
    ));
  }

  final response = await http.get(Uri.parse('$baseUrl/estado_usuario/$usuarioId/estado'));
  if (response.statusCode == 200) {
    return UsuarioEstado.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al cargar estado del usuario: ${response.statusCode}');
  }
}
