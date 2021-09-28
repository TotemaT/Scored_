import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scored/notifiers/lang_notifier.dart';

import 'domain/color.adapter.dart';
import 'domain/game.dart';
import 'domain/player.dart';
import 'generated/l10n.dart';
import 'notifiers/theme_notifier.dart';
import 'route_generator.dart';
import 'theme.dart';
import 'utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool darkMode = await isDarkMode();
  Locale locale = await getLocale();

  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox<Player>('players');
  await Hive.openBox<Game>('games', keyComparator: (a, b) {
    return b - a;
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkMode)),
      ChangeNotifierProvider<LangNotifier>(create: (_) => LangNotifier(locale))
    ],
    child: const ScoredApp(),
  ));
}

class ScoredApp extends StatelessWidget {
  const ScoredApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, LangNotifier>(
        builder: (_, themeNotifier, langNotifier, __) {
      return MaterialApp(
        locale: langNotifier.locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: themeNotifier.isDark ? scoredThemeDark : scoredTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      );
    });
  }
}
