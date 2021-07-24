import 'package:flutter/material.dart';

import '../domain/player.dart';
import 'setup_item.dart';

class SetupList extends StatelessWidget {
  SetupList(this.players);

  final List<Player> players;

  SetupItem _playerItem(Player player) {
    return SetupItem(
      last: players.indexOf(player) == players.length - 1,
      onChangeName: (String name) => player.name = name,
      onSelectColor: (Color color) => player.color = color,
      player: player,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, int idx) => _playerItem(players[idx]),
        itemCount: players.length
      );
  }
}
