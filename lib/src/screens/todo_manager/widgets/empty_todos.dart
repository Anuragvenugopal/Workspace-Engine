import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class EmptyTodos extends StatelessWidget {
  final Color color;
  const EmptyTodos({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist_rounded, size: context.h(72), color: color.withAlpha(100)),
          SizedBox(height: context.h(16)),
          const AppText.subheading('No tasks yet', color: AppColors.grey),
          SizedBox(height: context.h(8)),
          const AppText.caption('Add your first task above', color: AppColors.grey),
        ],
      ),
    );
  }
}
