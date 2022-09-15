import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static bool isDark = false;

  static ThemeData LightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.PrimaryColorLight,
      secondary: AppColors.SecondryColorLight,
      brightness: Brightness.light,
    ),
  );
  static ThemeData DarkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: AppColors.PrimaryColorDark,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.PrimaryColorDark,
      secondary: AppColors.SecondryColorDark,
      brightness: Brightness.dark,
    ),
  );
}
