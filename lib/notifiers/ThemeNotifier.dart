import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(bool isDark) : _isDark = isDark;

  bool _isDark;

  bool get isDark => _isDark;

  set isDark(bool isDark) {
    _isDark = isDark;
    notifyListeners();
  }
}
