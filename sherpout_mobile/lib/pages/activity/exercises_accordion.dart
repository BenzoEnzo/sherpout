import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:sherpoutmobile/common/dto/exercise_difficulty.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/muscle.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'package:sherpoutmobile/pages/activity/exercise_list_item.dart';

class ExercisesAccordion extends StatefulWidget {
  const ExercisesAccordion({super.key});

  @override
  _ExercisesAccordionState createState() => _ExercisesAccordionState();
}

class _ExercisesAccordionState extends State<ExercisesAccordion> {
  bool isExpanded = false;

  final ExerciseListDto exercise = ExerciseListDto(
    id: 1, 
    name: TranslatedStringDto(en: 'Barbell squat', pl: 'Przysiad ze sztangą'),
    difficulty: ExerciseDifficulty.hard,
    targetMuscle: Muscle.calves,
    supportMuscles: {Muscle.upperAbs, Muscle.upperChest},
    likesNumber: 0,
  );

  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      onToggleCollapsed: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      titleBorderRadius: isExpanded
          ? const BorderRadius.vertical(top: Radius.circular(16))
          : const BorderRadius.all(Radius.circular(16)),
      contentBorder: Border.all(color: const Color(0xffADC5EB)),
      titleBorder: Border.all(color: const Color(0xffADC5EB)),
      contentBorderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      contentBackgroundColor: Colors.white,
      expandedTitleBackgroundColor: const Color(0xffADC5EB),
      contentPadding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      titleChild: Text(
        'Muscle category',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      contentChild: Column(
          children: List.generate(3, (index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExerciseListItem(exercise: exercise),
                ),
                if (index < 2)
                  Divider(
                    color: const Color(0xffADC5EB),
                    thickness: 1.0,
                    height: 0.0,
                  ),
              ],
            );
          }),
      ),
    );
  }
}