import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../features/events/domain/entities/global_event.dart';
import '../features/events/domain/usecases/event_usecases.dart';

// ─── State ───────────────────────────────────────────────────────────────────

abstract class EventsState extends Equatable {
  const EventsState();
  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {
  const EventsInitial();
}

class EventsLoading extends EventsState {
  const EventsLoading();
}

class EventsLoaded extends EventsState {
  final List<GlobalEvent> events;
  final bool hasMore;
  final int currentPage;

  final bool isFetchingMore;

  const EventsLoaded({
    required this.events,
    this.hasMore = true,
    this.currentPage = 1,
    this.isFetchingMore = false,
  });

  @override
  List<Object?> get props => [events, hasMore, currentPage, isFetchingMore];

  EventsLoaded copyWith({
    List<GlobalEvent>? events,
    bool? hasMore,
    int? currentPage,
    bool? isFetchingMore,
  }) {
    return EventsLoaded(
      events: events ?? this.events,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

class EventsError extends EventsState {
  final String message;
  const EventsError(this.message);

  @override
  List<Object?> get props => [message];
}

class EventDetailLoading extends EventsState {
  const EventDetailLoading();
}

class EventDetailLoaded extends EventsState {
  final GlobalEvent event;
  const EventDetailLoaded(this.event);

  @override
  List<Object?> get props => [event];
}

// ─── Provider ────────────────────────────────────────────────────────────────

@injectable
class EventsProvider extends ChangeNotifier {
  final GetEventsUseCase _getEvents;
  final GetEventByIdUseCase _getEventById;

  EventsState _state = const EventsInitial();
  EventsState get state => _state;

  EventsProvider(this._getEvents, this._getEventById);

  void _emit(EventsState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  Future<void> loadEvents({bool refresh = false}) async {
    if (state is EventsLoading) return;
    if (state is EventsLoaded && (state as EventsLoaded).isFetchingMore) return;

    final currentEvents =
        (state is EventsLoaded && !refresh) ? (state as EventsLoaded).events : <GlobalEvent>[];
    final currentPage =
        (state is EventsLoaded && !refresh) ? (state as EventsLoaded).currentPage : 1;
    final nextPage = refresh ? 1 : currentPage;

    if (state is EventsLoaded && !refresh) {
      _emit((state as EventsLoaded).copyWith(isFetchingMore: true));
    } else {
      _emit(const EventsLoading());
    }

    try {
      final newEvents = await _getEvents(page: nextPage, limit: 20);
      _emit(EventsLoaded(
        events: refresh ? newEvents : [...currentEvents, ...newEvents],
        hasMore: newEvents.length == 20,
        currentPage: nextPage + 1,
        isFetchingMore: false,
      ));
    } catch (e) {
      if (state is EventsLoaded) {
        _emit((state as EventsLoaded).copyWith(isFetchingMore: false));
      }
      _emit(EventsError(e.toString()));
    }
  }

  Future<void> loadEventById(int id) async {
    _emit(const EventDetailLoading());
    try {
      final event = await _getEventById(id);
      _emit(EventDetailLoaded(event));
    } catch (e) {
      _emit(EventsError(e.toString()));
    }
  }
}
