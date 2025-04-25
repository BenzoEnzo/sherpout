import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/dto/exercise_difficulty.dart';

class ExerciseDifficultyLabel extends StatelessWidget {
  final ExerciseDifficulty difficulty;

  const ExerciseDifficultyLabel({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          difficulty.localized(context).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (difficulty) {
      case ExerciseDifficulty.easy:
        return const Color(0xff35C944);
      case ExerciseDifficulty.medium:
        return const Color(0xffC9A435);
      case ExerciseDifficulty.hard:
        return const Color(0xffC94935);
    }
  }
}