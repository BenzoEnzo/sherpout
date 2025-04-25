import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';

import 'exercise_cover.dart';
import 'exercise_summary.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseListDto exercise;

  const ExerciseListItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExerciseCover(difficulty: exercise.difficulty),
        SizedBox(width: 16),
        Expanded(
          child: ExerciseSummary(
              name: exercise.name,
              targetMuscle: exercise.targetMuscle,
              supportMuscles: exercise.supportMuscles),
        ),
        Icon(Icons.chevron_right)
      ],
    );
  }
}
