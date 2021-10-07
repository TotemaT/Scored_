import 'package:flutter/material.dart';
import 'package:scored/setup/text_input_state.dart';
import 'package:scored/utils/pair.dart';

import '../domain/player.dart';
import 'setup_item.dart';

class SetupList extends StatelessWidget {
  const SetupList(this.players, this.inputStates, {Key? key}) : super(key: key);

  final List<Pair<TextInputState, TextInputState>> inputStates;
  final List<Player> players;

  SetupItem _playerItem(BuildContext context, int idx) {
    final player = players[idx];
    final inputState = inputStates[idx];

    if (idx == inputStates.length - 1) {
      inputState.first.focusNode.requestFocus();
    }

    return SetupItem(
        last: players.indexOf(player) == players.length - 1,
        onChangeName: (String name) => player.name = name,
        onChangeScore: (int score) => player.score = score,
        onSelectColor: (Color color) => player.color = color,
        player: player,
        nameInputState: inputState.first,
        scoreInputState: inputState.second,
        onSubmitted: () {
          if (idx < inputStates.length - 1) {
            FocusScope.of(context)
                .requestFocus(inputStates[idx + 1].first.focusNode);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return ListView.builder(
        itemBuilder: (_, int idx) => _playerItem(context, idx),
        itemCount: players.length);
  }
}
