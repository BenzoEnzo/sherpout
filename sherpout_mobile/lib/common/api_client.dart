import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final secureStorage = FlutterSecureStorage();
        final token = await secureStorage.read(key: 'access_token');

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }

        options.headers["Content-Type"] = "application/json";
        return handler.next(options);
      },
    ));

  static Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }
}
