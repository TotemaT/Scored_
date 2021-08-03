import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/player.dart';

class SetupItem extends StatefulWidget {
  SetupItem(
      {this.last = false,
      required this.onChangeName,
      required this.onSelectColor,
      required this.player,
      required this.inputState,
      required this.onSubmitted,
      Key? key})
      : super(key: key);

  final bool last;
  final ValueChanged<String> onChangeName;
  final ValueChanged<Color> onSelectColor;
  final Player player;
  final TextInputState inputState;
  final VoidCallback onSubmitted;

  @override
  _SetupItemState createState() => _SetupItemState();
}

class _SetupItemState extends State<SetupItem> {
  _SetupItemState();

  @override
  void initState() {
    super.initState();
    widget.inputState.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    widget.inputState.dispose();
  }

  Future<Color> _colorPickerDialog(BuildContext context) async {
    final s = S.of(context);
    Color selectedColor = widget.player.color;

    await ColorPicker(
      color: widget.player.color,
      onColorChanged: (Color color) => selectedColor = color,
      width: 40,
      height: 40,
      borderRadius: 40,
      spacing: 4,
      heading: Text(s.selectColor),
      subheading: Text(s.selectColorShade),
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
    ).showPickerDialog(context);

    return selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        leading: ColorIndicator(
          width: 40,
          height: 40,
          borderRadius: 22,
          color: widget.player.color,
          onSelectFocus: false,
          onSelect: () async {
            final color = await _colorPickerDialog(context);
            widget.onSelectColor(color);
            setState(() => widget.player.color = color);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
              labelText: S.of(context).playerName,
              labelStyle: TextStyle(
                  color: widget.inputState.focusNode.hasFocus
                      ? widget.player.color
                      : Theme.of(context).hintColor),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.player.color,
                ),
              )),
          controller: widget.inputState.controller,
          cursorColor: widget.player.color,
          focusNode: widget.inputState.focusNode,
          onChanged: (String value) => widget.onChangeName(value),
          textCapitalization: TextCapitalization.words,
          textInputAction:
              widget.last ? TextInputAction.done : TextInputAction.next,
          onSubmitted: (_) => widget.onSubmitted(),
        ));
  }
}
