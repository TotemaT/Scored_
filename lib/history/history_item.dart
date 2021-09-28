import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/history/history_item_menu.dart';

import '../domain/game.dart';
import '../domain/player.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.game, {Key? key}) : super(key: key);

  final Game game;

  String _playersDetails() {
    final players = game.players ?? <Player>[];
    players.sort((Player a, Player b) {
      final diff = b.score - a.score;
      return diff != 0 ? diff : a.name.compareTo(b.name);
    });
    return players.map((p) => p.toDetail()).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(game.name ?? ''),
      subtitle: Text(
        _playersDetails(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(game.date.toReadable(),
              style: TextStyle(color: Theme.of(context).hintColor)),
          HistoryItemMenu(game)
        ],
      ),
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
    final s = S.current;
    final locale = Intl.defaultLocale;
    final time = DateFormat.jm(locale).format(this);

    if (isToday()) {
      return s.historyDate(s.today, time);
    }

    if (isYesterday()) {
      return s.historyDate(s.yesterday, time);
    }

    final day = DateFormat.yMMMMd(locale).format(this);
    return s.historyDate(day, time);
  }
}
