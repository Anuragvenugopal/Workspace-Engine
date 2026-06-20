import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../features/profiles/domain/entities/todo.dart';
import '../features/profiles/domain/usecases/profile_usecases.dart';


abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {
  const TodoInitial();
}

class TodoLoading extends TodoState {
  const TodoLoading();
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final int completedCount;
  final int totalCount;

  const TodoLoaded({
    required this.todos,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [todos, completedCount, totalCount];
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}


@injectable
class TodoProvider extends ChangeNotifier {
  final GetTodosForProfileUseCase _getTodos;
  final AddTodoUseCase _addTodo;
  final ToggleTodoUseCase _toggleTodo;
  final DeleteTodoUseCase _deleteTodo;

  String? _currentProfileId;
  TodoState _state = const TodoInitial();

  TodoProvider(
    this._getTodos,
    this._addTodo,
    this._toggleTodo,
    this._deleteTodo,
  );

  TodoState get state => _state;
  String? get currentProfileId => _currentProfileId;

  void _emit(TodoState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  void loadForProfile(String profileId) {
    _currentProfileId = profileId;
    _reload();
  }

  Future<void> addTodo({
    required String title,
    String? description,
    DateTime? dueDate,
    bool isImportant = false,
  }) async {
    if (_currentProfileId == null) return;
    await _addTodo(
      profileId: _currentProfileId!,
      title: title,
      description: description,
      dueDate: dueDate,
      isImportant: isImportant,
    );
    _reload();
  }

  Future<void> toggleTodo(String todoId) async {
    await _toggleTodo(todoId);
    _reload();
  }

  Future<void> deleteTodo(String todoId) async {
    await _deleteTodo(todoId);
    _reload();
  }

  void _reload() {
    if (_currentProfileId == null) return;
    final todos = _getTodos(_currentProfileId!);
    final completed = todos.where((t) => t.isCompleted).length;
    _emit(TodoLoaded(
      todos: todos,
      completedCount: completed,
      totalCount: todos.length,
    ));
  }
}
