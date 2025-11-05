import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimaryButton,
      secondary: AppColors.lightSecondaryButton,
      surface: AppColors.lightCards,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimaryButton,
      secondary: AppColors.darkSecondaryButton,
      surface: AppColors.darkCards,
    ),
  );
}
