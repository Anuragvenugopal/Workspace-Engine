import 'package:flutter/material.dart';

enum ProfileType { personal, work, corporate, creative }

class AppTheme {
  AppTheme._();

  // Color Palettes
  static const Color _corporatePrimary = Color(0xFF1A1A2E);
  static const Color _corporateAccent = Color(0xFF16213E);
  static const Color _corporateSurface = Color(0xFFF5F5F5);

  static const Color _creativePrimary = Color(0xFF7C3AED);
  static const Color _creativeAccent = Color(0xFFEC4899);
  static const Color _creativeSurface = Color(0xFFFDF4FF);

  static const Color _personalPrimary = Color(0xFF0EA5E9);
  static const Color _personalAccent = Color(0xFF06B6D4);

  static const Color _workPrimary = Color(0xFF059669);
  static const Color _workAccent = Color(0xFF10B981);

  static ThemeData getTheme(ProfileType profileType) {
    switch (profileType) {
      case ProfileType.corporate:
        return _corporateTheme();
      case ProfileType.creative:
        return _creativeTheme();
      case ProfileType.work:
        return _workTheme();
      case ProfileType.personal:
        return _personalTheme();
    }
  }

  static ThemeData _corporateTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _corporatePrimary,
        brightness: Brightness.light,
        primary: _corporatePrimary,
        secondary: _corporateAccent,
        surface: _corporateSurface,
      ),
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
        margin: EdgeInsets.all(4),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _corporatePrimary, width: 2),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: _corporatePrimary,
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _corporatePrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: _corporatePrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData _creativeTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _creativePrimary,
        brightness: Brightness.light,
        primary: _creativePrimary,
        secondary: _creativeAccent,
        surface: _creativeSurface,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        shadowColor: _creativePrimary.withAlpha(77),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _creativePrimary, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: _creativePrimary,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _creativePrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: _creativeAccent,
        foregroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }

  static ThemeData _personalTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _personalPrimary,
        brightness: Brightness.light,
        primary: _personalPrimary,
        secondary: _personalAccent,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _personalPrimary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: _personalPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _personalPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: _personalPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData _workTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _workPrimary,
        brightness: Brightness.light,
        primary: _workPrimary,
        secondary: _workAccent,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _workPrimary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: _workPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _workPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: _workPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Profile Colors (for chips, avatars, markers)
  static Color getProfileColor(ProfileType type) {
    switch (type) {
      case ProfileType.corporate:
        return _corporatePrimary;
      case ProfileType.creative:
        return _creativePrimary;
      case ProfileType.personal:
        return _personalPrimary;
      case ProfileType.work:
        return _workPrimary;
    }
  }

  static Color getProfileAccent(ProfileType type) {
    switch (type) {
      case ProfileType.corporate:
        return _corporateAccent;
      case ProfileType.creative:
        return _creativeAccent;
      case ProfileType.personal:
        return _personalAccent;
      case ProfileType.work:
        return _workAccent;
    }
  }

  static IconData getProfileIcon(ProfileType type) {
    switch (type) {
      case ProfileType.corporate:
        return Icons.business_rounded;
      case ProfileType.creative:
        return Icons.palette_rounded;
      case ProfileType.personal:
        return Icons.person_rounded;
      case ProfileType.work:
        return Icons.work_rounded;
    }
  }
}
