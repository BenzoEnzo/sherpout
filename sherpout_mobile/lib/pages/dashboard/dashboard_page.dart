import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sherpoutmobile/navigation/menu/left_side_menu.dart';
import 'package:sherpoutmobile/navigation/menu/right_side_menu.dart';

import '../../common/user_provider.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class DashboardPage extends StatelessWidget {

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      drawer: LeftSideMenu(),
      endDrawer: RightSideMenu(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboardTitle),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(getFirstLetter(userProvider.userData!.firstName),
                      style: const TextStyle(color: Colors.white)),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.hello,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final FlutterSecureStorage secureStorage = FlutterSecureStorage();
                final prefs = await SharedPreferences.getInstance();
                await secureStorage.delete(key: 'access_token');
                await secureStorage.delete(key: 'id_token');
                await prefs.clear();
              },
              child: Text('Clear shared preferences.'),
            ),
          ],
        ),
      ),
    );
  }

  String getFirstLetter(String name) {
    if (name.isEmpty) {
      return '';
    }
    return name[0].toUpperCase();
  }
}