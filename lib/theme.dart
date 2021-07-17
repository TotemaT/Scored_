import 'package:flutter/material.dart';

final ThemeData scoredTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light,
  accentColor: Colors.orange,
  primaryTextTheme: Typography.material2018().black
);

final ThemeData scoredThemeDark = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
  accentColor: Colors.orange,
  primaryTextTheme: Typography.material2018().white
);
