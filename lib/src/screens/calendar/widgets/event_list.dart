import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../features/profiles/domain/entities/todo.dart';
import '../../../../providers/calendar_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class EventList extends StatelessWidget {
  final CalendarState state;
  final ProfileType profileType;
  final List<Todo> todos;

  const EventList({
    super.key,
    required this.state,
    required this.profileType,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final isCorporate = profileType == ProfileType.corporate;

    final baseColor = AppTheme.getProfileColor(profileType);
    final color = isCorporate ? Colors.blueGrey[800]! : baseColor;
    final radius = isCorporate ? 0.0 : 12.0;

    final selectedDay = state.selectedDay ?? state.focusedDay;
    final events = todos.where((todo) {
      if (todo.dueDate == null) return false;
      return isSameDay(todo.dueDate, selectedDay);
    }).toList();

    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available_rounded,
                size: context.h(48), color: color.withAlpha(100)),
            SizedBox(height: context.h(12)),
            const AppText.caption('No events on this day', color: AppColors.grey),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(context.w(16)),
      itemCount: events.length,
      separatorBuilder: (_, __) => SizedBox(height: context.h(8)),
      itemBuilder: (context, index) {
        final event = events[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(12)),
          decoration: BoxDecoration(
            color: color.withAlpha(13),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: color.withAlpha(51)),
          ),
          child: Row(
            children: [
              Icon(isCorporate ? Icons.square : Icons.circle, size: context.h(10), color: color),
              SizedBox(width: context.w(12)),
              Expanded(
                child: AppText(
                  event.title,
                  fontWeight: FontWeight.w500,
                  decoration: event.isCompleted ? TextDecoration.lineThrough : null,
                  color: event.isCompleted ? AppColors.grey : AppColors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
