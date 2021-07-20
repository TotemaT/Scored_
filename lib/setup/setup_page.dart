import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/partials/layout.dart';
import 'package:scored/setup/setup_list.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SetupPageArgs;
    final game = Game.named(args.name, args.playerCount);

    return Layout(
        scaffoldKey: 'SetupPage',
        title: args.name,
        fabIcon: Icon(Icons.play_arrow),
        fabAction: () {
          Hive.box<Game>('games').add(game);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/game', ModalRoute.withName('/'),
              arguments: GamePageArgs(game, GamePageMode.PLAY));
        },
        child: SetupList(game.players));
  }
}

class SetupPageArgs {
  const SetupPageArgs(this.name, this.playerCount);

  final int playerCount;
  final String name;
}
