import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../features/profiles/domain/entities/todo.dart';
import '../../../../providers/calendar_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class CalendarView extends StatelessWidget {
  final CalendarState state;
  final ProfileType profileType;
  final List<Todo> todos;

  const CalendarView({
    super.key,
    required this.state,
    required this.profileType,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final isCorporate = profileType == ProfileType.corporate;
    final isCreative = profileType == ProfileType.creative;

    // Monochrome styling for Corporate, Vibrant for Creative
    final baseColor = AppTheme.getProfileColor(profileType);
    final color = isCorporate ? Colors.blueGrey[800]! : baseColor;
    final accent = isCorporate ? Colors.blueGrey[600]! : AppTheme.getProfileAccent(profileType);

    // CalendarStyle is pure data — computed from profileType, no side effects
    final calStyle = CalendarStyle(
      // Corporate: rectangular cells, monochrome
      // Creative: rounded + vibrant markers with gradient feel
      todayDecoration: BoxDecoration(
        color: color.withAlpha(51),
        shape: isCorporate ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isCorporate ? BorderRadius.zero : null,
      ),
      selectedDecoration: BoxDecoration(
        color: color,
        shape: isCorporate ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isCorporate ? BorderRadius.zero : null,
        boxShadow: isCreative
            ? [
                BoxShadow(
                    color: color.withAlpha(100), blurRadius: 8, spreadRadius: 2)
              ]
            : null,
      ),
      todayTextStyle: TextStyle(
          color: color, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
      selectedTextStyle: const TextStyle(
          color: AppColors.white, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
      markerDecoration: BoxDecoration(
        color: isCreative ? accent : color,
        shape: isCorporate ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isCorporate ? BorderRadius.zero : null,
      ),
      markerMargin: isCorporate
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: context.w(1)),
      cellMargin: isCorporate
          ? EdgeInsets.zero
          : EdgeInsets.all(context.w(4)),
      outsideDaysVisible: false,
    );

    final headerStyle = HeaderStyle(
      formatButtonVisible: true,
      titleCentered: true,
      formatButtonDecoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: isCorporate ? BorderRadius.zero : BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(77)),
      ),
      formatButtonTextStyle: TextStyle(color: color, fontSize: context.h(12)),
      titleTextStyle: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w600, color: color),
    );

    return AnimatedScale(
      scale: isCreative ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(context.w(16)),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: isCorporate ? BorderRadius.zero : BorderRadius.circular(24),
          // Creative: soft shadow; Corporate: hard edge
          boxShadow: isCreative
              ? [
                  BoxShadow(
                      color: color.withAlpha(26),
                      blurRadius: 12,
                      spreadRadius: 2)
                ]
              : [],
        ),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: state.focusedDay,
          calendarFormat: state.calendarFormat,
          selectedDayPredicate: (day) =>
              isSameDay(state.selectedDay, day),
          eventLoader: (day) {
            return todos.where((todo) {
              if (todo.dueDate == null) return false;
              return isSameDay(todo.dueDate, day);
            }).toList();
          },
          calendarStyle: calStyle,
          headerStyle: headerStyle,
          // All callbacks use context.read — inside event handlers, not build
          onDaySelected: (selected, focused) =>
              context.read<CalendarProvider>().onDaySelected(selected, focused),
          onFormatChanged: (format) =>
              context.read<CalendarProvider>().onFormatChanged(format),
          onPageChanged: (focused) =>
              context.read<CalendarProvider>().onPageChanged(focused),
        ),
      ),
    );
  }
}
