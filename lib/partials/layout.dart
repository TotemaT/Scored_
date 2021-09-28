import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class Layout extends StatelessWidget {
  Layout(
      {this.child,
      this.title,
      this.scaffoldKey,
      this.fabIcon,
      this.fabAction,
      this.appBar,
      Key? key})
      : super(key: key);

  final Widget? child;
  final VoidCallback? fabAction;
  final Icon? fabIcon;
  final String? scaffoldKey;
  final String? title;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(scaffoldKey ?? ''),
        appBar: appBar ??
            AppBar(
              title: Text(title ?? 'Scored!'),
              centerTitle: false,
            ),
        body: SafeArea(child: child ?? Center()),
        bottomNavigationBar: BottomBar(),
        floatingActionButton: fabIcon != null
            ? FloatingActionButton(
                onPressed: fabAction,
                child: fabIcon,
              )
            : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
