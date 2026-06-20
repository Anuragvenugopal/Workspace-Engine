import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/todo_provider.dart';
import '../../../../utils/responsive_size.dart';

class CompletionBadge extends StatelessWidget {
  final Color color;

  const CompletionBadge({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final state = todoProvider.state;
        if (state is! TodoLoaded) return const SizedBox.shrink();
        
        return Padding(
          padding: EdgeInsets.only(right: context.w(24)),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.w(12), vertical: context.h(6)),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withAlpha(50), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.track_changes_rounded, size: context.h(16), color: color),
                  SizedBox(width: context.w(6)),
                  Text(
                    '${state.completedCount}/${state.totalCount}',
                    style: TextStyle(
                      color: color,
                      fontSize: context.h(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
