import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/domain/player.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/partials/layout.dart';
import 'package:scored/setup/setup_list.dart';

class SetupPage extends StatelessWidget {
  SetupPage(this.name, this.playerCount, {Key? key}) : super(key: key) {
    game = Game()
      ..name = name
      ..players = List.generate(playerCount, (_) => Player());
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
          final playerBox = Hive.box<Player>('players');
          game.players.forEach((player) {
            playerBox.add(player);
          });
          game.hivePlayers = HiveList(playerBox, objects: game.players);
          Hive.box<Game>('games').add(game);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/game', ModalRoute.withName('/'),
              arguments: GamePageArgs(game, GameMode.PLAY));
        },
        child: SetupList(game.players));
  }
}

class SetupPageArgs {
  const SetupPageArgs(this.name, this.playerCount);

  final int playerCount;
  final String name;
}
