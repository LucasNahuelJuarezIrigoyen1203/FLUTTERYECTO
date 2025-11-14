import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/pagina_inicial.dart';
import 'screens/aplicaciones_moviles.dart';
import 'screens/Web.dart';
import 'screens/Desktop.dart';
import 'screens/mascotas_screen.dart';

void main() {
  // 🔒 Limpia cualquier estado previo al iniciar la app
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khroma',
      debugShowCheckedModeBanner: false,
      // 🚪 Siempre arranca en login
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/paginainicial': (context) => const PaginaInicial(),
        '/tema1': (context) => const AplicacionesMovilesPage(),
        '/tema2': (context) => const Tema2Page(),
        '/tema3': (context) => const Tema3Page(),
        '/mascotas': (context) => const MascotasScreen(),
      },
    );
  }
}
