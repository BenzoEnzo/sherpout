import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form.dart';

import '../../../../common/components/app_page.dart';

class TrainingPlanDetailPage extends StatefulWidget {
  final TrainingPlanDTO trainingPlan;

  const TrainingPlanDetailPage({super.key, required this.trainingPlan});

  @override
  State<TrainingPlanDetailPage> createState() => _TrainingPlanDetailPageState();
}

class _TrainingPlanDetailPageState extends State<TrainingPlanDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detailTrainingPlan),
      ),
      body: AppPage(
        child: TrainingPlanForm(
          trainingPlan: widget.trainingPlan,
          isEdit: false,
        ),
      ),
    );
  }
}