import 'package:hive/hive.dart';
import 'package:scored/domain/player.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  Game()
      : name = '',
        players = [];

  Game.named(this.name, int playerCount) {
    players = List.generate(playerCount, (_) => Player());
  }

  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  String name;

  @HiveField(2)
  late List<Player> players;

  @override
  String toString() {
    return "[$name]:[$date] - $players";
  }
}

enum GameMode { VIEW, PLAY }
