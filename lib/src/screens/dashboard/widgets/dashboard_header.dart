import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../features/profiles/domain/entities/profile.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class DashboardHeader extends StatelessWidget {
  final Profile? activeProfile;

  const DashboardHeader({super.key, required this.activeProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (innerContext) => IconButton(
            onPressed: () => Scaffold.of(innerContext).openDrawer(),
            icon: Icon(
              Icons.menu_rounded,
              color: AppColors.black87,
              size: context.h(28),
            ),
          ),
        ),
        SizedBox(width: context.w(8)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Hey, ${activeProfile?.name ?? 'Workspace User'}',
              fontSize: context.h(26),
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
            SizedBox(height: context.h(4)),
            AppText(
              _getHeaderSubtitle(activeProfile?.type),
              fontSize: context.h(14),
              color: AppColors.black54,
            ),
          ],
        ),
      ],
    );
  }

  String _getHeaderSubtitle(ProfileType? type) {
    switch (type) {
      case ProfileType.work:
        return 'Stay focused and crush your goals';
      case ProfileType.corporate:
        return 'Professional Dashboard Overview';
      case ProfileType.creative:
        return 'Let your imagination run wild';
      case ProfileType.personal:
      default:
        return 'Enjoy your day!';
    }
  }
}
