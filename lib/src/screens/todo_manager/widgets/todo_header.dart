import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../features/profiles/domain/entities/profile.dart';
import '../../../../utils/app_colors.dart';

class TodoHeader extends StatelessWidget {
  final Profile? activeProfile;

  const TodoHeader({super.key, required this.activeProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '${activeProfile?.name ?? ''} Tasks',
          color: AppColors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        const AppText.caption(
          'Manage your daily progress',
          color: AppColors.black54,
        ),
      ],
    );
  }
}
