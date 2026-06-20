import '../entities/global_event.dart';

abstract class EventRepository {
  Future<List<GlobalEvent>> getEvents({int page = 1, int limit = 20});
  Future<GlobalEvent> getEventById(int id);
}
