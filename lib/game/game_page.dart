import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/partials/layout.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GamePageArgs;
    final game = args.game;
    game.state = GameState.RUNNING;
    return WillPopScope(
        child: Layout(
          child: Text(game.toString()),
        ),
        onWillPop: () => _saveGame(game));
  }

  Future<bool> _saveGame(Game game) async {
    log('Saving Game');
    game.state = GameState.SAVED;
    return true;
  }
}

class GamePageArgs {
  const GamePageArgs(this.game, this.mode);

  final Game game;
  final GamePageMode mode;
}

enum GamePageMode { VIEW, PLAY }
