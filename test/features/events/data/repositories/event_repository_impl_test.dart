import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workspace_engine/features/events/data/models/photo_response_model.dart';
import 'package:workspace_engine/features/events/data/repositories/event_repository_impl.dart';
import 'package:workspace_engine/services/events_api_service.dart';

class MockEventsApiService extends Mock implements EventsApiService {}

void main() {
  late EventRepositoryImpl repository;
  late MockEventsApiService mockApiService;

  setUp(() {
    mockApiService = MockEventsApiService();
    repository = EventRepositoryImpl(mockApiService);
  });

  final tPhotoModel = PhotoResponseModel(
    albumId: 1,
    id: 1,
    title: 'test title',
    url: 'test_url',
    thumbnailUrl: 'test_thumbnail_url',
  );

  group('getEvents', () {
    test('should return a list of GlobalEvents when API call is successful', () async {
      // arrange
      when(() => mockApiService.getPhotos(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenAnswer((_) async => [tPhotoModel]);
          
      // act
      final result = await repository.getEvents(page: 1, limit: 10);
      
      // assert
      expect(result.length, 1);
      expect(result.first.id, tPhotoModel.id);
      expect(result.first.title, 'Test title'); // Captialized
      verify(() => mockApiService.getPhotos(page: 1, limit: 10)).called(1);
      verifyNoMoreInteractions(mockApiService);
    });

    test('should throw an Exception when the API call fails with DioException', () async {
      // arrange
      when(() => mockApiService.getPhotos(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Connection failed',
          ));
          
      // act
      final call = repository.getEvents;
      
      // assert
      expect(() => call(page: 1, limit: 10), throwsA(isA<Exception>()));
    });
  });

  group('getEventById', () {
    test('should return a GlobalEvent when API call is successful', () async {
      // arrange
      when(() => mockApiService.getPhotoById(any()))
          .thenAnswer((_) async => tPhotoModel);
          
      // act
      final result = await repository.getEventById(1);
      
      // assert
      expect(result.id, tPhotoModel.id);
      expect(result.title, 'Test title');
      verify(() => mockApiService.getPhotoById(1)).called(1);
      verifyNoMoreInteractions(mockApiService);
    });

    test('should throw an Exception when API call fails with DioException', () async {
      // arrange
      when(() => mockApiService.getPhotoById(any()))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Not found',
          ));
          
      // act
      final call = repository.getEventById;
      
      // assert
      expect(() => call(1), throwsA(isA<Exception>()));
    });
  });
}
