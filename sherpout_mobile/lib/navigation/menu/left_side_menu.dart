import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/auth_service.dart';
import '../../common/user_provider.dart';
import '../../navigation/menu/user_drawer_header.dart';

class LeftSideMenu extends StatelessWidget {
  const LeftSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final authService = GetIt.instance<AuthService>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (userProvider.userData != null)
            UserDrawerHeader(
              name: userProvider.userData!.firstName,
              lastName: userProvider.userData!.lastName,
              accountEmail: userProvider.userData!.email,
            ),
          _navTile(
            context,
            icon: Icons.fitness_center,
            label: AppLocalizations.of(context)!.exercises,
            route: '/exercises',
          ),
          _navTile(
            context,
            icon: Icons.directions_run,
            label: AppLocalizations.of(context)!.trainings,
            route: '/training-plans',
          ),
          _navTile(
            context,
            icon: Icons.book,
            label: AppLocalizations.of(context)!.records,
            route: '/records',
          ),
          _navTile(
            context,
            icon: Icons.equalizer,
            label: AppLocalizations.of(context)!.rankings,
            route: '/rankings',
          ),

          const Divider(),

          _navTile(
            context,
            icon: Icons.account_circle,
            label: AppLocalizations.of(context)!.account,
            route: '/accounts',
          ),
          _navTile(
            context,
            icon: Icons.people,
            label: AppLocalizations.of(context)!.friends,
            route: '/friends',
          ),
          _navTile(
            context,
            icon: Icons.settings,
            label: AppLocalizations.of(context)!.settings,
            route: '/settings',
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logOut),
            onTap: authService.logout,
          ),
        ],
      ),
    );
  }

  ListTile _navTile(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () => context.push(route),
    );
  }
}
