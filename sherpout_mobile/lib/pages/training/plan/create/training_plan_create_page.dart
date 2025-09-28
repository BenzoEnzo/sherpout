import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form.dart';

import '../../../../common/components/app_page.dart';

class TrainingPlanCreatePage extends StatelessWidget {
  const TrainingPlanCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createNewTrainingPlan),
      ),
      body: AppPage(child:
      TrainingPlanForm(
          trainingPlan: TrainingPlanDTO(
            days: [
              TrainingPlanDayDTO(number: 1)
            ]
          ))),
    );
  }
}
