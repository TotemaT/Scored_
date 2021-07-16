import 'package:flutter/material.dart';
import 'package:scored_/pages/HistoryPage.dart';
import 'package:scored_/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scored!',
      theme: scoredTheme,
      home: HistoryPage(),
    );
  }
}
