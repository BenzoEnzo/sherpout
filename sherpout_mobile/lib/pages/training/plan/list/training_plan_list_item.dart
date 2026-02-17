import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/detail/training_plan_detail_page.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_row_component.dart';

class TrainingPlanItem extends StatelessWidget {
  const TrainingPlanItem({super.key, required this.trainingPlan});

  final TrainingPlanDTO trainingPlan;

  Future<void> _goToDetails(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TrainingPlanDetailPage(trainingPlan: trainingPlan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _goToDetails(context),
        child: TrainingPlanRowComponent(trainingPlan: trainingPlan));
  }
}
