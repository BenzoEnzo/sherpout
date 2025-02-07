import 'package:flutter/material.dart';
import 'package:sherpout_mobile/component/user/user_drawer_header.dart';

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
              accountName: "Jan Pawel",
              accountEmail: "janpaweldrugi@wybitnepolakes.pl",
              avatarInitial: "J",
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Account"),
              onTap: () {
                Navigator.pushNamed(context, "/accounts");
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Friends"),
              onTap: () {
                Navigator.pushNamed(context, "/friends");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
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