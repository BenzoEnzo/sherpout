import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/pages/activity/exercises_filter_button.dart';
import 'package:sherpoutmobile/pages/activity/search_input.dart';
import 'package:getwidget/getwidget.dart';

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
                    child: GFAccordion(
                      titleBorderRadius: const BorderRadius.all(Radius.circular(16)),
                      titleChild: Text('Muscle category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                        expandedTitleBackgroundColor: const Color(0xffADC5EB),
                        margin: EdgeInsets.all(0),
                      content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'
                ),
                );
              }),
            ],
          ),
    );
  }
}