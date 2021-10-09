import 'package:flutter/material.dart';

import 'bottom_menu_sheet.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({this.navigateBack, Key? key}) : super(key: key);

  final VoidCallback? navigateBack;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navigateBack != null
              ? IconButton(
                  onPressed: navigateBack,
                  icon: Icon(Icons.arrow_back,
                      color: Theme.of(context).appBarTheme.foregroundColor))
              : Container(height: 0),
          IconButton(
              color: Theme.of(context).appBarTheme.foregroundColor,
              icon: const Icon(Icons.more_vert),
              onPressed: () => {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) => BottomMenuSheet())
                  }),
        ],
      ),
    );
  }
}
