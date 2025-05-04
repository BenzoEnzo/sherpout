import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'exercise_cover_with_difficulty.dart';
import 'exercise_summary.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseListDto exercise;

  const ExerciseListItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.push('/exercise/${exercise.id}');
        },
        child: Row(
          children: [
            ExerciseCoverWithDifficulty(difficulty: exercise.difficulty),
            SizedBox(width: 16),
            Expanded(
              child: ExerciseSummary(
                  name: exercise.name,
                  targetMuscle: exercise.targetMuscle,
                  supportMuscles: exercise.supportMuscles
              ),
            ),
            Icon(Icons.chevron_right)
          ],
        ));
  }
}
