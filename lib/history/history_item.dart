import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/history/history_item_menu.dart';

import '../domain/game.dart';
import '../domain/player.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.game, this.selected, this.selecting, this.onSelected,
      {Key? key})
      : super(key: key);

  final Game game;
  final bool selected;
  final bool selecting;
  final VoidCallback onSelected;

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
      leading: selecting
          ? Checkbox(value: selected, onChanged: (bool? _) => onSelected())
          : null,
      onLongPress: onSelected,
      onTap: selecting ? onSelected : null,
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
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
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
