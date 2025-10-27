import 'package:flutter/material.dart';

class AvatarPorDefecto extends StatelessWidget {
  final double size;

  const AvatarPorDefecto({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.asset(
        'assets/images/panda_rojo.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
