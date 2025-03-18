import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/component/user/user_drawer_header.dart';

import '../../common/user_provider.dart';

class RightSideMenu extends StatelessWidget {

  const RightSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

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
                Navigator.pushNamed(context, "/accounts");
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(AppLocalizations.of(context)!.friends),
              onTap: () {
                Navigator.pushNamed(context, "/friends");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
              onTap: () {
                Navigator.pushNamed(context, "/settings");
              },
            ),
          ],
        ),
      ),
    );
  }
}