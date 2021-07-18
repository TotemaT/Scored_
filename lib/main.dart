import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scored/notifiers/theme_notifier.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/history/history_page.dart';
import 'package:scored/theme.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool darkMode = await isDarkMode();

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
      }
    );
  }
}
