import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scored_/notifiers/ThemeNotifier.dart';
import 'package:scored_/pages/HistoryPage.dart';
import 'package:scored_/theme.dart';
import 'package:scored_/utils/preferences.dart';

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
          title: 'Scored!',
          theme: themeNotifier.isDark ? scoredThemeDark : scoredTheme,
          home: HistoryPage(),
        );
      }
    );
  }
}
