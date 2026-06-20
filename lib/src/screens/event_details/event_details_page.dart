import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/events_provider.dart';

import 'widgets/event_error_view.dart';
import 'widgets/event_detail_view.dart';
import 'widgets/event_detail_shimmer.dart';

class EventDetailsPage extends StatelessWidget {
  final int eventId;
  const EventDetailsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final profileType = context.select<ProfileProvider, ProfileType>(
      (provider) => provider.state.activeProfile?.type ?? ProfileType.personal,
    );
    final color = AppTheme.getProfileColor(profileType);

    return Scaffold(
      body: Consumer<EventsProvider>(
        builder: (context, eventsProvider, child) {
          final state = eventsProvider.state;
          if (state is EventsError) {
            return EventErrorView(message: state.message, eventId: eventId);
          }
          if (state is EventDetailLoaded) {
            return EventDetailView(event: state.event, color: color);
          }
          return EventDetailShimmer(color: color);
        },
      ),
    );
  }
}
