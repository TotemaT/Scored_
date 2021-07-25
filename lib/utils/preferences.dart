import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scored/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

const localeKey = 'scored.locale';
const darkModeKey = 'scored.dark_mode';

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString(localeKey);
  return _getLocale(lang);
}

void setLocale(String locale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(localeKey, locale);
}

Future<bool> isDarkMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(darkModeKey) ?? false;
}

void setIsDarkMode(bool isDarkMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(darkModeKey, isDarkMode);
}

Locale _getLocale(String? lang) {
  Locale locale = lang != null ? Locale(lang, '') : Locale(Intl.systemLocale);

  if (!S.delegate.supportedLocales.contains(locale)) {
    locale = const Locale('en');
  }

  return locale;
}
