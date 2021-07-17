import 'package:flutter/material.dart';
import 'package:scored/ui/pages/game_page.dart';
import 'package:scored/ui/partials/layout.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SetupPageArgs;

    return Layout(
        scaffoldKey: 'SetupPage',
        title: args.title,
        fabIcon: Icon(Icons.play_arrow),
        fabAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/game',
            ModalRoute.withName('/'),
            arguments: GamePageArgs (
              ["un", "deux"],
              GamePageMode.PLAY
            )
          );
        },
        child: ListView.builder(
            itemBuilder: (BuildContext ctx, int idx) => Text("Player #$idx"),
            itemCount: args.playerCount
          )
        );
  }
}

class SetupPageArgs {
  const SetupPageArgs(this.title, this.playerCount);

  final int playerCount;
  final String title;
}
