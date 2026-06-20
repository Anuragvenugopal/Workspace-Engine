import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/events_provider.dart';
import '../../../../features/events/domain/entities/global_event.dart';
import '../../../../utils/responsive_size.dart';
import 'event_card.dart';
import 'event_card_shimmer.dart';

class EventsList extends StatefulWidget {
  final List<GlobalEvent> events;
  final bool hasMore;
  final bool isFetchingMore;
  final Color color;

  const EventsList({
    super.key,
    required this.events,
    required this.hasMore,
    required this.isFetchingMore,
    required this.color,
  });

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 50 &&
        widget.hasMore &&
        !widget.isFetchingMore) {
      context.read<EventsProvider>().loadEvents();
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.only(
        top: context.h(8),
        bottom: context.h(100), // Add padding for bottom nav & spinner visibility
      ),
      itemCount: widget.events.length + (widget.isFetchingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.events.length) {
          return const EventCardShimmer();
        }
        return EventCard(
            event: widget.events[index], color: widget.color);
      },
    );
  }
}
