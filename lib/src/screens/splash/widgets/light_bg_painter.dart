import 'package:flutter/material.dart';

/// Painter for the light/white subtle warm-grey gradient background.
class LightBgPainter extends CustomPainter {
  const LightBgPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Pure white base
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // Very subtle warm-grey gradient overlay top→bottom
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFAFAFF), Color(0xFFF0F4FF)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(LightBgPainter old) => false;
}
