import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final String backgroundImage;
  final Widget child;
  final Color? overlayColor; // usa para oscurecer o colorear el fondo
  final double overlayOpacity;
  final Widget? bottomNavigationBar;

  const BackgroundScaffold({
    Key? key,
    required this.backgroundImage,
    required this.child,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.35,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      // Si quieres que la AppBar sea transparente, configúrala aquí
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
          if (overlayOpacity > 0)
            Container(
              color: (overlayColor ?? Colors.black).withOpacity(overlayOpacity),
            ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}