import 'package:flutter/material.dart';
import 'package:scored/generated/l10n.dart';

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
  final TextEditingController titleEditingController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

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
        focusNode: titleFocusNode,
        controller: titleEditingController..text = widget.name,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            isDense: true,
            labelText: S.of(context).partyName,
            border: InputBorder.none,
            focusColor: Colors.white,
            labelStyle: const TextStyle(color: Colors.white)),
        onChanged: widget.changeTitle,
      ),
    );
  }
}
