import 'package:flutter/material.dart';

class TextInputState {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
