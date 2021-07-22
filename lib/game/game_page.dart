import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/domain/player.dart';
import 'package:scored/game/game_tile.dart';

class GamePage extends StatefulWidget {
  GamePage(this.game, this.mode, {Key? key}) : super(key: key);

  final Game game;
  final GameMode mode;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: OrientationBuilder(
        builder: (BuildContext ctx2, Orientation orientation) {
      return _content(widget.game.players, orientation);
    }), onWillPop: () async {
      await widget.game.save();
      return true;
    });
  }

  Widget _content(List<Player> players, Orientation orientation) {
    final int count = players.length;

    if (count == 1) {
      return GameTile(
        player: players[0],
        mode: widget.mode,
      );
    }

    if (count <= 3) {
      return orientation == Orientation.portrait
          ? _singleColumnBody(players)
          : _singleRowBody(players);
    }

    return orientation == Orientation.portrait
        ? _twoColumnsBody(players)
        : _twoRowsBody(players);
  }

  Column _singleColumnBody(List<Player> players) {
    final List<Widget> children = <Widget>[];

    final double height = MediaQuery.of(context).size.height / players.length;
    for (int i = 0; i < players.length; i++) {
      children.add(_gameTile(players[i], i, height: height));
    }

    return Column(children: children);
  }

  Row _singleRowBody(List<Player> players) {
    final List<Widget> children = <Widget>[];

    final double width = MediaQuery.of(context).size.width / players.length;
    for (int i = 0; i < players.length; i++) {
      children.add(_gameTile(players[i], i, width: width));
    }

    return Row(children: children);
  }

  Column _twoColumnsBody(List<Player> players) {
    final List<Widget> children = <Widget>[];
    final double width = MediaQuery.of(context).size.width / 2;
    final int count = players.length;

    int rows = count ~/ 2;
    double height = MediaQuery.of(context).size.height / rows;

    if (count.isOdd) {
      rows += 1;
      height = MediaQuery.of(context).size.height / rows;
      height += height / (1.5 * count);
    }

    for (int i = 0; i < players.length - 1; i += 2) {
      children.add(Row(
        children: <Widget>[
          _gameTile(players[i], i, height: height, width: width),
          _gameTile(players[i + 1], i + 1, height: height, width: width),
        ],
      ));
    }

    if (count.isOdd) {
      children.add(Row(
        children: <Widget>[
          _gameTile(players.last, count - 1,
              height: MediaQuery.of(context).size.height - (rows - 1) * height,
              width: MediaQuery.of(context).size.width)
        ],
      ));
    }

    return Column(
      children: children,
    );
  }

  Row _twoRowsBody(List<Player> players) {
    final List<Widget> children = <Widget>[];
    final double height = MediaQuery.of(context).size.height / 2;
    final int count = players.length;

    int cols = count ~/ 2;
    double width = MediaQuery.of(context).size.width / cols;

    if (count.isOdd) {
      cols++;
      width = MediaQuery.of(context).size.width / cols;
      width += width / (1.5 * count);
    }

    for (int i = 1; i < players.length; i += 2) {
      children.add(Column(
        children: <Widget>[
          _gameTile(players[i], i, height: height, width: width),
          _gameTile(players[i - 1], i - 1, height: height, width: width),
        ],
      ));
    }

    if (count.isOdd) {
      children.add(Column(
        children: <Widget>[
          _gameTile(players.last, count - 1,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - (cols - 1) * width)
        ],
      ));
    }

    return Row(
      children: children,
    );
  }

  Container _gameTile(Player player, int idx, {double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      child: GameTile(player: player, mode: widget.mode),
    );
  }
}

class GamePageArgs {
  const GamePageArgs(this.game, this.mode);

  final Game game;
  final GameMode mode;
}
