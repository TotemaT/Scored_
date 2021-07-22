import 'package:hive/hive.dart';
import 'package:scored/domain/player.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  Game();

  Game.copy(Game game) {
    name = game.name;
    players = game.players.map((player) => Player.copy(player)).toList();
  }

  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  String? name;

  @HiveField(2)
  HiveList<Player>? hivePlayers;

  List<Player> players = [];

  @override
  String toString() {
    return "[$name]:[$date] - $hivePlayers";
  }
}

enum GameMode { VIEW, PLAY }
