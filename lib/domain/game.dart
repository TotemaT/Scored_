import 'package:hive/hive.dart';
import 'package:scored/domain/player.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  Game()
      : name = 'Unnamed Party',
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

  @HiveField(3)
  GameState state = GameState.SETUP;

  @override
  String toString() {
    return "[$name]:[$date] - $players";
  }
}

@HiveType(typeId: 1)
enum GameState {
  @HiveField(0)
  SETUP,
  @HiveField(1)
  RUNNING,
  @HiveField(2)
  PAUSED,
  @HiveField(3)
  SAVED
}

enum GameMode { VIEW, PLAY }
