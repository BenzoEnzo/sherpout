import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/string_extension.dart';

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
        Column(children: [
          Container(
            width: 72,
            decoration: BoxDecoration(
              color: const Color(0xffC94935),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                exercise.difficulty.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Container(
              width: 72,
              height: 72,
              color: Colors.black,
            ),
          ),
        ],),
        SizedBox(width: 16),
        Expanded(
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exercise.name.en, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              Text(exercise.targetMuscle.en.capitalize(), style: TextStyle(fontSize: 18)),
              Text(exercise.supportMuscles!.map((muscle) => muscle.en.capitalize()).join(', '), style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Icon(Icons.chevron_right)
      ],
    );
  }
}