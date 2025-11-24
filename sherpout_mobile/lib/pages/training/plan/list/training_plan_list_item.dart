import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_row_component.dart';

class TrainingPlanItem extends StatelessWidget {
  const TrainingPlanItem({super.key, required this.trainingPlan});

  final TrainingPlanDTO trainingPlan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: TrainingPlanRowComponent(trainingPlan: trainingPlan));
  }
}
