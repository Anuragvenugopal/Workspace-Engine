import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/global_event.dart';
import '../../domain/repositories/event_repository.dart';
import '../../../../services/events_api_service.dart';
import '../models/photo_response_model.dart';

@LazySingleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  final EventsApiService _apiService;

  EventRepositoryImpl(this._apiService);

  @override
  Future<List<GlobalEvent>> getEvents({int page = 1, int limit = 20}) async {
    try {
      final photos = await _apiService.getPhotos(limit: limit, page: page);
      return photos.asMap().entries.map((entry) {
        return _mapToGlobalEvent(entry.value, entry.key);
      }).toList();
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  @override
  Future<GlobalEvent> getEventById(int id) async {
    try {
      final photo = await _apiService.getPhotoById(id);
      return _mapToGlobalEvent(photo, id % 20);
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  GlobalEvent _mapToGlobalEvent(PhotoResponseModel photo, int index) {
    return GlobalEvent(
      id: photo.id,
      title: _formatTitle(photo.title),
      description: _generateDescription(photo.albumId, photo.id),
      imageUrl: 'https://picsum.photos/600?random=${photo.id}',
      thumbnailUrl: 'https://picsum.photos/300?random=${photo.id}',
      // Generate a realistic date: spread over the past 30 days
      eventDate: DateTime.now().subtract(Duration(days: index % 30)),
    );
  }

  String _formatTitle(String raw) {
    if (raw.isEmpty) return 'Untitled Event';
    return raw[0].toUpperCase() + raw.substring(1);
  }

  String _generateDescription(int albumId, int photoId) {
    final descriptions = [
      'A key milestone in our global initiatives program, bringing teams together.',
      'Join us for an inspiring session exploring innovation and collaboration.',
      'An exclusive gathering of industry leaders to share insights and strategies.',
      'A deep-dive workshop covering the latest trends and best practices.',
      'Community event focused on knowledge sharing and professional growth.',
    ];
    return descriptions[photoId % descriptions.length];
  }

}
