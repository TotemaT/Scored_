import 'package:flutter/material.dart';

final ThemeData scoredTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(secondary: Colors.orange),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.green));

final ThemeData scoredThemeDark = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.orange),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.green));
