import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../features/events/data/models/photo_response_model.dart';

@singleton
class EventsApiService {
  final Dio _dio;

  EventsApiService(this._dio);

  Future<List<PhotoResponseModel>> getPhotos({
    int limit = 20,
    int page = 1,
  }) async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/photos',
      queryParameters: {
        '_limit': limit,
        '_page': page,
      },
    );

    final data = response.data as List;
    return data.map((json) => PhotoResponseModel.fromJson(json)).toList();
  }

  Future<PhotoResponseModel> getPhotoById(int id) async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/photos/$id',
    );

    return PhotoResponseModel.fromJson(response.data);
  }
}
