import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpout_mobile/l10n/l10n.dart';
import 'package:sherpout_mobile/pages/dashboard/dashboard_page.dart';
import 'package:sherpout_mobile/pages/language/language_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('selected_language');

  runApp(MyApp(initialRoute: language == null ? '/language' : '/dashboard'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sherpout App",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[50],
      ),

      initialRoute: initialRoute,
      routes: {
        "/language": (context) => LanguagePage(),
        "/dashboard": (context) => DashboardPage()
      },

      supportedLocales: L10n.all,
      locale: const Locale('pl'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
