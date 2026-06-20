import 'package:injectable/injectable.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../services/profile_local_datasource.dart';
import '../models/profile_model.dart';
import '../models/todo_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  List<Profile> getProfiles() {
    return _datasource.getProfiles().map(_mapProfileModel).toList();
  }

  @override
  Future<void> addTodo({
    required String profileId,
    required String title,
    String? description,
    DateTime? dueDate,
    bool isImportant = false,
  }) {
    return _datasource.addTodo(
      profileId: profileId,
      title: title,
      description: description,
      dueDate: dueDate,
      isImportant: isImportant,
    );
  }

  @override
  Future<void> toggleTodo(String todoId) {
    return _datasource.toggleTodo(todoId);
  }

  @override
  Future<void> deleteTodo(String todoId) {
    return _datasource.deleteTodo(todoId);
  }

  @override
  List<Todo> getTodosForProfile(String profileId) {
    return _datasource.getTodosForProfile(profileId).map(_mapTodoModel).toList();
  }

  @override
  Future<void> seedDefaultProfiles() {
    return _datasource.seedDefaultProfilesIfNeeded();
  }

  // ─── Mappers ──────────────────────────────────────────────────────────────

  Profile _mapProfileModel(ProfileModel model) {
    return Profile(
      id: model.id,
      name: model.name,
      type: ProfileType.values[model.typeIndex],
      colorValue: model.colorValue,
      createdAt: model.createdAt,
    );
  }

  Todo _mapTodoModel(TodoModel model) {
    return Todo(
      id: model.id,
      title: model.title,
      description: model.description,
      isCompleted: model.isCompleted,
      isImportant: model.isImportant,
      dueDate: model.dueDate,
      profileId: model.profileId,
      createdAt: model.createdAt,
    );
  }
}
