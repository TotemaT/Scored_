import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/game/game_page.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.game, {Key? key}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(game.name),
      trailing: Text(game.date.toReadable(), style: TextStyle(color: Theme.of(context).hintColor)),
      subtitle: Text.rich(TextSpan(children: _playersDetails()), maxLines: 1,),
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/game', ModalRoute.withName('/'),
            arguments: GamePageArgs(game, GamePageMode.VIEW));
      },
    );
  }

  List<Padding> _playersDetails() {
    final players = game.players;
    players.sort((a, b) {
      final diff = b.score - a.score;
      return diff != 0 ? diff : (a.name ?? '').compareTo(b.name ?? '');
    });
    return players
        .map((p) =>
            TextSpan(text: p.toDetail(), style: TextStyle(color: p.color)))
        .toList();
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
