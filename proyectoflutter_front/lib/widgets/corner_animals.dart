import 'package:flutter/material.dart';

class CornerAnimals extends StatelessWidget {
  final double padding;
  final double size;

  const CornerAnimals({super.key, this.padding = 0.0, this.size = 200.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: padding,
          left: padding,
          child: AnimalImage(path: 'assets/images/ballena.png', size: size),
        ),
        Positioned(
          top: padding,
          right: padding,
          child: AnimalImage(path: 'assets/images/cuervo.png', size: size),
        ),
        Positioned(
          bottom: padding,
          left: padding,
          child: AnimalImage(path: 'assets/images/gato.png', size: size),
        ),
        Positioned(
          bottom: padding,
          right: padding,
          child: AnimalImage(path: 'assets/images/panda_rojo.png', size: size),
        ),
      ],
    );
  }
}

class AnimalImage extends StatelessWidget {
  final String path;
  final double size;

  const AnimalImage({required this.path, this.size = 80.0, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: size, height: size, fit: BoxFit.contain);
  }
}
