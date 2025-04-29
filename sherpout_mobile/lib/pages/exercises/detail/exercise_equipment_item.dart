import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';
import 'package:sherpoutmobile/common/extensions/string_extension.dart';

class ExerciseEquipmentItem extends StatelessWidget {
  final ExerciseEquipment equipment;


  const ExerciseEquipmentItem(this.equipment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.icecream_outlined),
        Text(equipment.localized(context).capitalize())
      ],
    );
  }
  
}