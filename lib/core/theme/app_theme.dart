import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => _baseTheme(_lightColorScheme);
  static ThemeData get dark => _baseTheme(_darkColorScheme);

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final TextTheme textTheme = _textTheme(colorScheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleMedium,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface.withValues(alpha: 0.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displaySmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        height: 1.4,
        color: colorScheme.onSurface.withValues(alpha: 0.9),
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
    );
  }

  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF4D65FF),
  ).copyWith(
    primary: const Color(0xFF4D65FF),
    onPrimary: Colors.white,
    secondary: const Color(0xFF7BC6FF),
    onSecondary: const Color(0xFF00263E),
    tertiary: const Color(0xFF82DBD8),
    onTertiary: const Color(0xFF00312F),
    surface: const Color(0xFFF6F7FB),
    onSurface: const Color(0xFF1D2939),
    outline: const Color(0xFFD0D5DD),
    shadow: const Color(0x14000000),
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF4D65FF),
  ).copyWith(
    primary: const Color(0xFFBAC3FF),
    onPrimary: const Color(0xFF0F1C3F),
    secondary: const Color(0xFF98E0FF),
    onSecondary: const Color(0xFF003044),
    tertiary: const Color(0xFF7BDFF2),
    onTertiary: const Color(0xFF002432),
    surface: const Color(0xFF121826),
    onSurface: const Color(0xFFF1F5F9),
    outline: const Color(0xFF475467),
    shadow: const Color(0x66000000),
  );
}
