import 'package:flutter/material.dart';

/// Soft pastel orb decoration.
class SoftOrb extends StatelessWidget {
  final Color color;
  final double size;

  const SoftOrb({
    super.key,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withAlpha(22),
            color.withAlpha(0),
          ],
        ),
      ),
    );
  }
}
