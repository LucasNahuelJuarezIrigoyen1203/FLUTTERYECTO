import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/models.dart';

Future<Pregunta> fetchPregunta(int nivelId) async {
  final response = await http.get(Uri.parse('$baseUrl/niveles/$nivelId/pregunta'));
  if (response.statusCode == 200) {
    return Pregunta.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al cargar pregunta');
  }
}
