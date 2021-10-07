import 'package:flutter/material.dart';

class TextInputState {
  TextInputState({String? initialValue}) {
    if (initialValue != null) {
      controller.text = initialValue;
    }
  }

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
