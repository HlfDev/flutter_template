import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class DSTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: DSColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      elevation: DSSizes.elevationS,
      backgroundColor: DSColors.primary,
      foregroundColor: DSColors.onPrimary,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: DSColors.onPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DSColors.primary,
        foregroundColor: DSColors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DSSizes.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: DSSizes.sizeS,
          horizontal: DSSizes.sizeM,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusM),
        borderSide: const BorderSide(color: DSColors.neutral400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusM),
        borderSide: const BorderSide(color: DSColors.primary, width: 2.0),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: DSSizes.elevationS,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusL),
      ),
      margin: const EdgeInsets.all(DSSizes.sizeS),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: DSColors.primary,
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      elevation: DSSizes.elevationS,
      backgroundColor: DSColors.neutral900,
      foregroundColor: DSColors.onBackgroundDark,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: DSColors.onBackgroundDark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DSColors.secondary,
        foregroundColor: DSColors.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DSSizes.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: DSSizes.sizeS,
          horizontal: DSSizes.sizeM,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusM),
        borderSide: const BorderSide(color: DSColors.neutral600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusM),
        borderSide: const BorderSide(color: DSColors.secondary, width: 2.0),
      ),
    ),
    cardTheme: CardThemeData(
      color: DSColors.surfaceDark,
      elevation: DSSizes.elevationS,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSSizes.radiusL),
      ),
      margin: const EdgeInsets.all(DSSizes.sizeS),
    ),
  );

  static final TextTheme _textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: DSSizes.fontDisplay,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: DSSizes.fontHeadline,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: DSSizes.fontTitle,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: DSSizes.fontXL,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: DSSizes.fontL,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: DSSizes.fontM,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: DSSizes.fontS,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: DSSizes.fontM,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: DSSizes.fontXS,
      fontWeight: FontWeight.normal,
    ),
  );
}
