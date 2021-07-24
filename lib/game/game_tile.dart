import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/game.dart';
import '../domain/player.dart';

class GameTile extends StatefulWidget {
  const GameTile({required this.player, required this.mode});

  final Player player;
  final GameMode mode;

  @override
  _GameTileState createState() => _GameTileState(player);
}

class _GameTileState extends State<GameTile> {
  _GameTileState(this.player);

  final List<int> durations = <int>[500, 500, 250, 100, 50];
  Timer? timer;
  Player player;

  late StreamSubscription _playerSubscription;

  @override
  void initState() {
    super.initState();
    _playerSubscription =
        Hive.box<Player>('players').watch(key: player.key).listen((event) {
      setState(() {
        this.player = event.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playerSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: widget.mode == GameMode.VIEW ? null : _startDecrement,
      onLongPressEnd: widget.mode == GameMode.VIEW ? null : _stopDecrement,
      child: SizedBox.expand(
        child: Container(
          color: player.color,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.mode == GameMode.VIEW ? null : _doIncrement,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight / 5,
                      child: _playerName(),
                    ),
                    Container(
                      height: constraints.maxHeight / 2,
                      child: _playerScore(),
                    ),
                    Container(
                      height: constraints.maxHeight / 5,
                      child: null,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  FittedBox _playerName() {
    return _playerText(Text(
      player.name ?? ' ',
      style: TextStyle(
        color: _getTextColor(player.color),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ));
  }

  FittedBox _playerScore() {
    return _playerText(Text(
      '${player.score}',
      style: TextStyle(
        color: _getTextColor(player.color),
      ),
      textAlign: TextAlign.center,
    ));
  }

  FittedBox _playerText(Text text) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: text,
      ),
    );
  }

  Color _getTextColor(Color color) =>
      color.computeLuminance() > .5 ? Colors.black : Colors.white;

  void _startDecrement(LongPressStartDetails details) {
    _doDecrement();
    _decrement(0);
  }

  void _stopDecrement(LongPressEndDetails details) {
    timer?.cancel();
  }

  void _decrement(int i) {
    final Duration duration = Duration(milliseconds: durations[i]);
    final int nextIdx = ++i < durations.length ? i : durations.length - 1;

    timer = Timer(duration, () {
      _doDecrement();
      _decrement(nextIdx);
    });
  }

  _doIncrement() {
    if (widget.mode == GameMode.VIEW) {
      return;
    }
    player.score++;
    player.save();
  }

  _doDecrement() {
    if (widget.mode == GameMode.VIEW) {
      return;
    }
    player.score--;
    player.save();
  }
}
