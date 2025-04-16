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
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            children: [
              ExercisesFilterButton(),
              SizedBox(height: 16),
              SearchInput(),
              SizedBox(height: 16),
              ...List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 100,
                    color: Colors.redAccent,
                    child: Center(child: Text("Box ${index + 1}")),
                  ),
                );
              }),
            ],
          ),
    );
  }
}