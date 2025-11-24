import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import '../../../../common/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/theme/app_typography.dart';

class TrainingPlanRowComponent extends StatelessWidget {
  const TrainingPlanRowComponent({
    super.key,
    required this.trainingPlan,
    this.showChevron = true,
    this.padding = const EdgeInsets.all(12),
  });

  final TrainingPlanDTO trainingPlan;
  final bool showChevron;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainingPlan.name!.localized(context),
                  style: AppTypography.titleLarge,
                ),
                if (trainingPlan.description != null &&
                    trainingPlan.description!.localized(context).isNotEmpty)
                  Text(
                    trainingPlan.description!.localized(context),
                    style: AppTypography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  '${AppLocalizations.of(context)!.days}: ${trainingPlan.days.length}',
                  style: AppTypography.bodySmall.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (showChevron) const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}