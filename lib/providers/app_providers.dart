import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/di/injection.dart';
import 'profile_provider.dart';
import 'todo_provider.dart';
import 'events_provider.dart';
import 'calendar_provider.dart';

class AppProviders {
  /// All global providers that wrap the entire application.
  static List<SingleChildWidget> get providers => [
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => getIt<ProfileProvider>()..initialize(),
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (_) => getIt<TodoProvider>(),
        ),
        ChangeNotifierProvider<EventsProvider>(
          create: (_) => getIt<EventsProvider>(),
        ),
        ChangeNotifierProvider<CalendarProvider>(
          create: (_) => getIt<CalendarProvider>(),
        ),
      ];
}
