import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'player.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  Game();

  Game.copy(Game game) {
    name = game.name;
    players = HiveList(Hive.box<Player>('players'),
        objects: game.players?.map((player) {
          final playerBox = Hive.box<Player>('players');

          final playerCopy = Player.copy(player);
          playerBox.add(playerCopy);
          return playerCopy;
        }).toList());
  }

  Game.withPlayers(int playerCount) {
    players = HiveList(playerBox,
        objects: List.generate(playerCount, (idx) {
          final player = Player(idx, colors[idx % colors.length]);
          playerBox.add(player);
          return player;
        }).toList());
  }

  final colors = List.from(Colors.primaries)
    ..addAll(Colors.accents)
    ..shuffle();

  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  String? name;

  final playerBox = Hive.box<Player>('players');
  @HiveField(2)
  HiveList<Player>? players;

  @override
  String toString() {
    return "[$name]:[$date] - $players";
  }

  void addPlayer() {
    players ??= HiveList(playerBox);

    final idx = players!.length;
    final player = Player(idx, colors[idx % colors.length]);
    playerBox.add(player);
    players!.add(player);
  }
}

enum GameMode { view, play }
