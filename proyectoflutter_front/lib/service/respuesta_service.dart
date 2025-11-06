import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/models.dart';

Future<RespuestaOutput> enviarRespuesta({
  required int usuarioId,
  required int preguntaId,
  required int opcionId,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/respuestas'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'usuario_id': usuarioId,
      'pregunta_id': preguntaId,
      'opcion_seleccionada': opcionId,
    }),
  );

  if (response.statusCode == 200) {
    return RespuestaOutput.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al validar respuesta');
  }
}
