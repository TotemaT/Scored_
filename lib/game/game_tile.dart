import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/game.dart';
import '../domain/player.dart';

class GameTile extends StatefulWidget {
  const GameTile({required this.player, required this.mode, Key? key})
      : super(key: key);

  final GameMode mode;
  final Player player;

  @override
  _GameTileState createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  _GameTileState();

  final List<int> durations = <int>[500, 500, 250, 100, 50];
  late Player player;
  Timer? timer;

  late StreamSubscription _playerSubscription;

  @override
  void dispose() {
    super.dispose();
    _playerSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    player = widget.player;
    _playerSubscription =
        Hive.box<Player>('players').watch(key: player.key).listen((event) {
      setState(() {
        player.score = event.value.score;
      });
    });
  }

  void _decrement(int i) {
    final Duration duration = Duration(milliseconds: durations[i]);
    final int nextIdx = ++i < durations.length ? i : durations.length - 1;

    timer = Timer(duration, () {
      _doDecrement();
      _decrement(nextIdx);
    });
  }

  _doDecrement() {
    if (widget.mode == GameMode.view) {
      return;
    }
    player.score--;
    player.save();
  }

  _doIncrement() {
    if (widget.mode == GameMode.view) {
      return;
    }
    player.score++;
    player.save();
  }

  Color _getTextColor(Color color) =>
      color.computeLuminance() > .5 ? Colors.black : Colors.white;

  FittedBox _playerName() {
    return _playerText(Text(
      player.name,
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

  void _startDecrement(LongPressStartDetails details) {
    _doDecrement();
    _decrement(0);
  }

  void _stopDecrement(LongPressEndDetails details) {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: widget.mode == GameMode.view ? null : _startDecrement,
      onLongPressEnd: widget.mode == GameMode.view ? null : _stopDecrement,
      child: SizedBox.expand(
        child: Container(
          color: player.color,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.mode == GameMode.view ? null : _doIncrement,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight / 5,
                      child: _playerName(),
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 2,
                      child: _playerScore(),
                    ),
                    SizedBox(
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
}
