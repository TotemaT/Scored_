import 'dart:math';

import 'package:flutter/material.dart';

final List<Color> colors = Colors.primaries;
final Random rand = Random();

class Player {
  Color color = colors[rand.nextInt(colors.length)];
  String? name;
  int score = 0;

  @override
  String toString() => '''
      name: $name,
      score: $score,
      color: $color
      ''';
}
