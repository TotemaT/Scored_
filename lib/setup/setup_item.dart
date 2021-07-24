import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/player.dart';

class SetupItem extends StatefulWidget {
  SetupItem({
      this.last = false,
      required this.onChangeName,
      required this.onSelectColor,
      required this.player,
      Key? key
  }) : super(key: key);

  final bool last;
  final ValueChanged<String> onChangeName;
  final ValueChanged<Color> onSelectColor;
  final Player player;

  @override
  _SetupItemState createState() => _SetupItemState();
}

class _SetupItemState extends State<SetupItem> {
  _SetupItemState();

  late final TextInputState inputState = TextInputState();

  @override
  dispose() {
    super.dispose();
    inputState.dispose();
  }

  Future<Color> _colorPickerDialog(BuildContext context) async {
    Color selectedColor = widget.player.color;

    await ColorPicker(
      color: widget.player.color,
      onColorChanged: (Color color) => selectedColor = color,
      width: 40,
      height: 40,
      borderRadius: 40,
      spacing: 4,
      heading: Text('Select color',),
      subheading: Text('Select color shade',),
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
                labelText: "Player name",
            ),
            controller: inputState.controller,
            cursorColor: widget.player.color,
            focusNode: inputState.focusNode,
            onChanged: (String value) => widget.onChangeName(value),
            textCapitalization: TextCapitalization.words,
            textInputAction: widget.last ? TextInputAction.done : TextInputAction.next,
        )
    );
  }
}
