import 'package:flutter/material.dart';
import 'package:scored/generated/l10n.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final titleStyle = Theme.of(context).textTheme.headline4;
    final subtitleStyle = Theme.of(context).textTheme.subtitle1;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 160),
            child: Text(s.noHistoryTitle, style: titleStyle),
          ),
          Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                s.noHistoryBody1,
                style: subtitleStyle,
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                s.noHistoryBody2,
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
