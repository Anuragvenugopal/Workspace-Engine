import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/responsive_size.dart';
import 'widgets/add_todo_sheet.dart';
import 'widgets/todo_list.dart';

class TodoManagerPage extends StatefulWidget {
  const TodoManagerPage({super.key});

  @override
  State<TodoManagerPage> createState() => _TodoManagerPageState();
}

class _TodoManagerPageState extends State<TodoManagerPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Defer the provider call to avoid 'setState or markNeedsBuild called during build' error.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileId = context.read<ProfileProvider>().state.activeProfile?.id;
      if (profileId != null) {
        context.read<TodoProvider>().loadForProfile(profileId);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch ProfileProvider so we reload todos when active profile changes
    // while this page is open.
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profileState = profileProvider.state;
        final profileType =
            profileState.activeProfile?.type ?? ProfileType.personal;
        final color = AppTheme.getProfileColor(profileType);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F7F9),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profileState.activeProfile?.name ?? ''} Tasks',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Manage your daily progress',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            actions: [_buildCompletionBadge(context, color)],
            centerTitle: false,
          ),
          body: TodoList(color: color),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => AddTodoSheet(color: color),
              );
            },
            backgroundColor: color,
            icon: const Icon(Icons.add_task_rounded, color: Colors.white),
            label: const Text(
              'Add Task',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompletionBadge(BuildContext context, Color color) {
    // Consumer scoped to just what it needs (TodoProvider)
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final state = todoProvider.state;
        if (state is! TodoLoaded) return const SizedBox.shrink();

        final progress = state.totalCount == 0
            ? 0.0
            : state.completedCount / state.totalCount;

        return Padding(
          padding: EdgeInsets.only(right: context.w(24)),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(12),
                vertical: context.h(6),
              ),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withAlpha(50), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.track_changes_rounded,
                    size: context.h(16),
                    color: color,
                  ),
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
