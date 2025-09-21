import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/field/app_number_field.dart';
import 'package:sherpoutmobile/common/dto/training_plan_exercise_dto.dart';

import '../../../../../common/components/field/app_autocomplete_field.dart';
import '../../../../../common/dto/exercise_select_dto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../exercises/exercise_select_item.dart';

class TrainingPlanExerciseField extends StatefulWidget {
  final TrainingPlanExerciseDTO dto;
  final List<ExerciseSelectDTO> exercises;

  const TrainingPlanExerciseField(
      {super.key, required this.dto, required this.exercises});

  @override
  State<TrainingPlanExerciseField> createState() =>
      _TrainingPlanExerciseFieldState();
}

class _TrainingPlanExerciseFieldState extends State<TrainingPlanExerciseField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ExerciseField dto hash: ${widget.dto.hashCode}, sets: ${widget.dto.sets}");
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: AppAutocompleteField<ExerciseSelectDTO>(
                options: widget.exercises,
                label: AppLocalizations.of(context)!.exercise,
                isRequired: true,
                initialValue: widget.dto.exercise,
                setValue: (exercise) => widget.dto.exercise = exercise,
                getDisplay: (value) => value.name.localized(context),
                optionViewBuilder: (context, value) =>
                    ExerciseSelectItem(exercise: value),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: AppNumberField(
                  label: "Sets",
                  initialValue: widget.dto.sets,
                  setValue: (value) {
                    print("USTAWIAM SETS NA: $value");
                    widget.dto.sets = value.toInt();
                    print("DTO teraz: ${widget.dto.sets}");
                  },
                  isRequired: true
              )
            ),
          ],
        ));
  }
}
