import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class Layout extends StatelessWidget {
  const Layout(
      {this.child,
      this.title,
      this.scaffoldKey,
      this.fabIcon,
      this.fabAction,
      this.navigateBack,
      this.appBar,
      Key? key})
      : super(key: key);

  final AppBar? appBar;
  final Widget? child;
  final VoidCallback? fabAction;
  final VoidCallback? navigateBack;
  final Icon? fabIcon;
  final String? scaffoldKey;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(scaffoldKey ?? ''),
        appBar: appBar ??
            AppBar(
              title: Text(title ?? 'Scored!'),
              centerTitle: false,
              leading: null,
              automaticallyImplyLeading: false,
            ),
        body: SafeArea(child: child ?? const Center()),
        bottomNavigationBar: BottomBar(navigateBack: navigateBack),
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
