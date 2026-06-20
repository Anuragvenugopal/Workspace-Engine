import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class NavItem {
  final String label;
  final IconData icon;
  final String subtitle;
  final String route;
  final Color color;

  const NavItem({
    required this.label,
    required this.icon,
    required this.subtitle,
    required this.route,
    required this.color,
  });
}

class NavTile extends StatelessWidget {
  final NavItem item;
  final double radius;

  const NavTile({super.key, required this.item, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.h(12)),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => context.push(item.route),
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            padding: EdgeInsets.all(context.w(16)),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryText.withAlpha(5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.w(10)),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.color, size: context.h(22)),
                ),
                SizedBox(width: context.w(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        item.label,
                        fontSize: context.h(15),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                      AppText(
                        item.subtitle,
                        fontSize: context.h(13),
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: context.h(14), color: item.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
