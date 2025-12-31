import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6200EE), // Premium Purple
      brightness: Brightness.light,
      surface: const Color(0xFFF8F9FA),
      onSurface: const Color(0xFF1A1A1A),
      primary: const Color(0xFF6200EE),
      onPrimary: Colors.white,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        color: const Color(0xFF1A1A1A),
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        color: const Color(0xFF4A4A4A),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFBB86FC),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
      onSurface: const Color(0xFFE0E0E0),
      primary: const Color(0xFFBB86FC),
      onPrimary: Colors.black,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        color: const Color(0xFFE0E0E0),
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        color: const Color(0xFFB0B0B0),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
  );
}
