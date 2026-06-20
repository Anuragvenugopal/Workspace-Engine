import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/profiles/domain/entities/profile.dart';
import '../../../../providers/profile_provider.dart';
import '../../../../utils/responsive_size.dart';

class DashboardDrawer extends StatelessWidget {
  final List<Profile> profiles;
  final Profile? activeProfile;
  final Color activeColor;
  final ProfileProvider profileProvider;

  const DashboardDrawer({
    super.key,
    required this.profiles,
    required this.activeProfile,
    required this.activeColor,
    required this.profileProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: activeColor.withAlpha(240),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: context.h(24)),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: context.h(100),
                  height: context.h(100),
                  margin: EdgeInsets.only(bottom: context.h(24)),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/home_image.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Workspaces',
                  style: TextStyle(
                    fontSize: context.h(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.h(24)),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      final isActive = activeProfile?.id == profile.id;

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: context.w(32), vertical: context.h(4)),
                        leading: Icon(
                          AppTheme.getProfileIcon(profile.type),
                          color: isActive ? Colors.white : Colors.white70,
                          size: context.h(28),
                        ),
                        title: Text(
                          profile.name,
                          style: TextStyle(
                            fontSize: context.h(18),
                            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                            color: isActive ? Colors.white : Colors.white70,
                          ),
                        ),
                        trailing: isActive
                            ? const Icon(Icons.check_circle_rounded, color: Colors.white)
                            : null,
                        onTap: () {
                          profileProvider.switchProfile(profile);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
