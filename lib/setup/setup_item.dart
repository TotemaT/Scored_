import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scored/generated/l10n.dart';
import 'package:scored/setup/text_input_state.dart';

import '../domain/player.dart';

class SetupItem extends StatefulWidget {
  const SetupItem(
      {this.last = false,
      required this.onChangeName,
      required this.onChangeScore,
      required this.onSelectColor,
      required this.player,
      required this.nameInputState,
      required this.scoreInputState,
      required this.onSubmitted,
      Key? key})
      : super(key: key);

  final bool last;
  final TextInputState nameInputState;
  final ValueChanged<String> onChangeName;
  final ValueChanged<int> onChangeScore;
  final ValueChanged<Color> onSelectColor;
  final VoidCallback onSubmitted;
  final Player player;
  final TextInputState scoreInputState;

  @override
  _SetupItemState createState() => _SetupItemState();
}

class _SetupItemState extends State<SetupItem> {
  _SetupItemState();

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
        ColorPickerType.both: true,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
    ).showPickerDialog(context);

    return selectedColor;
  }

  InputDecoration _fieldDecoration(String label, FocusNode focusNode) {
    return InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        border: InputBorder.none,
        filled: true);
  }

  Widget _nameField(String name) {
    return Expanded(
        flex: 3,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: _fieldDecoration(
                  S.of(context).playerName, widget.nameInputState.focusNode),
              controller: widget.nameInputState.controller..text = name,
              cursorColor: widget.player.color,
              focusNode: widget.nameInputState.focusNode,
              onChanged: (String value) => widget.onChangeName(value),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context)
                  .requestFocus(widget.scoreInputState.focusNode),
            )));
  }

  Widget _scoreField(int score) {
    return Expanded(
      flex: 1,
      child: TextField(
        decoration: _fieldDecoration(
            S.of(context).playerScore, widget.scoreInputState.focusNode),
        controller: widget.scoreInputState.controller..text = score.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: widget.player.color,
        focusNode: widget.scoreInputState.focusNode,
        onChanged: (String? value) =>
            widget.onChangeScore(int.tryParse(value ?? '') ?? 0),
        textCapitalization: TextCapitalization.words,
        textInputAction:
            widget.last ? TextInputAction.done : TextInputAction.next,
        onSubmitted: (_) => widget.onSubmitted(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          ColorIndicator(
            borderRadius: 40,
            color: widget.player.color,
            onSelectFocus: false,
            onSelect: () async {
              final color = await _colorPickerDialog(context);
              widget.onSelectColor(color);
              setState(() => widget.player.color = color);
            },
          ),
          _nameField(widget.player.name),
          _scoreField(widget.player.score)
        ],
      ),
    );
  }
}
