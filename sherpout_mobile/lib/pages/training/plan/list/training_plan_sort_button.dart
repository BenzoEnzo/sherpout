import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/components/buttons/sort_button.dart';


class TrainingPlanSortButton extends StatelessWidget {
  final ValueChanged<int>? onSelected;

  const TrainingPlanSortButton({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SortButton(
      labels: [
        AppLocalizations.of(context)!.sortByName,
        AppLocalizations.of(context)!.sortByDate,
      ],
      onSelected: onSelected,
    );
  }
}