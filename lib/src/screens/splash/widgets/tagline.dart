import 'package:flutter/material.dart';

/// Tagline under the app name.
class Tagline extends StatelessWidget {
  const Tagline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'One app. Every version of you.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF64748B),
        letterSpacing: 0.3,
      ),
    );
  }
}
