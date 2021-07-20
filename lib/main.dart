import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scored/domain/color.adapter.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/domain/player.dart';
import 'package:scored/notifiers/theme_notifier.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/history/history_page.dart';
import 'package:scored/theme.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/utils/preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool darkMode = await isDarkMode();

  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(GameStateAdapter());
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(ColorAdapter());
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
        home: HistoryPage(),
        routes: <String, WidgetBuilder>{
          '/game': (BuildContext context) => GamePage(),
          '/setup': (BuildContext context) => SetupPage(),
        },
      );
    });
  }
}
