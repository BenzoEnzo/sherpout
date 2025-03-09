import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpoutmobile/common/api_client.dart';
import 'package:sherpoutmobile/common/auth_service.dart';
import 'package:sherpoutmobile/sherpout_app.dart';
import 'package:get_it/get_it.dart';

import 'common/user_provider.dart';

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

String getInitialRoute(String? language, bool isUserLoggedIn) {
  if (language == null) {
    return '/language';
  }
  if (!isUserLoggedIn) {
    return '/auth';
  }
  return '/dashboard';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  final authService = getIt<AuthService>();

  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('selected_language');
  final bool isUserLoggedIn = await authService.isUserLoggedIn();

  final Locale initialLocale = Locale(language ?? 'en');

  await dotenv.load(fileName: ".env");

  runApp(
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: SherpoutApp(initialRoute: getInitialRoute(language, isUserLoggedIn), initialLocale: initialLocale),
      ));
}
