import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpoutmobile/sherpout_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('selected_language');

  final String initialRoute = language == null ? '/language' : '/dashboard';
  final Locale initialLocale = Locale(language ?? 'en');

  await dotenv.load(fileName: ".env");

  runApp(SherpoutApp(initialRoute: initialRoute, initialLocale: initialLocale));
}
