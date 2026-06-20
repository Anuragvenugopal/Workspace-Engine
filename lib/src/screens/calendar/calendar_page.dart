import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../features/profiles/domain/entities/todo.dart';
import '../../../providers/todo_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/calendar_provider.dart';
import 'widgets/calendar_view.dart';
import 'widgets/event_list.dart';
import 'widgets/profile_label.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileType = context.select<ProfileProvider, ProfileType>(
      (p) => p.state.activeProfile?.type ?? ProfileType.personal,
    );

    final todoState = context.watch<TodoProvider>().state;
    final todos = todoState is TodoLoaded ? todoState.todos : <Todo>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F9),
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: ProfileLabel(profileType: profileType),
      ),
      body: Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {
          final state = calendarProvider.state;
          return Column(
            children: [
              CalendarView(
                state: state,
                profileType: profileType,
                todos: todos,
              ),
              const Divider(height: 1),
              Expanded(
                child: EventList(
                  state: state,
                  profileType: profileType,
                  todos: todos,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

