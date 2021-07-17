import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scored/ui/widgets/BottomBar.dart';

class Layout extends StatelessWidget {
  Layout({this.child, this.title, this.scaffoldKey, this.fabIcon, this.fabAction, Key? key})
      : super(key: key);

  final Widget? child;
  final VoidCallback? fabAction;
  final Icon? fabIcon;
  final String? scaffoldKey;
  final String? title;

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
