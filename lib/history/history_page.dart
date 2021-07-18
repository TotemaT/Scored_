import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:scored/setup/setup_page.dart';
import 'package:scored/partials/layout.dart';
import 'package:scored/history/no_history.dart';

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
                          _textEditingController.text,
                          playerCount
                        )
                      );
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
      child: NoHistory(),
    );
  }
}
