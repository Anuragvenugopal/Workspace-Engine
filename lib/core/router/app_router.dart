import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../src/screens/calendar/calendar_page.dart';
import '../../providers/events_provider.dart';
import '../../src/screens/event_details/event_details_page.dart';
import '../../src/screens/events_feed/events_feed_page.dart';
import '../../src/screens/dashboard/dashboard_page.dart';
import '../../src/screens/todo_manager/todo_manager_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String todos = '/todos';
  static const String events = '/events';
  static const String calendar = '/calendar';
}

/// All page-scoped cubits are provided in [pageBuilder] so they are:
///  - Created exactly once when the route is pushed
///  - Automatically disposed when the route is popped
///  - Never recreated on widget rebuilds
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.dashboard,
  debugLogDiagnostics: true,
  routes: [
    // ── Dashboard: no page-scoped provider needed;
    //    it reads the global ProfileProvider via context.read<ProfileProvider>()
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    // ── Todo Manager: provides TodoProvider scoped to this route
    GoRoute(
      path: AppRoutes.todos,
      name: 'todos',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TodoManagerPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),

    // ── Events Feed: provides EventsProvider scoped to this route
    GoRoute(
      path: AppRoutes.events,
      name: 'events',
      pageBuilder: (context, state) {
        // Load events when navigating to the feed
        final eventsProvider = context.read<EventsProvider>();
        Future.microtask(() => eventsProvider.loadEvents());
        return CustomTransitionPage(
          key: state.pageKey,
          child: const EventsFeedPage(),
          transitionsBuilder: _slideTransition,
        );
      },
      routes: [
        // ── Event Detail: inherits EventsProvider from parent route's subtree
        GoRoute(
          path: ':id',
          name: 'event-details',
          pageBuilder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return CustomTransitionPage(
              key: state.pageKey,
              // The EventsProvider is now global, so we instruct it to load this specific event
              child: Builder(
                builder: (context) {
                  final eventsProvider = context.read<EventsProvider>();
                  Future.microtask(() => eventsProvider.loadEventById(id));
                  return EventDetailsPage(eventId: id);
                },
              ),
              transitionsBuilder: _fadeTransition,
            );
          },
        ),
      ],
    ),

    // ── Calendar: provides CalendarProvider scoped to this route
    GoRoute(
      path: AppRoutes.calendar,
      name: 'calendar',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CalendarPage(),
        transitionsBuilder: _slideTransition,
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Page not found', style: Theme.of(context).textTheme.titleLarge),
          Text(state.error.toString()),
        ],
      ),
    ),
  ),
);

// ─── Transition builders ──────────────────────────────────────────────────────

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: animation.drive(
      Tween(begin: const Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOutCubic)),
    ),
    child: child,
  );
}

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
    child: child,
  );
}
