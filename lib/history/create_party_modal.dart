import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/setup_page.dart';

class CreatePartyModal extends StatelessWidget {
  CreatePartyModal({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    var playerCount = 1;
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                controller: _textEditingController,
                validator: (value) {
                  return value != null && value.isNotEmpty
                      ? null
                      : s.noNameError;
                },
                decoration: InputDecoration(
                    labelText: s.partyName,
                    border: InputBorder.none,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.remove,
                      color: Colors.transparent,
                    )),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              SpinBox(
                min: 1,
                max: 15,
                value: playerCount.toDouble(),
                step: 1,
                onChanged: (value) => playerCount = value.toInt(),
                decoration: InputDecoration(
                    labelText: s.playerCount,
                    border: InputBorder.none,
                    filled: true),
              )
            ],
          )),
      title: Text(s.createParty),
      actions: <Widget>[
        TextButton(
          child: Text(s.cancel.toUpperCase()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(s.start.toUpperCase()),
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              Navigator.of(context).popAndPushNamed(SetupPage.route,
                  arguments:
                      SetupPageArgs(_textEditingController.text, playerCount));
              _textEditingController.clear();
            }
          },
        ),
      ],
    );
  }
}
