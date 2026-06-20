import 'package:flutter/material.dart';
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
          if (small)
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1.2,
                  ),
            )
          else
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          SizedBox(height: context.h(2)),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
