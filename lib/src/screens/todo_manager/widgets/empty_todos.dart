import 'package:flutter/material.dart';
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
          Text(
            'No tasks yet',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.grey),
          ),
          SizedBox(height: context.h(8)),
          const Text('Add your first task above',
              style: TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }
}
