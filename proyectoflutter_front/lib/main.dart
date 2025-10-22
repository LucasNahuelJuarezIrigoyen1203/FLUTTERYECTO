import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/pagina_inicial.dart';
import 'screens/pagina-tema1.dart';
import 'screens/pagina-tema2.dart';
import 'screens/pagina-tema3.dart';

void main() {
  runApp(const LoginApp());
}



class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/paginainicial': (context) => const PaginaInicial(),
        '/tema1': (context) => const Tema1Page(),
        '/tema2': (context) => const Tema2Page(),
        '/tema3': (context) => const Tema3Page(),
      },
    );
  }
}
