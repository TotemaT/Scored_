import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/theme_notifier.dart';
import '../utils/preferences.dart';

class BottomMenuSheet extends StatelessWidget {
  void _setDarkMode(bool? isDarkMode, ThemeNotifier themeNotifier) {
    isDarkMode = isDarkMode ?? false;
    setIsDarkMode(isDarkMode);
    themeNotifier.isDark = isDarkMode;
  }

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
}
