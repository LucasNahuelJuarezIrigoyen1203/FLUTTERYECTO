import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'models/models.dart';

/// Obtiene una pregunta para un nivel específico.
/// Si se pasa un [preguntaId], trae esa pregunta en particular.
Future<Pregunta> fetchPregunta(int nivelId, {int? preguntaId}) async {
  final url = preguntaId != null
      ? '$baseUrl/niveles/$nivelId/pregunta?id=$preguntaId'
      : '$baseUrl/niveles/$nivelId/pregunta';

  print('→ GET $url');

  final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data == null || data['id'] == null) {
      throw Exception('Pregunta vacía o malformada');
    }
    return Pregunta.fromJson(data);
  } else {
    print('Error HTTP: ${response.statusCode} - ${response.body}');
    throw Exception('Error al cargar pregunta');
  }
}

/// Envía la respuesta seleccionada por el usuario y devuelve el resultado (vidas, progreso).
Future<RespuestaOutput> enviarRespuesta({
  required int usuarioId,
  required int preguntaId,
  required int opcionId,
}) async {
  final url = '$baseUrl/respuestas';
  final body = jsonEncode({
    'usuario_id': usuarioId,
    'pregunta_id': preguntaId,
    'opcion_seleccionada': opcionId,
  });

  print('→ POST $url');
  print('→ Body: $body');

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RespuestaOutput.fromJson(data);
    } else {
      print('Error HTTP: ${response.statusCode} - ${response.body}');
      throw Exception('Error al validar respuesta');
    }
  } catch (e) {
    print('Error en enviarRespuesta: $e');
    throw Exception('Error al validar respuesta: $e');
  }
}

/// Lista todos los niveles disponibles.
Future<List<Nivel>> fetchNiveles() async {
  final url = '$baseUrl/niveles';
  print('→ GET $url');

  final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((n) => Nivel.fromJson(n)).toList();
  } else {
    print('Error HTTP: ${response.statusCode} - ${response.body}');
    throw Exception('Error al listar niveles');
  }
}

/// Obtiene el detalle completo de un nivel específico.
Future<NivelDetalle> fetchNivelDetalle(int nivelId) async {
  final url = '$baseUrl/niveles/$nivelId';
  print('→ GET $url');

  final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    return NivelDetalle.fromJson(jsonDecode(response.body));
  } else {
    print('Error HTTP: ${response.statusCode} - ${response.body}');
    throw Exception('Nivel no encontrado');
  }
}
