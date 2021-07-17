import 'dart:developer';

import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Text("MyTest"), onWillPop: _saveGame);
  }

  Future<bool> _saveGame() async {
    log('Saving Game');
    return true;
  }
}

class GamePageArgs {
  const GamePageArgs(this.players, this.mode);

  final List<String> players;
  final GamePageMode mode;
}

enum GamePageMode { VIEW, PLAY }
