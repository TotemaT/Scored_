import 'package:flutter/material.dart';

import 'bottom_menu_sheet.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.menu),
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
