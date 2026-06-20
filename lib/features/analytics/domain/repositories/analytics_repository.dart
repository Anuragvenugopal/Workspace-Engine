import '../entities/analytics_event.dart';

abstract class AnalyticsRepository {
  Future<void> logEvent(AnalyticsEvent event);
}
