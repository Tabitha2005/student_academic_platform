import 'package:flutter/material.dart';

class ALUTheme {
  static const Color primaryDark = Color(0xFF1A2B4A);
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color accentYellow = Color(0xFFFFC700);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color warningRed = Color(0xFFFF4444);
  static const Color textDark = Color(0xFF1A2B4A);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color dividerGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF2C3E50);
  static const Color mediumGray = Color(0xFF7F8C8D);
  static const Color lightGray = Color(0xFFBDC3C7);

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: ColorScheme.light(
        primary: primaryDark,
        secondary: accentYellow,
        surface: cardWhite,
        error: warningRed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryDark,
        foregroundColor: textWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryDark,
        selectedItemColor: accentYellow,
        unselectedItemColor: textWhite.withValues(alpha: 0.6),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentYellow,
        foregroundColor: primaryDark,
        elevation: 4,
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentYellow,
          foregroundColor: primaryDark,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentYellow,
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentYellow, width: 2),
        ),
        labelStyle: TextStyle(color: textDark),
        hintStyle: TextStyle(color: textDark.withValues(alpha: 0.6)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textWhite,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: textWhite,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: textDark, fontSize: 16),
        bodyMedium: TextStyle(color: textDark, fontSize: 14),
        bodySmall: TextStyle(
          color: textDark.withValues(alpha: 0.7),
          fontSize: 12,
        ),
      ),
    );
  }
}
