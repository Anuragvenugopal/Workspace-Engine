import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workspace_engine/features/events/domain/entities/global_event.dart';
import 'package:workspace_engine/features/events/domain/repositories/event_repository.dart';
import 'package:workspace_engine/features/events/domain/usecases/event_usecases.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  late MockEventRepository mockRepository;
  late GetEventsUseCase getEventsUseCase;
  late GetEventByIdUseCase getEventByIdUseCase;

  setUp(() {
    mockRepository = MockEventRepository();
    getEventsUseCase = GetEventsUseCase(mockRepository);
    getEventByIdUseCase = GetEventByIdUseCase(mockRepository);
  });

  final tEvent = GlobalEvent(
    id: 1,
    title: 'Test Event',
    description: 'Test Description',
    imageUrl: 'url',
    thumbnailUrl: 'url',
    eventDate: DateTime.now(),
  );
  
  final tEventsList = [tEvent];

  group('GetEventsUseCase', () {
    test('should get events list from the repository', () async {
      // arrange
      when(() => mockRepository.getEvents(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenAnswer((_) async => tEventsList);
          
      // act
      final result = await getEventsUseCase(page: 1, limit: 20);
      
      // assert
      expect(result, tEventsList);
      verify(() => mockRepository.getEvents(page: 1, limit: 20)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('GetEventByIdUseCase', () {
    test('should get a single event from the repository', () async {
      // arrange
      when(() => mockRepository.getEventById(any()))
          .thenAnswer((_) async => tEvent);
          
      // act
      final result = await getEventByIdUseCase(1);
      
      // assert
      expect(result, tEvent);
      verify(() => mockRepository.getEventById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
