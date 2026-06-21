import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../features/events/data/models/photo_response_model.dart';

part 'events_api_service.g.dart';

@singleton
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class EventsApiService {
  @factoryMethod
  factory EventsApiService(Dio dio) = _EventsApiService;

  @GET('/photos')
  Future<List<PhotoResponseModel>> getPhotos({
    @Query('_limit') int limit = 20,
    @Query('_page') int page = 1,
  });

  @GET('/photos/{id}')
  Future<PhotoResponseModel> getPhotoById(@Path('id') int id);
}
