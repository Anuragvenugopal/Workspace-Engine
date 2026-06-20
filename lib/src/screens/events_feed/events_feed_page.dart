import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/events_provider.dart';
import 'widgets/events_list.dart';
import 'widgets/error_view.dart';
import 'widgets/event_card_shimmer.dart';
import '../../../utils/responsive_size.dart';
/// EventsFeedPage reads:
///   1. [EventsProvider]  — global — event list
///   2. [ProfileProvider] — global (root) — for accent color
///
/// EventsProvider is already initialized (loadEvents called) in the router's
/// pageBuilder create callback, so this page just observes state.
class EventsFeedPage extends StatelessWidget {
  const EventsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read profile once for color; use watch only where needed.
    final profileType = context.select<ProfileProvider, ProfileType>(
      (provider) => provider.state.activeProfile?.type ?? ProfileType.personal,
    );
    final color = AppTheme.getProfileColor(profileType);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Global Events',
          style: TextStyle(
            fontSize: context.h(22),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            // context.read in an event handler — correct
            onPressed: () =>
                context.read<EventsProvider>().loadEvents(refresh: true),
          ),
        ],
      ),
      body: Consumer<EventsProvider>(
        builder: (context, eventsProvider, child) {
          final state = eventsProvider.state;
          if (state is EventsLoading) {
            return ListView.builder(
              padding: EdgeInsets.only(
                top: context.h(8),
                bottom: context.h(100),
              ),
              itemCount: 4,
              itemBuilder: (context, index) => const EventCardShimmer(),
            );
          }
          if (state is EventsError) {
            return ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<EventsProvider>().loadEvents(refresh: true),
            );
          }
          if (state is EventsLoaded) {
            return EventsList(
              events: state.events,
              hasMore: state.hasMore,
              isFetchingMore: state.isFetchingMore,
              color: color,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

