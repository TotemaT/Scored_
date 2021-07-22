import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/domain/player.dart';
import 'package:scored/game/game_page.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.game, {Key? key}) : super(key: key);

  final Game game;

  String _playersDetails() {
    final players = game.players;
    players.sort((Player a, Player b) {
      final diff = b.score - a.score;
      return diff != 0 ? diff : (a.name ?? '').compareTo(b.name ?? '');
    });
    return players.map((p) => p.toDetail()).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ListTile(
        title: Text(game.name ?? ''),
        trailing: Text(game.date.toReadable(),
            style: TextStyle(color: Theme.of(context).hintColor)),
        subtitle: Text(
          _playersDetails(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/game', ModalRoute.withName('/'),
              arguments: GamePageArgs(game, GameMode.VIEW));
        },
      ),
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.highlight_remove,
          color: Colors.red,
          onTap: () => game.delete(),
        )
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Continue',
          icon: Icons.play_arrow,
          color: Colors.blue,
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/game', ModalRoute.withName('/'),
                arguments: GamePageArgs(game, GameMode.PLAY));
          },
        ),
        IconSlideAction(
          caption: 'Restart',
          icon: Icons.replay,
          color: Colors.green,
          onTap: () {
            Game newGame = Game.copy(game);
            Hive.box<Game>('games').add(newGame);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/game', ModalRoute.withName('/'),
                arguments: GamePageArgs(newGame, GameMode.PLAY));
          },
        )
      ],
    );
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }

  String toReadable() {
    var date = '';
    if (isToday()) {
      date += 'Today ';
    } else if (isYesterday()) {
      date += 'Yesterday ';
    } else {
      date += DateFormat.yMMMMd('fr_FR').format(this) + ' ';
    }

    date += DateFormat.jm('fr_FR').format(this);
    return date;
  }
}
