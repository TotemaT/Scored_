import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scored_/notifiers/ThemeNotifier.dart';
import 'package:scored_/utils/preferences.dart';

class BottomMenuSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CheckboxListTile(
          title: Text("Dark mode"),
          value: themeNotifier.isDark,
          onChanged: (bool? value) => _setDarkMode(value, themeNotifier),
        ),
      ],
    );
  }

  void _setDarkMode(bool? isDarkMode, ThemeNotifier themeNotifier) {
    isDarkMode = isDarkMode ?? false;
    setIsDarkMode(isDarkMode);
    themeNotifier.isDark = isDarkMode;
  }
}
