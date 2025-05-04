import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';

import 'exercise_equipment_item.dart';

class ExerciseEquipmentList extends StatelessWidget {
  final Set<ExerciseEquipment> equipments;

  const ExerciseEquipmentList({super.key, required this.equipments});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16.0),
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 1.2,
      children: equipments.map((equipment) {
        return ExerciseEquipmentItem(equipment);
      }).toList(),
    );
  }
}