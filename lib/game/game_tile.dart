import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scored/domain/player.dart';
import 'package:scored/game/game_page.dart';

class GameTile extends StatefulWidget {
  const GameTile(
      {required this.onDecrement,
      required this.onIncrement,
      required this.player,
      required this.mode});

  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final Player player;
  final GamePageMode mode;

  @override
  _GameTileState createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  final List<int> durations = <int>[500, 500, 250, 100, 50];
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _startDecrement,
      onLongPressEnd: _stopDecrement,
      child: SizedBox.expand(
        child: Container(
          color: widget.player.color,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (widget.mode == GamePageMode.VIEW) {
                  return;
                }
                setState(() {
                  widget.onIncrement();
                });
              },
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
      widget.player.name ?? ' ',
      style: TextStyle(
        color: _getTextColor(widget.player.color),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ));
  }

  FittedBox _playerScore() {
    return _playerText(Text(
      '${widget.player.score}',
      style: TextStyle(
        color: _getTextColor(widget.player.color),
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
    if (widget.mode == GamePageMode.VIEW) {
      return;
    }

    setState(() {
      widget.onDecrement();
    });
    _decrement(0);
  }

  void _stopDecrement(LongPressEndDetails details) {
    if (widget.mode == GamePageMode.VIEW) {
      return;
    }
    timer?.cancel();
  }

  void _decrement(int i) {
    final Duration duration = Duration(milliseconds: durations[i]);
    final int nextIdx = ++i < durations.length ? i : durations.length - 1;

    timer = Timer(duration, () {
      setState(() {
        widget.onDecrement();
      });
      _decrement(nextIdx);
    });
  }
}
