import 'package:flutter/material.dart';

import '../domain/player.dart';
import 'setup_item.dart';
import 'text_input_state.dart';

class SetupList extends StatelessWidget {
  SetupList(this.players) {
    _textInputsStates = List.generate(players.length, (_) => TextInputState());
  }

  final List<Player> players;

  late final List<TextInputState> _textInputsStates;

  SetupItem _playerItem(int idx) {
    final TextInputState state = _textInputsStates[idx];
    final Player player = players[idx];

    return SetupItem(
      controller: state.controller,
      focusNode: state.focusNode,
      last: idx == players.length - 1,
      onChangeName: (String name) => player.name = name,
      onSelectColor: (Color color) => player.color = color,
      player: player,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext ctx, int idx) => const SizedBox(
              height: 8,
            ),
        itemBuilder: (BuildContext ctx, int idx) => _playerItem(idx),
        itemCount: players.length);
  }
}
