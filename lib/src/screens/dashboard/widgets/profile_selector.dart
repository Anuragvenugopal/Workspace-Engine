import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../features/profiles/domain/entities/profile.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

/// Pure stateless widget — receives all data as constructor params.
/// No cubit access inside. Calls onProfileSelected when a chip is tapped,
/// which the parent handles via context.read for ProfileCubit interaction.
class ProfileSelector extends StatelessWidget {
  final List<Profile> profiles;
  final Profile? activeProfile;
  final ValueChanged<Profile> onProfileSelected;

  const ProfileSelector({
    super.key,
    required this.profiles,
    required this.activeProfile,
    required this.onProfileSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.h(52),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.w(20)),
        itemCount: profiles.length,
        separatorBuilder: (_, __) => SizedBox(width: context.w(8)),
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final isActive = activeProfile?.id == profile.id;
          final color = AppTheme.getProfileColor(profile.type);
          final isCorporate = profile.type == ProfileType.corporate;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: FilterChip(
              padding: EdgeInsets.symmetric(
                  horizontal: context.w(12), vertical: context.h(8)),
              backgroundColor: isActive ? color : AppColors.transparent,
              shape: isCorporate
                  ? const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
              side: BorderSide(
                color: isActive ? color : AppColors.border,
                width: 1.5,
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppTheme.getProfileIcon(profile.type),
                    size: context.h(16),
                    color: isActive ? AppColors.white : color,
                  ),
                  SizedBox(width: context.w(6)),
                  Text(
                    profile.name,
                    style: TextStyle(
                      color: isActive ? AppColors.white : color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              selected: isActive,
              onSelected: (_) => onProfileSelected(profile),
              selectedColor: color,
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
