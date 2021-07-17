import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scored_/ui/widgets/BottomBar.dart';

class Layout extends StatelessWidget {
  String? scaffoldKey;
  String? title;
  Widget? child;

  Layout({this.child, this.title, this.scaffoldKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(scaffoldKey ?? ''),
        appBar: AppBar(
          title: Text(title ?? 'Scored!'),
          centerTitle: false,
        ),
        body: SafeArea(child: child ?? Center()),
        bottomNavigationBar: BottomBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => log("Clicked fab"),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
