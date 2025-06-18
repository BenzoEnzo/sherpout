import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/muscle_category.dart';
import 'package:sherpoutmobile/common/extensions/string_extension.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

import '../../../common/theme/app_colors.dart';
import 'exercise_list_item.dart';

class ExercisesAccordion extends StatefulWidget {
  final MuscleCategory category;
  final List<ExerciseListDto> exercises;

  const ExercisesAccordion({super.key, required this.category, required this.exercises});

  @override
  _ExercisesAccordionState createState() => _ExercisesAccordionState();
}

class _ExercisesAccordionState extends State<ExercisesAccordion> {
  bool isExpanded = false;

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
      contentBorder: Border.all(color: AppColors.secondary),
      titleBorder: Border.all(color: AppColors.secondary),
      contentBorderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      contentBackgroundColor: AppColors.background,
      collapsedTitleBackgroundColor: AppColors.background,
      expandedTitleBackgroundColor: AppColors.secondary,
      contentPadding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      titleChild: Text(
        widget.category.localized(context).capitalize(),
        style: AppTypography.titleLarge,
      ),
      contentChild: Column(
        children: List.generate(widget.exercises.length, (index) {
          final exercise = widget.exercises[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExerciseListItem(exercise: exercise),
              ),
              if (index < widget.exercises.length - 1)
                Divider(
                  color: AppColors.secondary,
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
