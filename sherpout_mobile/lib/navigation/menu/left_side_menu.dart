import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme/app_colors.dart';

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
              color: AppColors.primary,
            ),
            child: Text('Sherpout Menu',
              style: TextStyle(color: AppColors.surface, fontSize: 20),
                ),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text(AppLocalizations.of(context)!.exercises),
            onTap: () {
              context.push('/exercises');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text(AppLocalizations.of(context)!.trainings),
            onTap: () {
              context.push('/trainings');
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text(AppLocalizations.of(context)!.records),
            onTap: () {
              context.push('/records');
            },
          ),
          ListTile(
            leading: Icon(Icons.equalizer),
            title: Text(AppLocalizations.of(context)!.rankings),
            onTap: () {
              context.push('/rankings');
            },
          ),
        ],
      ),
    );
  }
}
