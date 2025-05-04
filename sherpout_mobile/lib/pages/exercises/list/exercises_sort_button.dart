import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

class ExercisesSortButton extends StatefulWidget {
  @override
  _ExercisesSortButtonState createState() => _ExercisesSortButtonState();
}

class _ExercisesSortButtonState extends State<ExercisesSortButton> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints)
    {
      return ToggleButtons(
        borderRadius: BorderRadius.circular(30),
        selectedColor: Colors.white,
        color: AppColors.primary,
        fillColor: AppColors.primary,
        borderColor: AppColors.secondary,
        selectedBorderColor: AppColors.secondary,
        constraints: BoxConstraints.expand(width: constraints.maxWidth / 2 - 2),
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          });
        },
        children: [
          Text(AppLocalizations.of(context)!.sortByLikes,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
          ),
          Text(AppLocalizations.of(context)!.sortByPopularity,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
          ),
        ],
      );
    });
  }
}
