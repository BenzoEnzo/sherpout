import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isDisabled;
  final bool isLoading;

  const AppTextButton(
      {super.key,
        required this.text,
        required this.onPressed,
        this.isDisabled = false,
        this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isDisabled ? null : onPressed,
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.background,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      ),
    );
  }
}
