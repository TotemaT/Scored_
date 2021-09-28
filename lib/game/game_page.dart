import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/game.dart';
import '../domain/player.dart';
import 'game_tile.dart';

class GamePage extends StatefulWidget {
  const GamePage(this.game, this.mode, {Key? key}) : super(key: key);

  final Game game;
  final GameMode mode;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Widget _content(List<Player> players, Orientation orientation, double width,
      double height) {
    players.sort((p1, p2) => p1.index.compareTo(p2.index));
    final int count = players.length;

    if (count == 1) {
      return GameTile(
        player: players[0],
        mode: widget.mode,
      );
    }

    if (count <= 3) {
      return orientation == Orientation.portrait
          ? _singleColumnBody(players, height)
          : _singleRowBody(players, width);
    }

    return orientation == Orientation.portrait
        ? _twoColumnsBody(players, width, height)
        : _twoRowsBody(players, width, height);
  }

  SizedBox _gameTile(Player player, int idx, {double? height, double? width}) {
    return SizedBox(
      height: height,
      width: width,
      child: GameTile(player: player, mode: widget.mode),
    );
  }

  Column _singleColumnBody(List<Player> players, double height) {
    final List<Widget> children = <Widget>[];

    final tileHeight = height / players.length;
    for (int i = 0; i < players.length; i++) {
      children.add(_gameTile(players[i], i, height: tileHeight));
    }

    return Column(children: children);
  }

  Row _singleRowBody(List<Player> players, double width) {
    final List<Widget> children = <Widget>[];

    final tileWidth = width / players.length;
    for (int i = 0; i < players.length; i++) {
      children.add(_gameTile(players[i], i, width: tileWidth));
    }

    return Row(children: children);
  }

  Column _twoColumnsBody(List<Player> players, double width, double height) {
    final List<Widget> children = <Widget>[];
    final tileWidth = width / 2;
    final int count = players.length;

    int rows = count ~/ 2;
    double tileHeight = height / rows;

    if (count.isOdd) {
      rows += 1;
      tileHeight = height / rows;
      tileHeight += tileHeight / (1.5 * count);
    }

    for (int i = 0; i < players.length - 1; i += 2) {
      children.add(Row(
        children: <Widget>[
          _gameTile(players[i], i, height: tileHeight, width: tileWidth),
          _gameTile(players[i + 1], i + 1,
              height: tileHeight, width: tileWidth),
        ],
      ));
    }

    if (count.isOdd) {
      children.add(Row(
        children: <Widget>[
          _gameTile(players.last, count - 1,
              height: height - (rows - 1) * tileHeight, width: width)
        ],
      ));
    }

    return Column(
      children: children,
    );
  }

  Row _twoRowsBody(List<Player> players, double width, double height) {
    final List<Widget> children = <Widget>[];
    final double tileHeight = height / 2;
    final int count = players.length;

    int cols = count ~/ 2;
    double tileWidth = width / cols;

    if (count.isOdd) {
      cols++;
      tileWidth = width / cols;
      tileWidth += tileWidth / (1.5 * count);
    }

    for (int i = 1; i < players.length; i += 2) {
      children.add(Column(
        children: <Widget>[
          _gameTile(players[i], i, height: tileHeight, width: tileWidth),
          _gameTile(players[i - 1], i - 1,
              height: tileHeight, width: tileWidth),
        ],
      ));
    }

    if (count.isOdd) {
      children.add(Column(
        children: <Widget>[
          _gameTile(players.last, count - 1,
              height: height, width: width - (cols - 1) * tileWidth)
        ],
      ));
    }

    return Row(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: OrientationBuilder(
        builder: (BuildContext ctx2, Orientation orientation) {
      if (kIsWeb || Platform.isAndroid) {
        final size = MediaQuery.of(context).size;
        return _content(
            widget.game.players!, orientation, size.width, size.height);
      }

      return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.biggest.width;
              final height = constraints.biggest.height;
              return _content(widget.game.players!, orientation, width, height);
            },
          ),
          bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () async {
                      await widget.game.save();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  )
                ],
              )));
    }), onWillPop: () async {
      await widget.game.save();
      return true;
    });
  }
}

class GamePageArgs {
  const GamePageArgs(this.game, this.mode);

  final Game game;
  final GameMode mode;
}
