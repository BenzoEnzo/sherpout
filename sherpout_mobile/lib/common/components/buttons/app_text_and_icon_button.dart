import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/buttons/app_loading_button.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

class AppTextAndIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color backgroundColor;

  const AppTextAndIconButton({super.key,
      required this.text,
      required this.icon,
      required this.onPressed,
      this.isDisabled = false,
      this.isLoading = false,
      this.backgroundColor = AppColors.primary
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? AppLoadingButton()
        : ElevatedButton.icon(
            onPressed: isDisabled ? null : onPressed,
            icon: Icon(icon, color: AppColors.background),
            label: Text(
              text,
              style: AppTypography.titleSmall.copyWith(color: AppColors.background)
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
          );
  }
}
