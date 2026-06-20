import '../entities/profile.dart';
import '../entities/todo.dart';

abstract class ProfileRepository {
  List<Profile> getProfiles();
  Future<void> addTodo({
    required String profileId,
    required String title,
    String? description,
    DateTime? dueDate,
    bool isImportant = false,
  });
  Future<void> toggleTodo(String todoId);
  Future<void> deleteTodo(String todoId);
  List<Todo> getTodosForProfile(String profileId);
  Future<void> seedDefaultProfiles();
}
