import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    String? description,
    required bool isCompleted,
    required bool isImportant,
    DateTime? dueDate,
    required String profileId,
    required DateTime createdAt,
  }) = _Todo;
}
