import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/pages/dashboard/dashboard_page.dart';
import 'package:sherpoutmobile/pages/language/objects/language.dart';
import 'package:sherpoutmobile/pages/language/language_page.dart';

import 'package:sherpoutmobile/pages/personal/account_page.dart';
import 'package:sherpoutmobile/pages/personal/friends_page.dart';
import 'package:sherpoutmobile/pages/personal/settings_page.dart';

import 'package:sherpoutmobile/pages/activity/exercises_page.dart';
import 'package:sherpoutmobile/pages/activity/rankings_page.dart';
import 'package:sherpoutmobile/pages/activity/records_page.dart';
import 'package:sherpoutmobile/pages/activity/trainings_page.dart';

import 'l10n/l10n.dart';

class SherpoutApp extends StatefulWidget {
  final String initialRoute;
  final Locale initialLocale;

  const SherpoutApp({
    super.key,
    required this.initialRoute,
    required this.initialLocale
  });

  @override
  _SherpoutAppState createState() => _SherpoutAppState();
}

class _SherpoutAppState extends State<SherpoutApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language.code);
    setState(() {
      _locale = Locale(language.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sherpout App",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[50],
      ),

      initialRoute: widget.initialRoute,
      routes: {
        "/language": (context) => LanguagePage(setLocale: setLocale),
        "/dashboard": (context) => DashboardPage(userName: "Jan"),
        "/accounts": (context) => AccountPage(),
        "/friends": (context) => FriendsPage(),
        "/settings": (context) => SettingsPage(),
        "/exercises": (context) => ExercisesPage(),
        "/rankings": (context) => RankingsPage(),
        "/records": (context) => RecordsPage(),
        "/trainings": (context) => TrainingsPage(),
      },

      supportedLocales: L10n.all,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}