import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject {
  Player(this.index, this.color);

  Player.copy(Player player)
      : name = player.name,
        color = player.color,
        index = player.index;

  @HiveField(0)
  Color color;

  @HiveField(3)
  int index;

  @HiveField(1)
  String name = '';

  @HiveField(2)
  int score = 0;

  @override
  String toString() => '''
      name: $name,
      score: $score,
      color: $color
      ''';

  String toDetail() => '$name ($score)';
}
