import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpoutmobile/common/api_client.dart';
import 'package:sherpoutmobile/common/auth_service.dart';
import 'package:sherpoutmobile/sherpout_app.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => FlutterSecureStorage());
  getIt.registerLazySingleton(() => FlutterAppAuth());

  getIt.registerLazySingleton(() =>
      ApiClient(getIt<Dio>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() =>
      AuthService(getIt<FlutterAppAuth>(), getIt<FlutterSecureStorage>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('selected_language');

  final String initialRoute = language == null ? '/language' : '/dashboard';
  final Locale initialLocale = Locale(language ?? 'en');

  await dotenv.load(fileName: ".env");

  configureDependencies();

  runApp(SherpoutApp(initialRoute: initialRoute, initialLocale: initialLocale));
}
