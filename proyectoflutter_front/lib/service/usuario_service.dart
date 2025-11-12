import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/usuario_estado.dart';
import '../models/rama_estado.dart';

/// 🔹 Obtiene el estado completo del usuario desde el backend
Future<UsuarioEstado> fetchEstadoUsuario(int usuarioId) async {
  if (usuarioId == 0) {
    // Estado por defecto para invitados
    return Future.value(
      UsuarioEstado(
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
        mascotaActiva: null,
      ),
    );
  }

  final response = await http.get(
    Uri.parse('$baseUrl/estado_usuario/$usuarioId/estado'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return UsuarioEstado.fromJson(data);
  } else {
    throw Exception(
      'Error al cargar estado del usuario: ${response.statusCode}',
    );
  }
}

/// 🔹 Login de usuario
Future<UsuarioEstado> loginUsuario(String correo, String contrasena) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'correo': correo,
      'contrasena': contrasena,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return UsuarioEstado.fromJson(data);
  } else {
    throw Exception('Error en login: ${response.body}');
  }
}

/// 🔹 Registro de usuario
Future<UsuarioEstado> registrarUsuario(
  String nombre,
  String correo,
  String contrasena,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/registro'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return UsuarioEstado.fromJson(data);
  } else {
    throw Exception('Error en registro: ${response.body}');
  }
}

/// 🔹 Actualiza la mascota activa del usuario
Future<void> actualizarMascotaActiva(int usuarioId, int mascotaId) async {
  final response = await http.post(
    Uri.parse('$baseUrl/usuarios/$usuarioId/mascota'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'mascota_id': mascotaId}),
  );

  if (response.statusCode == 200) {
    print('Mascota activa actualizada correctamente');
  } else {
    throw Exception('Error al actualizar mascota: ${response.body}');
  }
}

Future<void> actualizarMascotaPorNombre(int usuarioId, String nombreMascota) async {
  final response = await http.post(
    Uri.parse('$baseUrl/usuarios/$usuarioId/mascota_por_nombre'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'nombre': nombreMascota}),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar mascota por nombre: ${response.body}');
  }
}

