import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:workspace_engine/core/theme/app_theme.dart';
import 'package:workspace_engine/services/profile_local_datasource.dart';
import 'package:workspace_engine/features/profiles/data/models/profile_model.dart';
import 'package:workspace_engine/features/profiles/data/models/todo_model.dart';
import 'package:workspace_engine/features/profiles/data/repositories/profile_repository_impl.dart';
import 'package:workspace_engine/features/profiles/domain/entities/profile.dart';
import 'package:workspace_engine/features/profiles/domain/entities/todo.dart';


class MockProfileLocalDatasource extends Mock implements ProfileLocalDatasource {}


ProfileModel _makeProfileModel(String id, String name) {
  return ProfileModel()
    ..id = id
    ..name = name
    ..typeIndex = ProfileType.personal.index
    ..colorValue = 0xFF0EA5E9
    ..createdAt = DateTime(2025, 1, 1);
}

TodoModel _makeTodoModel(String id, String profileId, {bool completed = false}) {
  return TodoModel()
    ..id = id
    ..title = 'Test Todo $id'
    ..isCompleted = completed
    ..isImportant = false
    ..profileId = profileId
    ..createdAt = DateTime(2025, 1, 1);
}

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  late MockProfileLocalDatasource mockDatasource;
  late ProfileRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockProfileLocalDatasource();
    repository = ProfileRepositoryImpl(mockDatasource);
  });

  group('ProfileRepositoryImpl.getProfiles', () {
    test('maps ProfileModel list to Profile entity list', () {
      // Arrange
      final models = [
        _makeProfileModel('1', 'Personal'),
        _makeProfileModel('2', 'Work'),
      ];
      when(() => mockDatasource.getProfiles()).thenReturn(models);

      // Act
      final result = repository.getProfiles();

      // Assert
      expect(result, isA<List<Profile>>());
      expect(result.length, 2);
      expect(result.first.id, '1');
      expect(result.first.name, 'Personal');
      expect(result.first.type, ProfileType.personal);
    });

    test('returns empty list when datasource returns empty', () {
      when(() => mockDatasource.getProfiles()).thenReturn([]);
      final result = repository.getProfiles();
      expect(result, isEmpty);
    });
  });

  group('ProfileRepositoryImpl.getTodosForProfile', () {
    test('maps TodoModel list to Todo entity list', () {
      // Arrange
      final models = [
        _makeTodoModel('t1', 'profile-1'),
        _makeTodoModel('t2', 'profile-1', completed: true),
      ];
      when(() => mockDatasource.getTodosForProfile('profile-1'))
          .thenReturn(models);

      // Act
      final result = repository.getTodosForProfile('profile-1');

      // Assert
      expect(result, isA<List<Todo>>());
      expect(result.length, 2);
      expect(result[0].isCompleted, false);
      expect(result[1].isCompleted, true);
    });

    test('returns todos only for the given profile', () {
      when(() => mockDatasource.getTodosForProfile('profile-A'))
          .thenReturn([_makeTodoModel('t1', 'profile-A')]);
      when(() => mockDatasource.getTodosForProfile('profile-B'))
          .thenReturn([]);

      expect(repository.getTodosForProfile('profile-A').length, 1);
      expect(repository.getTodosForProfile('profile-B'), isEmpty);
    });
  });

  group('ProfileRepositoryImpl.addTodo', () {
    test('delegates to datasource with correct arguments', () async {
      when(() => mockDatasource.addTodo(
              profileId: 'profile-1', title: 'My Task'))
          .thenAnswer((_) async {});

      await repository.addTodo(profileId: 'profile-1', title: 'My Task');

      verify(() => mockDatasource.addTodo(
          profileId: 'profile-1', title: 'My Task')).called(1);
    });
  });

  group('ProfileRepositoryImpl.toggleTodo', () {
    test('delegates to datasource', () async {
      when(() => mockDatasource.toggleTodo('todo-1')).thenAnswer((_) async {});
      await repository.toggleTodo('todo-1');
      verify(() => mockDatasource.toggleTodo('todo-1')).called(1);
    });
  });

  group('ProfileRepositoryImpl.deleteTodo', () {
    test('delegates to datasource', () async {
      when(() => mockDatasource.deleteTodo('todo-1')).thenAnswer((_) async {});
      await repository.deleteTodo('todo-1');
      verify(() => mockDatasource.deleteTodo('todo-1')).called(1);
    });
  });

  group('ProfileRepositoryImpl.seedDefaultProfiles', () {
    test('delegates to datasource seedDefaultProfilesIfNeeded', () async {
      when(() => mockDatasource.seedDefaultProfilesIfNeeded())
          .thenAnswer((_) async {});
      await repository.seedDefaultProfiles();
      verify(() => mockDatasource.seedDefaultProfilesIfNeeded()).called(1);
    });
  });
}
