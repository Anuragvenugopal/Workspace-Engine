import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../features/profiles/domain/entities/todo.dart';
import '../../../../providers/todo_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Color color;

  const TodoItem({super.key, required this.todo, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(2)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(20), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryText.withAlpha(2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.w(16),
          vertical: context.h(4),
        ),
        leading: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: todo.isCompleted,
            activeColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: BorderSide(color: color.withAlpha(100), width: 2),
            onChanged: (_) => context.read<TodoProvider>().toggleTodo(todo.id),
          ),
        ),
        title: Row(
          children: [
            if (todo.isImportant) ...[
              const Icon(Icons.star_rounded, color: AppColors.star, size: 18),
              SizedBox(width: context.w(6)),
            ],
            Expanded(
              child: AppText(
                todo.title,
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: todo.isCompleted ? AppColors.grey : AppColors.black87,
                fontWeight: FontWeight.w600,
                fontSize: context.h(15),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: context.h(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.description != null && todo.description!.isNotEmpty) ...[
                AppText(
                  todo.description!,
                  fontSize: context.h(13),
                  color: AppColors.black54,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.h(4)),
              ],
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: context.h(12),
                    color: AppColors.black38,
                  ),
                  SizedBox(width: context.w(4)),
                  AppText(
                    todo.dueDate != null
                        ? 'Due: ${_formatDate(todo.dueDate!)}'
                        : 'Created: ${_formatDate(todo.createdAt)}',
                    fontSize: context.h(12),
                    color: todo.dueDate != null
                        ? color.withAlpha(200)
                        : AppColors.black45,
                    fontWeight: todo.dueDate != null
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.warning.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              color: AppColors.warning,
              size: context.h(20),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: context.w(8)),
                      const AppText('Delete Task', fontWeight: FontWeight.bold),
                    ],
                  ),
                  content: AppText(
                    'Are you sure you want to delete "${todo.title}"? This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const AppText('Cancel', color: AppColors.black54),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.read<TodoProvider>().deleteTodo(todo.id);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.warning,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const AppText(
                        'Delete',
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
