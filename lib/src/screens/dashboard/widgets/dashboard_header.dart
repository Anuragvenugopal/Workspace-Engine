import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/profiles/domain/entities/profile.dart';
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
              color: Colors.black87,
              size: context.h(28),
            ),
          ),
        ),
        SizedBox(width: context.w(8)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey, ${activeProfile?.name ?? 'Workspace User'}',
              style: TextStyle(
                fontSize: context.h(26),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: context.h(4)),
            Text(
              _getHeaderSubtitle(activeProfile?.type),
              style: TextStyle(
                fontSize: context.h(14),
                color: Colors.black54,
              ),
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
