import 'package:flutter/material.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/player.dart';
import 'setup_item.dart';

class SetupList extends StatelessWidget {
  SetupList(this.players)
      : inputStates = List.generate(players.length, (_) => TextInputState());

  final List<Player> players;
  final List<TextInputState> inputStates;

  SetupItem _playerItem(BuildContext context, int idx) {
    final player = players[idx];
    final inputState = inputStates[idx];

    return SetupItem(
        last: players.indexOf(player) == players.length - 1,
        onChangeName: (String name) => player.name = name,
        onSelectColor: (Color color) => player.color = color,
        player: player,
        inputState: inputState,
        onSubmitted: () {
          if (idx < inputStates.length - 1) {
            FocusScope.of(context).requestFocus(inputStates[idx + 1].focusNode);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, int idx) => _playerItem(context, idx),
        itemCount: players.length);
  }
}
