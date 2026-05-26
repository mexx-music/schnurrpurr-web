import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF1A1008);
  static const surface = Color(0xFF261A0E);
  static const surfaceVariant = Color(0xFF332211);
  static const primary = Color(0xFFE8572A);
  static const gold = Color(0xFFC9A44A);
  static const textPrimary = Color(0xFFF5EDD8);
  static const textSecondary = Color(0xFFBDAE96);
  static const divider = Color(0xFF3D2A18);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.gold,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onPrimary: Colors.white,
    ),
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 72,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      displayMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
      displaySmall: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: AppColors.gold,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 3,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 18,
        height: 1.7,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 16,
        height: 1.6,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.gold,
        side: const BorderSide(color: AppColors.gold, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    dividerColor: AppColors.divider,
    useMaterial3: true,
  );
}
