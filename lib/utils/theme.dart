import 'package:flutter/material.dart';

final ThemeData scoredTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.green,
        secondary: Colors.orange,
        brightness: Brightness.light),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.green));

final ThemeData scoredThemeDark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  checkboxTheme:
      CheckboxThemeData(fillColor: MaterialStateColor.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.orange;
    }
    return ThemeData.dark().hintColor;
  })),
  colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.green,
      secondary: Colors.orange,
      brightness: Brightness.dark),
);
