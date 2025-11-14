import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/mascota.dart';

Future<List<Mascota>> fetchTodasLasMascotas() async {
  final response = await http.get(Uri.parse('$baseUrl/mascotas'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Mascota.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar mascotas: ${response.body}');
  }
}
