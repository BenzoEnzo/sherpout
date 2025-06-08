import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/navigation/menu/user_drawer_header.dart';

import '../../common/auth_service.dart';
import '../../common/user_provider.dart';

class RightSideMenu extends StatelessWidget {

  const RightSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final AuthService authService = GetIt.instance<AuthService>();

    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.blue[50],
        child: Column(
          children: [
            UserDrawerHeader(
              name: userProvider.userData!.firstName,
              lastName: userProvider.userData!.lastName,
              accountEmail: userProvider.userData!.email
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(AppLocalizations.of(context)!.account),
              onTap: () {
                context.push("/accounts");
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(AppLocalizations.of(context)!.friends),
              onTap: () {
                context.push("/friends");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
              onTap: () {
                context.push("/settings");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations.of(context)!.logOut),
              onTap: () {
                authService.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}