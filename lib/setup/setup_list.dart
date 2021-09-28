import 'package:flutter/material.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/player.dart';
import 'setup_item.dart';

class SetupList extends StatelessWidget {
  SetupList(this.players, {Key? key})
      : inputStates = List.generate(players.length,
            (_) => Pair(TextInputState(), TextInputState(initialValue: '0'))),
        super(key: key);

  final List<Player> players;
  final List<Pair<TextInputState, TextInputState>> inputStates;

  SetupItem _playerItem(BuildContext context, int idx) {
    final player = players[idx];
    final inputState = inputStates[idx];

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
    return ListView.builder(
        itemBuilder: (_, int idx) => _playerItem(context, idx),
        itemCount: players.length);
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}
