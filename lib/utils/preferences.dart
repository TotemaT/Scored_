import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const localeKey = 'scored.locale';
const darkModeKey = 'scored.dark_mode';

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? locale = prefs.getString(localeKey);
  return locale != null ? Locale(locale, '') : Locale(Platform.localeName);
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
