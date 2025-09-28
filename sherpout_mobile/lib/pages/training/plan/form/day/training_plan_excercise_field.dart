import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/components/field/app_number_field.dart';
import 'package:sherpoutmobile/common/dto/training_plan_exercise_dto.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

import '../../../../../common/components/field/app_autocomplete_field.dart';
import '../../../../../common/dto/exercise_select_dto.dart';
import '../../../../exercises/exercise_select_item.dart';

class TrainingPlanExerciseField extends StatefulWidget {
  final TrainingPlanExerciseDTO dto;
  final List<ExerciseSelectDTO> exercises;
  final void Function() removeExercise;

  const TrainingPlanExerciseField({super.key,
      required this.dto,
      required this.exercises,
      required this.removeExercise
  });

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
                  label: AppLocalizations.of(context)!.sets,
                  initialValue: widget.dto.sets,
                  setValue: (value) {
                    widget.dto.sets = value.toInt();
                  },
                  isRequired: true,
                  min: 1,
                  max: 16
              )
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: widget.removeExercise,
              color: AppColors.secondary
            ),
          ],
        ));
  }
}
