import 'package:flutter/material.dart';

class GlobalThemData {
  static const Color _lightFocusColor = Colors.black;
  static const Color _darkFocusColor = Colors.white;
  static final ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static final ThemeData darkThemeData =
      themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.black), // Main heading color
        displayMedium: TextStyle(color: Colors.black), // Sub-heading color
        bodyLarge: TextStyle(color: Colors.black), // Body text color
        bodyMedium: TextStyle(color: Colors.black), // Another body text color
        bodySmall:
            TextStyle(color: const Color(0x00797979)), // Caption text color
        labelLarge: TextStyle(color: Colors.white), // Button text color
      ),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      splashColor: Colors.transparent, // remove wave effect on button click
      useMaterial3: true,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Color.fromARGB(255, 204, 37, 8),
    onError: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFF4D1F7C),
    surface: Color(0xFF1F1929),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
