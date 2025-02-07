import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpout_mobile/pages/dashboard/app_localizations_extension.dart';
import 'package:sherpout_mobile/pages/dashboard/data/training_day.dart';
import 'package:sherpout_mobile/pages/dashboard/data/training_day_status.dart';

class TrainingDayCard extends StatelessWidget {
  final TrainingDay trainingDay;

  const TrainingDayCard({super.key, required this.trainingDay});

  Color _getCardColor() {
    switch (trainingDay.status) {
      case TrainingDayStatus.finished:
        return Colors.greenAccent[100]!;
      case TrainingDayStatus.upcoming:
        return Colors.blueAccent[100]!;
      case TrainingDayStatus.cancelled:
        return Colors.redAccent[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCardColor(),
      child: SizedBox(
        width: 200,
        child: Column(
          children: <Widget> [
            Text(
              AppLocalizations.of(context)!.getTranslation(trainingDay.day.shortcutPlaceholder),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)
            ),
            Column(
            children: trainingDay.exercises
                .map((exercise) => Text(style: TextStyle(fontSize: 16),exercise))
                .toList(),
            ),
          ]
        )
      )
    );
  }

}