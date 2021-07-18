import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/partials/layout.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GamePageArgs;
    return WillPopScope(child: Layout(child: Text(args.game.toString()),), onWillPop: _saveGame);
  }

  Future<bool> _saveGame() async {
    log('Saving Game');
    return true;
  }
}

class GamePageArgs {
  const GamePageArgs(this.game, this.mode);

  final Game game;
  final GamePageMode mode;
}

enum GamePageMode { VIEW, PLAY }
