import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/models.dart';

Future<List<Nivel>> fetchNiveles() async {
  final response = await http.get(Uri.parse('$baseUrl/niveles'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((n) => Nivel.fromJson(n)).toList();
  } else {
    throw Exception('Error al listar niveles');
  }
} 

Future<List<Nivel>> fetchNivelesPorRama(int ramaId) async {
  final response = await http.get(Uri.parse('$baseUrl/niveles?rama_id=$ramaId'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((n) => Nivel.fromJson(n)).toList();
  } else {
    throw Exception('Error al listar niveles por rama');
  }
}

// New: fetch niveles by rama name (safer when IDs may be inconsistent)
Future<List<Nivel>> fetchNivelesPorRamaNombre(String ramaNombre) async {
  final encoded = Uri.encodeQueryComponent(ramaNombre);
  final response = await http.get(Uri.parse('$baseUrl/niveles?rama_nombre=$encoded'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((n) => Nivel.fromJson(n)).toList();
  } else {
    throw Exception('Error al listar niveles por rama (por nombre)');
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
