import 'package:flutter/material.dart';
import 'package:sherpoutmobile/pages/records/list/record_weight_circle.dart';

import '../../../common/theme/app_typography.dart';

class RecordListItemFooter extends StatelessWidget {
  final String formattedDate;
  final num weight;

  const RecordListItemFooter({super.key, required this.formattedDate, required this.weight});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const Icon(Icons.calendar_today, size: 24, color: Colors.black),
          const SizedBox(width: 8),
          Text(formattedDate, style: AppTypography.bodyLarge),
        ],
      ),
      RecordWeightCircle(weight: weight),
    ],
  );
}