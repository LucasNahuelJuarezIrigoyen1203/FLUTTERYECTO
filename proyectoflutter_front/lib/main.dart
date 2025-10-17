import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mi App Flutter',
      home:
          LoginScreen(), // ← Asegurate que LoginScreen tenga constructor const
      debugShowCheckedModeBanner: false,
    );
  }
}
