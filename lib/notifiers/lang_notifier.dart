import 'package:flutter/material.dart';

class LangNotifier extends ChangeNotifier {
  LangNotifier(Locale locale) : _locale = locale;

  Locale _locale;

  Locale get locale => _locale;

  set locale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
