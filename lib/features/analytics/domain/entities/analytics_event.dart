import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_event.freezed.dart';

@freezed
class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) = _AnalyticsEvent;
}
