import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_event.freezed.dart';

@freezed
abstract class GlobalEvent with _$GlobalEvent {
  const factory GlobalEvent({
    required int id,
    required String title,
    required String description,
    required String imageUrl,
    required String thumbnailUrl,
    required DateTime eventDate,
  }) = _GlobalEvent;
}
