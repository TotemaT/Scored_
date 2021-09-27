import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scored/generated/l10n.dart';

import '../domain/game.dart';
import '../domain/player.dart';
import '../game/game_page.dart';

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
    final s = S.of(context);

    return ListTile(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(game.name ?? ''),
            Text(game.date.toReadable(),
                style:
                    TextStyle(color: Theme.of(context).hintColor, fontSize: 12))
          ]),
      subtitle: Text(
        _playersDetails(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<HistoryItemChoice>(itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.play_arrow),
                ),
                Text(s.continueParty),
              ],
            ),
            value: HistoryItemChoice.Continue,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.replay),
                ),
                Text(s.restart),
              ],
            ),
            value: HistoryItemChoice.Restart,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.visibility),
                ),
                Text(s.viewScores),
              ],
            ),
            value: HistoryItemChoice.View,
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                Text(s.delete, style: TextStyle(color: Colors.red)),
              ],
            ),
            value: HistoryItemChoice.Delete,
          ),
        ];
      }, onSelected: (HistoryItemChoice choice) {
        switch (choice) {
          case HistoryItemChoice.Continue:
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/game', ModalRoute.withName('/'),
                arguments: GamePageArgs(game, GameMode.PLAY));
            break;
          case HistoryItemChoice.Delete:
            game.delete();
            break;
          case HistoryItemChoice.Restart:
            Game newGame = Game.copy(game);
            Hive.box<Game>('games').add(newGame);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/game', ModalRoute.withName('/'),
                arguments: GamePageArgs(newGame, GameMode.PLAY));
            break;
          case HistoryItemChoice.View:
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/game', ModalRoute.withName('/'),
                arguments: GamePageArgs(game, GameMode.VIEW));
            break;
        }
      }),
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

enum HistoryItemChoice { Continue, Delete, Restart, View }
