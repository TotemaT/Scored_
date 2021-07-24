import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../domain/player.dart';

class SetupItem extends StatefulWidget {
  SetupItem(
      {required this.controller,
      required this.focusNode,
      this.last = false,
      required this.onChangeName,
      required this.onSelectColor,
      required this.player,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool last;
  final ValueChanged<String> onChangeName;
  final ValueChanged<Color> onSelectColor;
  final Player player;

  @override
  _SetupItemState createState() => _SetupItemState(
      controller, focusNode, last, onChangeName, onSelectColor, player);
}

class _SetupItemState extends State<SetupItem> {
  _SetupItemState(this.controller, this.focusNode, this.last, this.onChangeName,
      this.onSelectColor, this.player);

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool last;
  final ValueChanged<String> onChangeName;
  final ValueChanged<Color> onSelectColor;
  final Player player;

  Future<Color> _colorPickerDialog(BuildContext context) async {
    Color selectedColor = player.color;

    await ColorPicker(
      color: player.color,
      onColorChanged: (Color color) => selectedColor = color,
      width: 40,
      height: 40,
      borderRadius: 40,
      spacing: 4,
      heading: Text(
        'Select color',
      ),
      subheading: Text(
        'Select color shade',
      ),
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
          color: player.color,
          onSelectFocus: false,
          onSelect: () async {
            final color = await _colorPickerDialog(context);
            onSelectColor(color);
            setState(() => player.color = color);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            labelText: "Player name",
          ),
          controller: controller,
          cursorColor: player.color,
          focusNode: focusNode,
          onChanged: (String value) => onChangeName(value),
          textCapitalization: TextCapitalization.words,
          textInputAction: last ? TextInputAction.done : TextInputAction.next,
        ));
  }
}
