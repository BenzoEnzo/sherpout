import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';
import 'package:sherpoutmobile/common/extensions/string_extension.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

class ExerciseEquipmentItem extends StatelessWidget {
  final ExerciseEquipment equipment;


  const ExerciseEquipmentItem(this.equipment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary),
      ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.icecream_outlined, size: 40),
              Text(equipment.localized(context).capitalize(), style: TextStyle(fontSize: 20),)
            ],
          ),
        )
    );
  }
}