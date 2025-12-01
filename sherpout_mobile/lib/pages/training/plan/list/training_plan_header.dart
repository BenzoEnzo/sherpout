import 'package:flutter/material.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_sort_button.dart';

class TrainingPlanHeader extends StatelessWidget {
  final ValueChanged<int>? onSortSelected;

  const TrainingPlanHeader({super.key, this.onSortSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrainingPlanSortButton(
          onSelected: onSortSelected,
        ),
      ],
    );
  }
}