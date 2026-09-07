import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // ─────────────────────────────────────────────
    // COLOR SYSTEM
    // ─────────────────────────────────────────────
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.petrol,
      onPrimary: Colors.white,

      secondary: AppColors.mustard,
      onSecondary: AppColors.ink,

      error: AppColors.clayberry,
      onError: Colors.white,

      surface: AppColors.cardWhite,
      onSurface: AppColors.ink,

      outline: AppColors.line,
    ),

    // Screen background
    scaffoldBackgroundColor: AppColors.paper,

    // ─────────────────────────────────────────────
    // TYPOGRAPHY
    // ─────────────────────────────────────────────
    textTheme: const TextTheme(
      // SERIF
      // Used for large/editorial text

      displayLarge: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),

      displayMedium: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),

      displaySmall: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      headlineLarge: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 35,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      ),

      headlineMedium: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      headlineSmall: TextStyle(
        fontFamily: 'CormorantGaramond',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      // SANS-SERIF
      // Used for UI and normal text
      titleLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      titleSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.ink,
      ),

      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.inkFaint,
      ),

      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.inkFaint,
      ),

      labelLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),

      labelMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      ),

      labelSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.inkFaint,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.paper,
      elevation: 0,
      surfaceTintColor: Colors.transparent,//App bar color is transparent when page is scrolled
      // centerTitle: true,
    ),
  );
}
