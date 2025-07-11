import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpoutmobile/pages/activity/rankings_page.dart';
import 'package:sherpoutmobile/pages/activity/trainings_page.dart';
import 'package:sherpoutmobile/pages/auth/auth_page.dart';
import 'package:sherpoutmobile/pages/dashboard/dashboard_page.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_detail_page.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercises_page.dart';
import 'package:sherpoutmobile/pages/language/language_page.dart';
import 'package:sherpoutmobile/pages/language/objects/language.dart';
import 'package:sherpoutmobile/pages/personal/account_page.dart';
import 'package:sherpoutmobile/pages/personal/friends_page.dart';
import 'package:sherpoutmobile/pages/personal/settings_page.dart';
import 'package:sherpoutmobile/pages/records/list/records_list_page.dart';

import 'common/theme/app_colors.dart';
import 'l10n/l10n.dart';

class SherpoutApp extends StatefulWidget {
  final String initialRoute;
  final Locale initialLocale;
  final GlobalKey<NavigatorState> navigatorKey;

  const SherpoutApp({
    super.key,
    required this.initialRoute,
    required this.initialLocale,
    required this.navigatorKey
  });

  @override
  _SherpoutAppState createState() => _SherpoutAppState();
}

class _SherpoutAppState extends State<SherpoutApp> {
  late final GoRouter _router = _buildRouter();
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

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: widget.initialRoute,
      navigatorKey: widget.navigatorKey,
      routes: [
        GoRoute(
          path: '/language',
          builder: (context, state) => LanguagePage(setLocale: setLocale),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => AuthPage(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(
          path: '/accounts',
          builder: (context, state) => AccountPage(),
        ),
        GoRoute(
          path: '/friends',
          builder: (context, state) => FriendsPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsPage(),
        ),
        GoRoute(
          path: '/exercises',
          builder: (context, state) => ExercisesListPage(),
        ),
        GoRoute(
          path: '/exercise/:id',
          builder: (context, state) {
            final exerciseId = int.parse(state.pathParameters['id']!);
            return ExerciseDetailPage(id: exerciseId);
          },
        ),
        GoRoute(
          path: '/rankings',
          builder: (context, state) => RankingsPage(),
        ),
        GoRoute(
          path: '/records',
          builder: (context, state) => RecordsPage(),
        ),
        GoRoute(
          path: '/trainings',
          builder: (context, state) => TrainingsPage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Sherpout App",
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redAccent, width: 2),
          ),
        ),
      ),
      routerConfig: _router,

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