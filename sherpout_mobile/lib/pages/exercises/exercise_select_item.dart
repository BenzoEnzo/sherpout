import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercise_cover.dart';

class ExerciseSelectItem extends StatelessWidget {
  final ExerciseSelectDTO exercise;

  const ExerciseSelectItem({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ExerciseCover(cover: exercise.cover),
      SizedBox(width: 20),
      Text(exercise.name.localized(context), style: AppTypography.bodyMedium)
    ]
    );
  }

}