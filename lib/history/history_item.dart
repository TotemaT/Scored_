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
      trailing: Text(_date()),
      subtitle: Text.rich(
        TextSpan(
          children: _playersDetails()
        )
      ),
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/game', ModalRoute.withName('/'),
            arguments: GamePageArgs(game, GamePageMode.VIEW));
      },
    );
  }

  String _date() {
    var date = '';
    if (game.date.isToday()) {
      date += 'Today at ';
    } else if (game.date.isYesterday()) {
      date += 'Yesterday at ';
    } else {
      date += DateFormat.yMMMMd('fr_FR').format(game.date) + ' at ';
    }

    date += DateFormat.jm('fr_FR').format(game.date);
    return date;
  }

  List<TextSpan> _playersDetails() {
    final players = game.players;
    players.sort((a, b) {
      final diff = a.score - b.score;
      return diff != 0 ? diff : (a.name ?? '').compareTo(b.name ?? '');
    });
    return players.map((p) => TextSpan(
      text: p.toDetail(),
      style: TextStyle(color: p.color)
    )).toList();
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
}
