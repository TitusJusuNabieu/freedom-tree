import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Freedom Tree brand palette, pulled from the live site's CSS custom
/// properties (--ft-orange etc). See docs/form-field-mapping.md in the repo
/// root for the full source-of-truth notes.
class FtColors {
  static const orange = Color(0xFFEE5B4D);
  static const darkOrange = Color(0xFFC62F14);
  static const greyDark = Color(0xFF374655);
  static const greyDarker = Color(0xFF101419);
  static const greyMedium = Color(0xFF6B859E);
  static const greyLight = Color(0xFF9CADBF);
  static const green = Color(0xFF90B6AD);
  static const yellow = Color(0xFFF6B94F);
}

ThemeData buildFtTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: FtColors.orange,
    brightness: Brightness.light,
  ).copyWith(
    primary: FtColors.orange,
    onPrimary: Colors.white,
    secondary: FtColors.green,
    error: FtColors.darkOrange,
    surface: Colors.white,
    onSurface: FtColors.greyDarker,
    outline: FtColors.greyLight,
  );

  final baseTextTheme = GoogleFonts.openSansTextTheme();
  final headingTextTheme = GoogleFonts.zillaSlabTextTheme();

  final textTheme = baseTextTheme.copyWith(
    headlineLarge: headingTextTheme.headlineLarge?.copyWith(color: FtColors.greyDarker, fontWeight: FontWeight.w600),
    headlineMedium: headingTextTheme.headlineMedium?.copyWith(color: FtColors.greyDarker, fontWeight: FontWeight.w600),
    titleLarge: headingTextTheme.titleLarge?.copyWith(color: FtColors.greyDarker, fontWeight: FontWeight.w600),
    titleMedium: headingTextTheme.titleMedium?.copyWith(color: FtColors.greyDarker, fontWeight: FontWeight.w600),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: FtColors.greyDark),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: FtColors.greyDark),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: FtColors.greyDarker,
      elevation: 0,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: FtColors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: FtColors.greyLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: FtColors.orange, width: 2),
      ),
      labelStyle: const TextStyle(color: FtColors.greyDark),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return FtColors.orange;
        return Colors.white;
      }),
    ),
  );
}
