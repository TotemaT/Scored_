import 'package:flutter/material.dart';
import 'package:scored/setup/text_input_state.dart';
import 'package:scored/utils/pair.dart';

import '../domain/player.dart';
import 'setup_item.dart';

class SetupList extends StatelessWidget {
  const SetupList(this.players, this.inputStates, this.onRemovePlayer,
      {Key? key})
      : super(key: key);

  final Function(int) onRemovePlayer;
  final List<Pair<TextInputState, TextInputState>> inputStates;
  final List<Player> players;

  Widget _playerItem(BuildContext context, int idx) {
    final player = players[idx];
    final inputState = inputStates[idx];

    final playerItem = SetupItem(
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

    if (players.length == 1) {
      return playerItem;
    }

    return Dismissible(
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) => onRemovePlayer(players.indexOf(player)),
        key: Key("player-${player.index}"),
        child: playerItem);
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
        itemBuilder: (_, int idx) => _playerItem(context, idx),
        itemCount: players.length);
    return list;
  }
}
