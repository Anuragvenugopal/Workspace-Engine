import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/analytics_event.dart';
import '../../domain/repositories/analytics_repository.dart';

@LazySingleton(as: AnalyticsRepository)
class FirebaseAnalyticsRepository implements AnalyticsRepository {
  FirebaseAnalytics? get _analytics =>
      Firebase.apps.isNotEmpty ? FirebaseAnalytics.instance : null;

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    final analytics = _analytics;
    if (analytics != null) {
      await analytics.logEvent(
        name: event.name,
        parameters: event.parameters?.cast<String, Object>(),
      );
    } else {
      debugPrint('[Stub Analytics] logged event: ${event.name} | params: ${event.parameters}');
    }
  }
}
