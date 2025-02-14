import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.trainings)),
      body: Center(child: Text("This is the Trainings page")),
    );
  }
}