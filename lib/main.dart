import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'domain/color.adapter.dart';
import 'domain/game.dart';
import 'domain/player.dart';
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

  await initializeDateFormatting('fr_FR', null);

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
        theme: themeNotifier.isDark ? scoredThemeDark : scoredTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      );
    });
  }
}
