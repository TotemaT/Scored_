import 'package:flutter/material.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/text_input_state.dart';

class SetupAppBar extends AppBar {
  SetupAppBar(this.addPlayer, this.changeTitle, {this.name = '', Key? key})
      : super(key: key);

  final Function(String title) changeTitle;
  final VoidCallback addPlayer;
  final String name;

  @override
  _SetupAppBarState createState() => _SetupAppBarState();
}

class _SetupAppBarState extends State<SetupAppBar> {
  final TextInputState inputState = TextInputState();

  @override
  void dispose() {
    inputState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: widget.addPlayer,
                child:
                    Row(children: const [Icon(Icons.add), Text('Add player')])))
      ],
      title: TextField(
        focusNode: inputState.focusNode,
        controller: inputState.controller..text = widget.name,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            isDense: true,
            labelText: S.of(context).partyName,
            border: InputBorder.none,
            focusColor: Colors.white,
            filled: true,
            labelStyle: const TextStyle(color: Colors.white)),
        onChanged: widget.changeTitle,
      ),
    );
  }
}
