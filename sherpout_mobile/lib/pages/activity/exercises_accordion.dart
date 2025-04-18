import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:sherpoutmobile/pages/activity/exercise_list_item.dart';

class ExercisesAccordion extends StatefulWidget {
  const ExercisesAccordion({super.key});

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
      contentBorder: Border.all(color: const Color(0xffADC5EB)),
      titleBorder: Border.all(color: const Color(0xffADC5EB)),
      contentBorderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      contentBackgroundColor: Colors.white,
      expandedTitleBackgroundColor: const Color(0xffADC5EB),
      margin: EdgeInsets.all(0),
      titleChild: Text(
        'Muscle category',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      contentChild: Column(
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ExerciseListItem(),
            );
          }),
      ),
    );
  }
}