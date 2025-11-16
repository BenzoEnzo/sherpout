import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

class AddNewButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.secondary,
      icon: const Icon(
        Icons.add,
        color: AppColors.surface,
      ),
      label: Text(
        AppLocalizations.of(context)!.addNew,
        style: const TextStyle(
          color: AppColors.surface,
        ),
      ),
      onPressed: onPressed,
    );
  }
}