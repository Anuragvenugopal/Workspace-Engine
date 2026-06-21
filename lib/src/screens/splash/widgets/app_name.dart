import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

/// Two-tone styled application name.
class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: Color(0xFF0F172A),
        ),
        children: [
          TextSpan(text: 'Workspace'),
          TextSpan(
            text: ' Engine',
            style: TextStyle(
              color: AppColors.personal,
              fontWeight: FontWeight.w300,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
