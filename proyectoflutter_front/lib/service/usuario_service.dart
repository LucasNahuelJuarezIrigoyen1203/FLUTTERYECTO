import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/usuario_estado.dart';

Future<UsuarioEstado> fetchEstadoUsuario(int usuarioId) async {
  final response = await http.get(Uri.parse('$baseUrl/estado_usuario/$usuarioId'));
  if (response.statusCode == 200) {
    return UsuarioEstado.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al cargar estado del usuario');
  }
}
