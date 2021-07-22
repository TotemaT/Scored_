import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scored/domain/game.dart';
import 'package:scored/history/history_item.dart';
import 'package:scored/history/no_history.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/partials/layout.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _showCreatePartyDialog(BuildContext context) async {
    var playerCount = 1;
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : "Enter a name";
                        },
                        decoration: InputDecoration(labelText: "Party Name"),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 16)),
                      SpinBox(
                        min: 1,
                        max: 15,
                        value: playerCount.toDouble(),
                        step: 1,
                        onChanged: (value) => playerCount = value.toInt(),
                        decoration:
                            InputDecoration(labelText: 'Number of Players'),
                      )
                    ],
                  )),
              title: Text('Create a Party'),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'CANCEL',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('START'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Navigator.of(context).popAndPushNamed('/setup',
                          arguments: SetupPageArgs(
                              _textEditingController.text, playerCount));
                      _textEditingController.clear();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        scaffoldKey: 'HistoryScaffold',
        fabIcon: Icon(Icons.add),
        fabAction: () => _showCreatePartyDialog(context),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Game>('games').listenable(),
          builder: (BuildContext context, Box<Game> box, Widget? widget) {
            if (box.isEmpty) {
              return NoHistory();
            }
            return ListView.separated(
              itemBuilder: (context, listIndex) =>
                  HistoryItem(box.getAt(listIndex) as Game),
              itemCount: box.length,
              separatorBuilder: (_, __) => Divider(),
            );
          },
        ));
  }
}
