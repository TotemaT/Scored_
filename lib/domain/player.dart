import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player.g.dart';

final List<Color> colors = Colors.primaries;
final Random rand = Random();

@HiveType(typeId: 1)
class Player {
  Player();

  Player.copy(Player player) {
    name = player.name;
    color = player.color;
  }

  @HiveField(0)
  Color color = colors[rand.nextInt(colors.length)];
  @HiveField(1)
  String? name;
  @HiveField(2)
  int score = 0;

  String toDetail() => '${name ?? ''} ($score)';

  @override
  String toString() => '''
      name: $name,
      score: $score,
      color: $color
      ''';
}
