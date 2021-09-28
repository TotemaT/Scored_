import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/generated/l10n.dart';

class HistoryItemMenu extends StatelessWidget {
  final Game game;
  HistoryItemMenu(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return PopupMenuButton<HistoryItemChoice>(itemBuilder: (context) {
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
          _continue(game, context);
          break;
        case HistoryItemChoice.Delete:
          _delete(game, context);
          break;
        case HistoryItemChoice.Restart:
          _restart(game, context);
          break;
        case HistoryItemChoice.View:
          _view(game, context);
          break;
      }
    });
  }

  void _continue(Game game, BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/game', ModalRoute.withName('/'),
        arguments: GamePageArgs(game, GameMode.PLAY));
  }

  void _delete(Game game, BuildContext context) {
    game.delete();
  }

  void _restart(Game game, BuildContext context) {
    Game newGame = Game.copy(game);
    Hive.box<Game>('games').add(newGame);
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/game', ModalRoute.withName('/'),
        arguments: GamePageArgs(newGame, GameMode.PLAY));
  }

  void _view(Game game, BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/game', ModalRoute.withName('/'),
        arguments: GamePageArgs(game, GameMode.VIEW));
  }
}

enum HistoryItemChoice { Continue, Delete, Restart, View }
