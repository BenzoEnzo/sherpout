import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

import '../create/training_plan_create_page.dart';

class TrainingPlanFooter extends StatelessWidget {
  final VoidCallback onReload;

  const TrainingPlanFooter({
    super.key,
    required this.onReload,
  });

  Future<void> _onAddNew(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TrainingPlanCreatePage(),
      ),
    );

    onReload();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.secondary,
      icon: const Icon(Icons.add,
        color: AppColors.surface,),
      label: Text(AppLocalizations.of(context)!.addNew,
      style: TextStyle(color: AppColors.surface)),
      onPressed: () => _onAddNew(context),
    );
  }
}