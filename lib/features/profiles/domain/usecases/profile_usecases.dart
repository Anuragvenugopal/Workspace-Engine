import 'package:injectable/injectable.dart';

import '../entities/profile.dart';
import '../entities/todo.dart';
import '../repositories/profile_repository.dart';

@injectable
class GetProfilesUseCase {
  final ProfileRepository _repository;
  GetProfilesUseCase(this._repository);

  List<Profile> call() => _repository.getProfiles();
}

@injectable
class AddTodoUseCase {
  final ProfileRepository _repository;
  AddTodoUseCase(this._repository);

  Future<void> call({
    required String profileId,
    required String title,
    String? description,
    DateTime? dueDate,
    bool isImportant = false,
  }) =>
      _repository.addTodo(
        profileId: profileId,
        title: title,
        description: description,
        dueDate: dueDate,
        isImportant: isImportant,
      );
}

@injectable
class ToggleTodoUseCase {
  final ProfileRepository _repository;
  ToggleTodoUseCase(this._repository);

  Future<void> call(String todoId) => _repository.toggleTodo(todoId);
}

@injectable
class DeleteTodoUseCase {
  final ProfileRepository _repository;
  DeleteTodoUseCase(this._repository);

  Future<void> call(String todoId) => _repository.deleteTodo(todoId);
}

@injectable
class GetTodosForProfileUseCase {
  final ProfileRepository _repository;
  GetTodosForProfileUseCase(this._repository);

  List<Todo> call(String profileId) => _repository.getTodosForProfile(profileId);
}

@injectable
class SeedDefaultProfilesUseCase {
  final ProfileRepository _repository;
  SeedDefaultProfilesUseCase(this._repository);

  Future<void> call() => _repository.seedDefaultProfiles();
}
