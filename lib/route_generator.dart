import 'package:flutter/material.dart';
import 'package:scored/generated/l10n.dart';

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
          final s = S.of(context);

          return Layout(
              child: Center(
                  child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Text('404', style: titleStyle),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 8),
                child: Text(
                  s.notFoundBody,
                  style: subtitleStyle,
                )),
            TextButton(
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName('/')),
                child: Text(s.notFoundButton.toUpperCase()))
          ])));
        });
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HistoryPage());
      case GamePage.route:
        if (settings.arguments == null) {
          return null;
        }
        final args = settings.arguments as GamePageArgs;
        return MaterialPageRoute(
            settings: settings, builder: (_) => GamePage(args.game, args.mode));
      case SetupPage.route:
        if (settings.arguments == null) {
          return null;
        }
        final args = settings.arguments as SetupPageArgs;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              if (args.existingGame != null) {
                return SetupPage.restart(args.existingGame!);
              } else {
                return SetupPage(args.name!, args.playerCount!);
              }
            });
      default:
        return _notFound(settings);
    }
  }
}
