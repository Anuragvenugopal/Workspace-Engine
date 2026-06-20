import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:workspace_engine/features/profiles/domain/entities/todo.dart';
import 'package:workspace_engine/features/profiles/domain/usecases/profile_usecases.dart';
import 'package:workspace_engine/features/profiles/presentation/cubit/todo_cubit.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────

class MockGetTodosForProfileUseCase extends Mock
    implements GetTodosForProfileUseCase {}

class MockAddTodoUseCase extends Mock implements AddTodoUseCase {}

class MockToggleTodoUseCase extends Mock implements ToggleTodoUseCase {}

class MockDeleteTodoUseCase extends Mock implements DeleteTodoUseCase {}

// ─── Helpers ─────────────────────────────────────────────────────────────────

Todo _makeTodo(String id, {bool completed = false}) => Todo(
      id: id,
      title: 'Task $id',
      isCompleted: completed,
      profileId: 'p1',
      createdAt: DateTime(2025, 1, 1),
    );

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  late MockGetTodosForProfileUseCase mockGetTodos;
  late MockAddTodoUseCase mockAddTodo;
  late MockToggleTodoUseCase mockToggleTodo;
  late MockDeleteTodoUseCase mockDeleteTodo;

  setUpAll(() {
    // register fallback values for any() matchers
    registerFallbackValue('');
  });

  setUp(() {
    mockGetTodos = MockGetTodosForProfileUseCase();
    mockAddTodo = MockAddTodoUseCase();
    mockToggleTodo = MockToggleTodoUseCase();
    mockDeleteTodo = MockDeleteTodoUseCase();
  });

     buildCubit() => TodoCubit(
        mockGetTodos,
        mockAddTodo,
        mockToggleTodo,
        mockDeleteTodo,
      );

  group('TodoCubit.loadForProfile', () {
    blocTest<TodoCubit, TodoState>(
      'emits TodoLoaded with correct counts when todos exist',
      build: buildCubit,
      setUp: () {
        // Use-cases are callable objects — stub the call() method
        when(() => mockGetTodos('p1')).thenReturn([
          _makeTodo('t1'),
          _makeTodo('t2', completed: true),
          _makeTodo('t3'),
        ]);
      },
      act: (cubit) => cubit.loadForProfile('p1'),
      expect: () => [
        isA<TodoLoaded>()
            .having((s) => s.totalCount, 'totalCount', 3)
            .having((s) => s.completedCount, 'completedCount', 1),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits TodoLoaded with empty list for new profile',
      build: buildCubit,
      setUp: () {
        when(() => mockGetTodos('empty-profile')).thenReturn([]);
      },
      act: (cubit) => cubit.loadForProfile('empty-profile'),
      expect: () => [
        isA<TodoLoaded>()
            .having((s) => s.todos, 'todos', isEmpty)
            .having((s) => s.totalCount, 'totalCount', 0),
      ],
    );
  });

  group('TodoCubit.addTodo', () {
    blocTest<TodoCubit, TodoState>(
      'calls addTodo use case and reloads',
      build: buildCubit,
      setUp: () {
        // Stub getTodos — will be called twice (on loadForProfile + after addTodo)
        var callIndex = 0;
        when(() => mockGetTodos(any())).thenAnswer((_) {
          callIndex++;
          return callIndex == 1 ? [] : [_makeTodo('new-t')];
        });
        when(() => mockAddTodo(any(), any())).thenAnswer((_) async {});
      },
      act: (cubit) async {
        cubit.loadForProfile('p1');
        await cubit.addTodo('New Task');
      },
      expect: () => [
        isA<TodoLoaded>().having((s) => s.totalCount, 'before add', 0),
        isA<TodoLoaded>().having((s) => s.totalCount, 'after add', 1),
      ],
      verify: (_) {
        verify(() => mockAddTodo('p1', 'New Task')).called(1);
      },
    );
  });

  group('TodoCubit.toggleTodo', () {
    blocTest<TodoCubit, TodoState>(
      'calls toggleTodo use case and reloads',
      build: buildCubit,
      setUp: () {
        when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1')]);
        when(() => mockToggleTodo(any())).thenAnswer((_) async {});
      },
      act: (cubit) async {
        cubit.loadForProfile('p1');
        
        // Mock getTodos again to simulate state change so bloc emits again
        when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1', completed: true)]);
        await cubit.toggleTodo('t1');
      },
      expect: () => [
        isA<TodoLoaded>().having((s) => s.completedCount, 'before toggle', 0),
        isA<TodoLoaded>().having((s) => s.completedCount, 'after toggle', 1),
      ],
      verify: (_) {
        verify(() => mockToggleTodo('t1')).called(1);
      },
    );
  });

  group('TodoCubit.deleteTodo', () {
    blocTest<TodoCubit, TodoState>(
      'calls deleteTodo use case and reloads',
      build: buildCubit,
      setUp: () {
        when(() => mockGetTodos(any())).thenReturn([_makeTodo('t1')]);
        when(() => mockDeleteTodo(any())).thenAnswer((_) async {});
      },
      act: (cubit) async {
        cubit.loadForProfile('p1');
        
        // Mock getTodos to simulate item deleted so bloc emits again
        when(() => mockGetTodos(any())).thenReturn([]);
        await cubit.deleteTodo('t1');
      },
      expect: () => [
        isA<TodoLoaded>().having((s) => s.totalCount, 'before delete', 1),
        isA<TodoLoaded>().having((s) => s.totalCount, 'after delete', 0),
      ],
      verify: (_) {
        verify(() => mockDeleteTodo('t1')).called(1);
      },
    );
  });
}
