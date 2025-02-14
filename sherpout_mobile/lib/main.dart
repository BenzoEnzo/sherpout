import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpout_mobile/sherpout_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('selected_language');

  final String initialRoute = language == null ? '/language' : '/dashboard';
  final Locale initialLocale = Locale(language ?? 'en');

  runApp(SherpoutApp(initialRoute: initialRoute, initialLocale: initialLocale));
}
