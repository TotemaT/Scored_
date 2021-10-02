import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/game.dart';
import '../game/game_page.dart';
import '../partials/layout.dart';
import 'setup_list.dart';

class SetupPage extends StatelessWidget {
  SetupPage(this.name, playerCount, {Key? key}) : super(key: key) {
    game = Game.withPlayers(playerCount)..name = name;
  }

  SetupPage.restart(this.game, {Key? key})
      : name = game.name ?? '',
        super(key: key);

  static const route = '/setup';

  final String name;
  late final Game game;

  @override
  Widget build(BuildContext context) {
    return Layout(
        scaffoldKey: 'SetupPage',
        title: name,
        fabIcon: const Icon(Icons.play_arrow),
        fabAction: () {
          Hive.box<Game>('games').add(game);
          Navigator.of(context).pushNamedAndRemoveUntil(
              GamePage.route, ModalRoute.withName('/'),
              arguments: GamePageArgs(game, GameMode.play));
        },
        child: SetupList(game.players!));
  }
}

class SetupPageArgs {
  SetupPageArgs(this.name, this.playerCount);
  SetupPageArgs.restart(this.existingGame);

  Game? existingGame;
  int? playerCount;
  String? name;
}
