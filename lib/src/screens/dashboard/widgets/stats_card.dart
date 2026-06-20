import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

/// Pure stateless stats card widget — dumb component with no cubit access.
class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool small;

  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w(16)),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.h(24), color: color),
          SizedBox(height: context.h(12)),
          AppText(
            value,
            fontSize: small ? context.h(14) : context.h(28),
            fontWeight: FontWeight.bold,
            color: color,
          ),
          SizedBox(height: context.h(2)),
          AppText(
            label,
            fontSize: context.h(12),
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
