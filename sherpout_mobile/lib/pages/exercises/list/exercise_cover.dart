import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_difficulty.dart';

import 'exercise_difficulty_label.dart';

class ExerciseCover extends StatelessWidget {
  final ExerciseDifficulty difficulty;

  const ExerciseCover({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ExerciseDifficultyLabel(difficulty: difficulty),
      ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        child: Container(
          width: 72,
          height: 72,
          color: Colors.black,
        ),
      ),
    ],);
  }
}