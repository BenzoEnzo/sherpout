import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/muscle_category.dart';
import 'package:sherpoutmobile/pages/activity/exercises_accordion.dart';
import 'package:sherpoutmobile/pages/activity/exercises_filter_button.dart';
import 'package:sherpoutmobile/pages/activity/search_input.dart';

import '../../common/dto/exercise_difficulty.dart';
import '../../common/dto/muscle.dart';
import '../../common/dto/translated_string_dto.dart';

class ExercisesPage extends StatelessWidget {
  ExercisesPage({super.key});

  final ExerciseListDto squat = ExerciseListDto(
    id: 1,
    name: TranslatedStringDto(en: 'Barbell squat', pl: 'Przysiad ze sztangą'),
    difficulty: ExerciseDifficulty.hard,
    targetMuscle: Muscle.quads,
    supportMuscles: {Muscle.glutes},
    likesNumber: 0,
  );

  final ExerciseListDto curl = ExerciseListDto(
    id: 2,
    name: TranslatedStringDto(en: 'Dumbell Biceps curl', pl: 'Bicek'),
    difficulty: ExerciseDifficulty.easy,
    targetMuscle: Muscle.backDelts,
    likesNumber: 0,
  );

  final ExerciseListDto press = ExerciseListDto(
    id: 3,
    name: TranslatedStringDto(en: 'Incline chest press', pl: 'Wyciskanie na ławce ze skosem dodatnim'),
    difficulty: ExerciseDifficulty.medium,
    targetMuscle: Muscle.upperChest,
    supportMuscles: {Muscle.midChest, Muscle.frontDelts},
    likesNumber: 0,
  );

  Map<MuscleCategory, List<ExerciseListDto>> get exerciseMap {
    return {
      MuscleCategory.back: [squat, curl, press],
      MuscleCategory.chest: [squat, curl, press],
      MuscleCategory.legs: [squat, curl, press],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.exercises),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            children: [
              ExercisesFilterButton(),
              SizedBox(height: 16),
              SearchInput(),
              SizedBox(height: 16),
              ...exerciseMap.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ExercisesAccordion(
                    category: entry.key,
                    exercises: entry.value,
                  ),
                );
              }),
            ],
          ),
    );
  }
}