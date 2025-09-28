import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_and_icon_button.dart';
import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';
import 'package:sherpoutmobile/common/dto/training_plan_exercise_dto.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/pages/training/plan/form/day/training_plan_excercise_field.dart';

import '../../../../../common/dto/exercise_select_dto.dart';
import '../../../../../services/exercise_service.dart';

class TrainingPlanDayForm extends StatefulWidget {
  final TrainingPlanDayDTO day;
  final void Function() removeDay;

  const TrainingPlanDayForm(
      {super.key, required this.day, required this.removeDay});

  @override
  State<TrainingPlanDayForm> createState() => _TrainingPlanDayFormState();
}

class _TrainingPlanDayFormState extends State<TrainingPlanDayForm> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();
  List<ExerciseSelectDTO> _exercises = [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    final exercises = await _exerciseService.getSelects();
    setState(() {
      _exercises = exercises;
    });
  }

  void _addExercise() {
    setState(() {
      widget.day.exercises.add(TrainingPlanExerciseDTO());
    });
  }

  void _removeExercise(int index) {
    setState(() {
      widget.day.exercises.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...List.generate(
          widget.day.exercises.length,
          (index) => TrainingPlanExerciseField(
                key: ValueKey(index),
                dto: widget.day.exercises[index],
                exercises: _exercises,
                removeExercise: () => _removeExercise(index),
              )),
      SizedBox(
        width: double.infinity,
        child: AppTextAndIconButton(
            text: "Add exercise", onPressed: _addExercise, icon: Icons.add),
      ),
      SizedBox(
        width: double.infinity,
        child: AppTextAndIconButton(
          text: "Remove day",
          onPressed: widget.removeDay,
          icon: Icons.delete_outline_rounded,
          backgroundColor: AppColors.redAccent,
        ),
      ),
    ]);
  }
}
