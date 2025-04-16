import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/pages/activity/exercises_filter_button.dart';
import 'package:sherpoutmobile/pages/activity/search_input.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.exercises),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            spacing: 16.0,
            children: [
              ExercisesFilterButton(),
              SearchInput(),
            ],
          )),
    );
  }
}