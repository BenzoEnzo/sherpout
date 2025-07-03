import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

class RecordWeightCircle extends StatelessWidget {
  final num weight;
  final Color color;
  const RecordWeightCircle({super.key, required this.weight, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.background,
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ]),
      alignment: Alignment.center,
      child: Text(
        '$weight kg',
        textAlign: TextAlign.center,
        style: AppTypography.titleSmall,
      ),
    );
  }
}
