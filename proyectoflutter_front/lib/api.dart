import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'models/models.dart';

Future<Pregunta> fetchPregunta(int nivelId) async {
  final response = await http.get(Uri.parse('$baseUrl/niveles/$nivelId/pregunta'));
  if (response.statusCode == 200) {
    return Pregunta.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al cargar pregunta');
  }
}

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

Future<List<Nivel>> fetchNiveles() async {
  final response = await http.get(Uri.parse('$baseUrl/niveles'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((n) => Nivel.fromJson(n)).toList();
  } else {
    throw Exception('Error al listar niveles');
  }
}

Future<NivelDetalle> fetchNivelDetalle(int nivelId) async {
  final response = await http.get(Uri.parse('$baseUrl/niveles/$nivelId'));
  if (response.statusCode == 200) {
    return NivelDetalle.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Nivel no encontrado');
  }
}
