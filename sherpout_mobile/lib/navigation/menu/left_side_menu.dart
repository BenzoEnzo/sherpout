import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeftSideMenu extends StatelessWidget {

  const LeftSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Sherpout Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
                ),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text(AppLocalizations.of(context)!.exercises),
            onTap: () {
              Navigator.pushNamed(context, '/exercises');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text(AppLocalizations.of(context)!.trainings),
            onTap: () {
              Navigator.pushNamed(context, '/trainings');
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text(AppLocalizations.of(context)!.records),
            onTap: () {
              Navigator.pushNamed(context, '/records');
            },
          ),
          ListTile(
            leading: Icon(Icons.equalizer),
            title: Text(AppLocalizations.of(context)!.rankings),
            onTap: () {
              Navigator.pushNamed(context, '/rankings');
            },
          ),
        ],
      ),
    );
  }
}
