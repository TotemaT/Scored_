import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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

  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox<Player>('players');
  await Hive.openBox<Game>('games', keyComparator: (a, b) {
    return b - a;
  });

  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(darkMode),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (_, ThemeNotifier themeNotifier, __) {
      return MaterialApp(
        localizationsDelegates: [
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
