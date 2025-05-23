import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercise_header.dart';

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
        child: ExerciseHeader(exercise: exercise)
    );
  }
}
