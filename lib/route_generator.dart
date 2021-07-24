import 'package:flutter/material.dart';

import 'game/game_page.dart';
import 'history/history_page.dart';
import 'partials/layout.dart';
import 'setup/setup_page.dart';

class RouteGenerator {
  static _notFound(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final titleStyle = Theme.of(context).textTheme.headline4;
          final subtitleStyle = Theme.of(context).textTheme.subtitle1;

          return Layout(
              child: Center(
                  child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 160),
              child: Text('404', style: titleStyle),
            ),
            Padding(
                padding: EdgeInsets.only(top: 48, bottom: 8),
                child: Text(
                  'This page doesn\'t exists... Maybe try to ',
                  style: subtitleStyle,
                )),
            TextButton(
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName('/')),
                child: Text('Go Back Home'))
          ])));
        });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => HistoryPage());
      case '/game':
        final args = settings.arguments as GamePageArgs;
        return MaterialPageRoute(
            settings: settings, builder: (_) => GamePage(args.game, args.mode));
      case '/setup':
        final args = settings.arguments as SetupPageArgs;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SetupPage(args.name, args.playerCount));
      default:
        return _notFound(settings);
    }
  }
}
