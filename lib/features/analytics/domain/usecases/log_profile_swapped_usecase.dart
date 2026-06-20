import 'package:injectable/injectable.dart';
import '../entities/analytics_event.dart';
import '../repositories/analytics_repository.dart';

@injectable
class LogProfileSwappedUseCase {
  final AnalyticsRepository _repository;

  LogProfileSwappedUseCase(this._repository);

  Future<void> call(String profileName) async {
    final event = AnalyticsEvent(
      name: 'profile_swapped',
      parameters: {'profile_name': profileName},
    );
    await _repository.logEvent(event);
  }
}
