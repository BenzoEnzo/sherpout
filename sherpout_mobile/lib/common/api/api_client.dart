import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sherpoutmobile/common/api/error/api_error_handler.dart';
import 'package:sherpoutmobile/common/auth_service.dart';

import 'error/api_error_response_dto.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final AuthService _authService;

  ApiClient(this._dio, this._secureStorage, this._authService) {
    _dio.options.baseUrl = dotenv.env['API_BASE_URL']!;
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      await _addAuthHeader(options);
      options.headers["Content-Type"] = "application/json";
      return handler.next(options);
    }, onError: (DioException e, handler) async {
      if (e.response?.statusCode == 401) {
        await _authService.refreshToken();
        await _addAuthHeader(e.requestOptions);
        return handler.resolve(await _dio.fetch(e.requestOptions));
      }
      if (e.response?.statusCode == 422) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic>) {
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              error: ApiErrorHandler(
                  ApiErrorResponseDto.fromJson(responseData).apiErrorList),
              type: DioExceptionType.badResponse,
            ),
          );
        }
      }
      return handler.next(e);
    }));
  }

  Future<void> _addAuthHeader(RequestOptions options) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
  }

  Future<Response> get(String endpoint,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(endpoint,
        data: data, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> put(String endpoint,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> delete(String endpoint,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(endpoint,
        data: data, queryParameters: queryParameters);
  }
}
