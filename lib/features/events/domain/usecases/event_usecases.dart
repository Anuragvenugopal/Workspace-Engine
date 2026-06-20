import 'package:injectable/injectable.dart';

import '../entities/global_event.dart';
import '../repositories/event_repository.dart';

@injectable
class GetEventsUseCase {
  final EventRepository _repository;
  GetEventsUseCase(this._repository);

  Future<List<GlobalEvent>> call({int page = 1, int limit = 20}) =>
      _repository.getEvents(page: page, limit: limit);
}

@injectable
class GetEventByIdUseCase {
  final EventRepository _repository;
  GetEventByIdUseCase(this._repository);

  Future<GlobalEvent> call(int id) => _repository.getEventById(id);
}
