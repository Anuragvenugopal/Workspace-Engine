import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarState extends Equatable {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<String>> events;

  const CalendarState({
    required this.focusedDay,
    this.selectedDay,
    this.calendarFormat = CalendarFormat.month,
    this.events = const {},
  });

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    CalendarFormat? calendarFormat,
    Map<DateTime, List<String>>? events,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [focusedDay, selectedDay, calendarFormat, events];
}


@injectable
class CalendarProvider extends ChangeNotifier {
  CalendarState _state;
  CalendarState get state => _state;

  CalendarProvider()
      : _state = CalendarState(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
          events: _generateSampleEvents(),
        );

  void _emit(CalendarState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _emit(state.copyWith(
      selectedDay: selectedDay,
      focusedDay: focusedDay,
    ));
  }

  void onFormatChanged(CalendarFormat format) {
    _emit(state.copyWith(calendarFormat: format));
  }

  void onPageChanged(DateTime focusedDay) {
    _emit(state.copyWith(focusedDay: focusedDay));
  }

  List<String> getEventsForDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return state.events[normalized] ?? [];
  }

  static Map<DateTime, List<String>> _generateSampleEvents() {
    final now = DateTime.now();
    return {
      DateTime(now.year, now.month, now.day): ['Team Standup', 'Sprint Review'],
      DateTime(now.year, now.month, now.day + 1): ['Client Meeting'],
      DateTime(now.year, now.month, now.day + 3): ['Workshop', 'Design Review'],
      DateTime(now.year, now.month, now.day + 5): ['Product Demo'],
      DateTime(now.year, now.month, now.day - 1): ['Retrospective'],
      DateTime(now.year, now.month, now.day - 3): ['Planning Session'],
      DateTime(now.year, now.month, now.day + 7): ['All-Hands Meeting'],
      DateTime(now.year, now.month, now.day + 10): ['Quarterly Review'],
    };
  }
}
