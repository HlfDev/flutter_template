import 'package:design_system/tokens/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      primaryContainer: AppColors.primaryContainer,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.grey),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
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
