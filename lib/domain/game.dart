import 'package:scored/domain/player.dart';

class Game {
  Game(this.name, int playerCount) {
    players = List.generate(playerCount, (_) => Player());
  }

  DateTime date = DateTime.now();
  String name;
  List<Player> players = [];

  @override
  String toString() {
    return "[$name]:[$date] - $players";
  }
}
