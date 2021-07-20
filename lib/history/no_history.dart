import 'package:flutter/material.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headline4;
    final subtitleStyle = Theme.of(context).textTheme.subtitle1;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 160),
            child: Text('No history found :(', style: titleStyle),
          ),
          Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Click on the button',
                style: subtitleStyle,
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                'and start a new party now !',
                style: subtitleStyle,
              )),
          Icon(
            Icons.arrow_downward,
            size: 32,
            color: subtitleStyle?.color,
          )
        ],
      ),
    );
  }
}
