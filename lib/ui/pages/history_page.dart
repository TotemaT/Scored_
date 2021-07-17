import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:scored/ui/partials/layout.dart';
import 'package:scored/ui/widgets/no_history.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _showCreatePartyDialog(BuildContext context) async {
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
                        value: 1,
                        step: 1,
                        onChanged: (value) => print(value),
                        decoration: InputDecoration(labelText: 'Number of Players'),
                      )
                    ],
                  )),
              title: Text('Create a Party'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel', style: TextStyle(color: Colors.black45),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Start'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
//                      Navigator.of(context).pop();
                      log("Let's start playing");
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
