import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/game/game_page.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/utils/extensions.dart';

class HistoryItemMenu extends StatelessWidget {
  final Game game;
  const HistoryItemMenu(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return PopupMenuButton<HistoryItemChoice>(itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.play_arrow),
              ),
              Text(s.continueParty),
            ],
          ),
          value: HistoryItemChoice.continueGame,
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.replay),
              ),
              Text(s.restart),
            ],
          ),
          value: HistoryItemChoice.restartGame,
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.visibility),
              ),
              Text(s.viewScores),
            ],
          ),
          value: HistoryItemChoice.viewScores,
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.delete, color: Colors.red),
              ),
              Text(s.delete, style: const TextStyle(color: Colors.red)),
            ],
          ),
          value: HistoryItemChoice.deleteGame,
        ),
      ];
    }, onSelected: (HistoryItemChoice choice) {
      switch (choice) {
        case HistoryItemChoice.continueGame:
          _continue(game, context);
          break;
        case HistoryItemChoice.deleteGame:
          _delete(game, context);
          break;
        case HistoryItemChoice.restartGame:
          _restart(game, context);
          break;
        case HistoryItemChoice.viewScores:
          _view(game, context);
          break;
      }
    });
  }

  void _continue(Game game, BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        GamePage.route, ModalRoute.withName('/'),
        arguments: GamePageArgs(game, GameMode.play));
  }

  void _delete(Game game, BuildContext context) {
    final s = S.of(context);
    game.delete();
    context.showSnackbar(s.deletedParty(game.name ?? ''), s.undo, () {
      Hive.box<Game>('games').add(game);
    });
  }

  void _restart(Game game, BuildContext context) {
    Game newGame = Game.copy(game);
    Hive.box<Game>('games').add(newGame);
    Navigator.of(context).pushNamedAndRemoveUntil(
        SetupPage.route, ModalRoute.withName('/'),
        arguments: SetupPageArgs(game: newGame));
  }

  void _view(Game game, BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        GamePage.route, ModalRoute.withName('/'),
        arguments: GamePageArgs(game, GameMode.view));
  }
}

enum HistoryItemChoice { continueGame, deleteGame, restartGame, viewScores }
