import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scored/setup/setup_app_bar.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/game.dart';
import '../game/game_page.dart';
import '../partials/layout.dart';
import 'setup_list.dart';

class SetupPage extends StatefulWidget {
  SetupPage({Key? key})
      : game = Game.withPlayers(1),
        super(key: key);

  const SetupPage.restart(this.game, {Key? key}) : super(key: key);

  static const route = '/setup';

  final Game game;

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  List<Pair<TextInputState, TextInputState>> inputStates = [];

  @override
  void initState() {
    super.initState();
    inputStates = List.generate(widget.game.players?.length ?? 1,
        (_) => Pair(TextInputState(), TextInputState()));
  }

  void _addPlayer() {
    setState(() {
      widget.game.addPlayer();
      inputStates.add(Pair(TextInputState(), TextInputState()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        scaffoldKey: 'SetupPage',
        appBar: SetupAppBar(
            _addPlayer, (String name) => widget.game.name = name,
            name: widget.game.name ?? ''),
        fabIcon: const Icon(Icons.play_arrow),
        fabAction: () {
          final box = Hive.box<Game>('games');
          if (widget.game.key == null || !box.containsKey(widget.game.key)) {
            box.add(widget.game);
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              GamePage.route, ModalRoute.withName('/'),
              arguments: GamePageArgs(widget.game, GameMode.play));
        },
        child: SetupList(widget.game.players!, inputStates));
  }
}

class SetupPageArgs {
  SetupPageArgs({this.game});

  Game? game;
}
