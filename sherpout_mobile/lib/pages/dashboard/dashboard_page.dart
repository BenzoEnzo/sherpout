import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpout_mobile/pages/dashboard/components/training_week.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.dashboardTitle)),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${AppLocalizations.of(context)!.hello} Janusz!",
              style: TextStyle(
                fontSize: 36
              ),
            ),
            Text(
                "This week",
              style: TextStyle(
                fontSize: 30
              )
            ),
            TrainingWeek(),
          ]
        )
    );
  }
}