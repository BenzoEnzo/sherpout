import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.dashboardTitle)),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.hello,
          style: TextStyle(
            fontSize: 24
          ),
        )
      ),
    );
  }
}