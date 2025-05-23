import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';
import 'package:sherpoutmobile/common/extensions/string_extension.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

class ExerciseEquipmentItem extends StatelessWidget {
  final ExerciseEquipment equipment;


  const ExerciseEquipmentItem(this.equipment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.icecream_outlined, size: 40, color: AppColors.text),
          const SizedBox(height: 8),
          Text(
            equipment.localized(context).capitalize(),
            style: AppTypography.titleMedium.copyWith(color: AppColors.text),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}