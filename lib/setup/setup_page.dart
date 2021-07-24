import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/game.dart';
import '../game/game_page.dart';
import '../partials/layout.dart';
import 'setup_list.dart';

class SetupPage extends StatelessWidget {
  SetupPage(this.name, this.playerCount, {Key? key}) : super(key: key) {
    game = Game.withPlayers(playerCount)..name = name;
  }

  final String name;
  final int playerCount;
  late final Game game;

  @override
  Widget build(BuildContext context) {
    return Layout(
        scaffoldKey: 'SetupPage',
        title: name,
        fabIcon: Icon(Icons.play_arrow),
        fabAction: () {
          Hive.box<Game>('games').add(game);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/game', ModalRoute.withName('/'),
              arguments: GamePageArgs(game, GameMode.PLAY));
        },
        child: SetupList(game.players!));
  }
}

class SetupPageArgs {
  const SetupPageArgs(this.name, this.playerCount);

  final int playerCount;
  final String name;
}
