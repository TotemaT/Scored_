import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scored/ui/partials/Layout.dart';
import 'package:scored/ui/widgets/NoHistory.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      scaffoldKey: 'HistoryScaffold',
      fabIcon: Icon(Icons.add),
      fabAction: () => log("Clicked on icon"),
      child: NoHistory(),
    );
  }
}
