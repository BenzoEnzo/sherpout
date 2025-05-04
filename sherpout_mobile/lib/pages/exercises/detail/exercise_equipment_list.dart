import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';

import 'exercise_equipment_item.dart';

class ExerciseEquipmentList extends StatelessWidget {
  final Set<ExerciseEquipment> equipments;

  const ExerciseEquipmentList({super.key, required this.equipments});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16.0),
      children: [
        ...equipments.map((equipment) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ExerciseEquipmentItem(equipment),
          );
        }),
      ],
    );
  }
}