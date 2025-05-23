import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  static TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    color: AppColors.text,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.subtitle,
  );

  static TextStyle difficultyLabel = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static TextStyle buttonLarge = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500
  );

  static TextStyle buttonMedium = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500
  );

  static TextStyle buttonSmall = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500
  );
}