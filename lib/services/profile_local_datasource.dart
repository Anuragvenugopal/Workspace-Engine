import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_theme.dart';
import '../features/profiles/data/models/profile_model.dart';
import '../features/profiles/data/models/todo_model.dart';

@singleton
class ProfileLocalDatasource {
  static const String _profileBoxName = 'profiles';
  static const String _todoBoxName = 'todos';

  Box<ProfileModel> get _profileBox => Hive.box<ProfileModel>(_profileBoxName);
  Box<TodoModel> get _todoBox => Hive.box<TodoModel>(_todoBoxName);

  static Future<void> openBoxes() async {
    await Hive.openBox<ProfileModel>(_profileBoxName);
    await Hive.openBox<TodoModel>(_todoBoxName);
  }


  List<ProfileModel> getProfiles() {
    return _profileBox.values.toList();
  }

  Future<void> saveProfile(ProfileModel profile) async {
    await _profileBox.put(profile.id, profile);
  }

  Future<void> deleteProfile(String profileId) async {
    await _profileBox.delete(profileId);
    // Cascade delete todos
    final todosToDelete = _todoBox.values
        .where((t) => t.profileId == profileId)
        .map((t) => t.id)
        .toList();
    await _todoBox.deleteAll(todosToDelete);
  }


  Future<void> seedDefaultProfilesIfNeeded() async {
    if (_profileBox.isNotEmpty) return;

    final defaults = [
      _createProfile('Personal', ProfileType.personal, 0xFF0EA5E9),
      _createProfile('Work', ProfileType.work, 0xFF059669),
      _createProfile('Corporate', ProfileType.corporate, 0xFF1A1A2E),
      _createProfile('Creative', ProfileType.creative, 0xFF7C3AED),
    ];

    for (final profile in defaults) {
      await _profileBox.put(profile.id, profile);
    }
  }

  ProfileModel _createProfile(
      String name, ProfileType type, int colorValue) {
    final model = ProfileModel()
      ..id = const Uuid().v4()
      ..name = name
      ..typeIndex = type.index
      ..colorValue = colorValue
      ..createdAt = DateTime.now();
    return model;
  }


  List<TodoModel> getTodosForProfile(String profileId) {
    return _todoBox.values
        .where((t) => t.profileId == profileId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addTodo({
    required String profileId,
    required String title,
    String? description,
    DateTime? dueDate,
    bool isImportant = false,
  }) async {
    final todo = TodoModel()
      ..id = DateTime.now().millisecondsSinceEpoch.toString()
      ..title = title
      ..description = description
      ..isImportant = isImportant
      ..dueDate = dueDate
      ..isCompleted = false
      ..profileId = profileId
      ..createdAt = DateTime.now();

    await _todoBox.put(todo.id, todo);
  }

  Future<void> toggleTodo(String todoId) async {
    final todo = _todoBox.get(todoId);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      await todo.save();
    }
  }

  Future<void> deleteTodo(String todoId) async {
    await _todoBox.delete(todoId);
  }
}
