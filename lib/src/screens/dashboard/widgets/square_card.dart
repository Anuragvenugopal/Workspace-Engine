import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class SquareCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final Color color;

  const SquareCard({
    super.key,
    required this.label,
    required this.icon,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          width: context.w(140),
          height: context.h(120),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withAlpha(50), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryText.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: context.h(36), color: color),
              SizedBox(height: context.h(16)),
              AppText(
                label,
                fontSize: context.h(14),
                fontWeight: FontWeight.w600,
                color: AppColors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
