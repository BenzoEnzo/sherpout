import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';

import '../../../services/image_service.dart';
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
        ExerciseCover(
            difficulty: exercise.difficulty,
            objectName: "6%2F520f6f96-5266-4890-8f5c-226b5cceed48.jpg",
        ),
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
