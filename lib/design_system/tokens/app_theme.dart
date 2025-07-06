import 'package:flutter_template/design_system/tokens/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondary,
    ),
    primaryColor: AppColors.primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: AppColors.secondary,
    appBarTheme: const AppBarTheme(surfaceTintColor: AppColors.transparent),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.transparent,
    ),
  );
}
