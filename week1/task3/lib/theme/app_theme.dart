import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF1A1A1A);
  static const primaryDark = Color(0xFF000000);
  static const accent = Color(0xFFE55D5D);
  static const bg = Color(0xFFF0F1F3);
  static const surface = Colors.white;
  static const err = Color(0xFFE55D5D);
  static const txtPrimary = Color(0xFF1A1A1A);
  static const txtSecondary = Color(0xFF8E8E93);
  static const divider = Color(0xFFE5E5EA);
}

class AppTypography {
  AppTypography._();
  static const h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.txtPrimary, letterSpacing: -0.5);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.txtPrimary, letterSpacing: -0.3);
  static const sub = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.txtPrimary);
  static const body = TextStyle(fontSize: 14, color: AppColors.txtPrimary, height: 1.5);
  static const cap = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.txtSecondary);
  static const btn = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5);
}

class Gaps {
  Gaps._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary, secondary: AppColors.accent,
        surface: AppColors.surface, error: AppColors.err,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.h2,
        iconTheme: IconThemeData(color: AppColors.txtPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.md, vertical: Gaps.md),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.err),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.txtSecondary),
      ),
    );
  }
}
