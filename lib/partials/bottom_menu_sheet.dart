import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/notifiers/lang_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notifiers/theme_notifier.dart';
import '../utils/preferences.dart';

class BottomMenuSheet extends StatelessWidget {
  BottomMenuSheet({Key? key}) : super(key: key);

  final _langs = [
    _LocaleToLabel('de', 'Deutsch'),
    _LocaleToLabel('en', 'English'),
    _LocaleToLabel('fr', 'Français'),
  ];

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

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      CheckboxListTile(
        title: Text(S.of(context).darkMode),
        value: themeNotifier.isDark,
        onChanged: (bool? value) => _setDarkMode(value, themeNotifier),
      ),
      ListTile(
        title: Text(S.of(context).language),
        trailing: DropdownButton<String>(
          items: _langs
              .map((lang) =>
                  DropdownMenuItem(value: lang.code, child: Text(lang.label)))
              .toList(),
          value: langNotifier.locale.languageCode,
          onChanged: (String? lang) => _setLang(lang, langNotifier),
        ),
      ),
      AboutListTile(
          applicationIcon: Image.asset('assets/scored_logo.png', height: 48,),
          applicationName: 'Scored!',
          applicationVersion: '2.1.3',
          applicationLegalese: '\u{a9} 2019 Matteo Taroli',
          aboutBoxChildren: [_aboutChildren(context)])
    ]);
  }

  Widget _aboutChildren(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    final linkStyle = textStyle?.copyWith(
        decorationStyle: TextDecorationStyle.solid,
        decoration: TextDecoration.underline,
        color: Theme.of(context).colorScheme.secondary);

    return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
            style: textStyle,
            text: 'Scored! is an open-source application made with Flutter by ',
          ),
          _LinkTextSpan(
            text: 'Matteo Taroli',
            style: linkStyle,
            url: 'https://tteo.be',
          ),
          TextSpan(
            style: textStyle,
            text: '.\n\nThe source code can be found in the ',
          ),
          _LinkTextSpan(
            text: 'Scored! Gitlab repository',
            style: linkStyle,
            url: 'https://gitlab.com/scored/scored.gitlab.io',
          ),
          TextSpan(
            style: textStyle,
            text: '.',
          ),
        ])));
  }
}

// cf https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/gallery/about.dart
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle? style, String? url, String? text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: url == null
                ? null
                : (TapGestureRecognizer()
                  ..onTap = () => launch(url, forceWebView: false)));
}

class _LocaleToLabel {
  _LocaleToLabel(this.code, this.label);
  String code;
  String label;
}
