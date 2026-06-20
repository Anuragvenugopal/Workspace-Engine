import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/todo_provider.dart';
import 'widgets/add_todo_sheet.dart';
import 'widgets/todo_list.dart';
import 'widgets/completion_badge.dart';
import 'widgets/todo_header.dart';

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
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profileState = profileProvider.state;
        final profileType = profileState.activeProfile?.type ?? ProfileType.personal;
        final color = AppTheme.getProfileColor(profileType);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F7F9),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            title: TodoHeader(activeProfile: profileState.activeProfile),
            actions: [CompletionBadge(color: color)],
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
            label: const Text('Add Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
