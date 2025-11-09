import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginUsuario(String correo, String password) async {
  final url = Uri.parse('http://TU_BACKEND_URL/login'); // ← reemplazá con tu URL real

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'correo': correo, 'password': password}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error de login: ${response.statusCode}');
  }
}
