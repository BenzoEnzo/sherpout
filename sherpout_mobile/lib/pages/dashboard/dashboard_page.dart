import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sherpoutmobile/navigation/menu/left_side_menu.dart';
import 'package:sherpoutmobile/navigation/menu/right_side_menu.dart';

class DashboardPage extends StatelessWidget {
  final String userName;
  const DashboardPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
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
                  child: Text(userName.isNotEmpty ? userName.characters.first.toUpperCase() : '',
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
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
              },
              child: Text('Clear shared preferences.'),
            ),
          ],
        ),
      ),
    );
  }
}