import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(34, 40, 49, 1.0),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(34, 40, 49, 1.0),
  brightness: Brightness.dark,
);

final yellowColor = Color.fromRGBO(255, 211, 105, 1.0);

ThemeData buildThemeData(ColorScheme cs) {
  return ThemeData(
    colorScheme: cs,
    appBarTheme: AppBarTheme(
      backgroundColor: cs.surfaceContainerLow,
      foregroundColor: cs.onSurface,
    ),
    scaffoldBackgroundColor: cs.surface,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cs.surfaceContainerHighest,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
    ),
    textTheme: GoogleFonts.openSansTextTheme().apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    ),
  );
}
