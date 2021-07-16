import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDark;

  ThemeNotifier(bool isDark) : _isDark = isDark;

  bool get isDark => _isDark;

  set isDark(bool isDark) {
    _isDark = isDark;
    notifyListeners();
  }
}
