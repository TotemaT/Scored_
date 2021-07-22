import 'package:hive/hive.dart';
import 'package:scored/domain/player.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  Game();

  Game.withPlayers(int playerCount) {
    final playerBox = Hive.box<Player>('players');
    players = HiveList(playerBox,
        objects: List.generate(playerCount, (player) {
          final player = Player();
          playerBox.add(player);
          return player;
        }).toList());
  }

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

  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  String? name;

  @HiveField(2)
  HiveList<Player>? players;

  @override
  String toString() {
    return "[$name]:[$date] - $players";
  }
}

enum GameMode { VIEW, PLAY }
