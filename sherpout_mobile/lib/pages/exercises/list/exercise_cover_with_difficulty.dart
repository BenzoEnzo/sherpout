import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_difficulty.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercise_cover.dart';
import 'exercise_difficulty_label.dart';

class ExerciseCoverWithDifficulty extends StatelessWidget {
  final ExerciseDifficulty difficulty;
  final String objectName;

  const ExerciseCoverWithDifficulty({
    super.key,
    required this.difficulty,
    required this.objectName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExerciseDifficultyLabel(difficulty: difficulty),
        ExerciseCover(objectName: objectName),
      ],
    );
  }
}
