import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

class RecordHistoryYearDivider extends StatelessWidget {
  final int year;

  const RecordHistoryYearDivider({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Text(
            year.toString(),
            style: AppTypography.titleSmall
                .copyWith(color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(thickness: 1)),
        ],
      ),
    );
  }
}