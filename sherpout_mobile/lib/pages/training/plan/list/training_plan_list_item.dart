import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';

class TrainingPlanItem extends StatelessWidget {
  const TrainingPlanItem({super.key, required this.trainingPlan});

  final TrainingPlanDTO trainingPlan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        key: ValueKey(trainingPlan.id),
        borderRadius: BorderRadius.circular(16),
        onTap: () {});
  }
}
