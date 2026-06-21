import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

/// Logo card with shadow and icon.
class LogoCard extends StatelessWidget {
  final Size screenSize;

  const LogoCard({
    super.key,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = screenSize.width * 0.38;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: AppColors.personal.withAlpha(40),
            blurRadius: 32,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.28),
        child: Image.asset(
          'assets/images/App_icon.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            Icons.workspaces_rounded,
            size: size * 0.5,
            color: AppColors.personal,
          ),
        ),
      ),
    );
  }
}
