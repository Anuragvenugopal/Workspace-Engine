import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:workspace_engine/features/profiles/domain/entities/todo.dart';
import 'package:workspace_engine/features/profiles/domain/usecases/profile_usecases.dart';
import 'package:workspace_engine/providers/todo_provider.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────

class MockGetTodosForProfileUseCase extends Mock
    implements GetTodosForProfileUseCase {}

class MockAddTodoUseCase extends Mock implements AddTodoUseCase {}

class MockToggleTodoUseCase extends Mock implements ToggleTodoUseCase {}

class MockDeleteTodoUseCase extends Mock implements DeleteTodoUseCase {}


Todo _makeTodo(String id, {bool completed = false}) => Todo(
      id: id,
      title: 'Task $id',
      isCompleted: completed,
      isImportant: false,
      profileId: 'p1',
      createdAt: DateTime(2025, 1, 1),
    );


void main() {
  late MockGetTodosForProfileUseCase mockGetTodos;
  late MockAddTodoUseCase mockAddTodo;
  late MockToggleTodoUseCase mockToggleTodo;
  late MockDeleteTodoUseCase mockDeleteTodo;
  late TodoProvider provider;

  setUpAll(() {
    registerFallbackValue('');
  });

  setUp(() {
    mockGetTodos = MockGetTodosForProfileUseCase();
    mockAddTodo = MockAddTodoUseCase();
    mockToggleTodo = MockToggleTodoUseCase();
    mockDeleteTodo = MockDeleteTodoUseCase();
    provider = TodoProvider(
      mockGetTodos,
      mockAddTodo,
      mockToggleTodo,
      mockDeleteTodo,
    );
  });

  group('TodoProvider.loadForProfile', () {
    test('updates state with correct counts when todos exist', () {
      when(() => mockGetTodos('p1')).thenReturn([
        _makeTodo('t1'),
        _makeTodo('t2', completed: true),
        _makeTodo('t3'),
      ]);

      provider.loadForProfile('p1');

      final state = provider.state as TodoLoaded;
      expect(state.todos.length, 3);
      expect(state.totalCount, 3);
      expect(state.completedCount, 1);
    });

    test('updates state with empty list for new profile', () {
      when(() => mockGetTodos('empty-profile')).thenReturn([]);

      provider.loadForProfile('empty-profile');

      final state = provider.state as TodoLoaded;
      expect(state.todos, isEmpty);
      expect(state.totalCount, 0);
    });
  });

  group('TodoProvider.addTodo', () {
    test('calls addTodo use case and reloads', () async {
      when(() => mockGetTodos(any())).thenReturn([]);
      provider.loadForProfile('p1');
      expect((provider.state as TodoLoaded).totalCount, 0);

      when(() => mockGetTodos(any())).thenReturn([_makeTodo('new-t')]);
      when(() => mockAddTodo(profileId: 'p1', title: 'New Task')).thenAnswer((_) async {});

      await provider.addTodo(title: 'New Task');

      expect((provider.state as TodoLoaded).totalCount, 1);
      verify(() => mockAddTodo(profileId: 'p1', title: 'New Task')).called(1);
    });
  });

  group('TodoProvider.toggleTodo', () {
    test('calls toggleTodo use case and reloads', () async {
      when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1')]);
      provider.loadForProfile('p1');
      expect((provider.state as TodoLoaded).completedCount, 0);

      when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1', completed: true)]);
      when(() => mockToggleTodo(any())).thenAnswer((_) async {});

      await provider.toggleTodo('t1');

      expect((provider.state as TodoLoaded).completedCount, 1);
      verify(() => mockToggleTodo('t1')).called(1);
    });
  });

  group('TodoProvider.deleteTodo', () {
    test('calls deleteTodo use case and reloads', () async {
      when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1')]);
      provider.loadForProfile('p1');
      expect((provider.state as TodoLoaded).totalCount, 1);

      when(() => mockGetTodos(any())).thenReturn([]);
      when(() => mockDeleteTodo(any())).thenAnswer((_) async {});

      await provider.deleteTodo('t1');

      expect((provider.state as TodoLoaded).totalCount, 0);
      verify(() => mockDeleteTodo('t1')).called(1);
    });
  });
}
