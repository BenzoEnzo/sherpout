import 'package:flutter/material.dart';
import 'package:sherpout_mobile/component/user/user_drawer_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RightSideMenu extends StatelessWidget {

  const RightSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.blue[50],
        child: Column(
          children: [
            UserDrawerHeader(
              name: "Jan",
              lastName: "Pawel",
              accountEmail: "janpaweldrugi@wybitnepolakes.pl"
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