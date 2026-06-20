import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../env/app_env.dart';
import '../../services/secure_storage_service.dart';

@singleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Try reading from secure storage first, fall back to env token
    final token = await _secureStorage.getAuthToken() ?? AppEnv.authToken;

    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
