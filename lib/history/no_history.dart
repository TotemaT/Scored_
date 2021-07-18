import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 128),
            child: Text(
              'No history found :(',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 8),
            child: Text(
              'Log in to get your previous parties',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 64),
            child: Text(
              'or launch a new party now !',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ),
          SvgPicture.asset(
            'assets/arrow_down.svg',
            semanticsLabel: 'Arrow pointing to the create party button',
            height: 32,
            color: Theme.of(context).textTheme.bodyText1?.color,
          )
        ],
      ),
    );
  }
}
