import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/notifiers/lang_notifier.dart';

import '../notifiers/theme_notifier.dart';
import '../utils/preferences.dart';

class BottomMenuSheet extends StatelessWidget {
  void _setDarkMode(bool? isDarkMode, ThemeNotifier themeNotifier) {
    isDarkMode = isDarkMode ?? false;
    setIsDarkMode(isDarkMode);
    themeNotifier.isDark = isDarkMode;
  }

  void _setLang(String? lang, LangNotifier langNotifier) {
    lang = lang ?? 'en';
    setLocale(lang);
    langNotifier.locale = Locale(lang);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: false);
    final LangNotifier langNotifier =
        Provider.of<LangNotifier>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CheckboxListTile(
          title: Text(S.of(context).darkMode),
          value: themeNotifier.isDark,
          onChanged: (bool? value) => _setDarkMode(value, themeNotifier),
        ),
        ListTile(
          title: Text(S.of(context).language),
          trailing: DropdownButton<String>(
            items: _items(),
            value: langNotifier.locale.languageCode,
            onChanged: (String? lang) => _setLang(lang, langNotifier),
          ),
        ),
      ],
    );
  }

  _items() {
    final list = S.delegate.supportedLocales.map((Locale locale) {
      return DropdownMenuItem<String>(
        value: locale.languageCode,
        child: Text(_language(locale.languageCode)),
      );
    }).toList();
    return list;
  }

  String _language(String code) {
    switch (code) {
      case 'de':
        return 'Deutsch';
      case 'en':
        return 'English';
      case 'fr':
        return 'French';
      default:
        throw Exception('Unsupported locale : $code');
    }
  }
}
