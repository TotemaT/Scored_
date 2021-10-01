import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showSnackbar(
      String title, String? actionLabel, VoidCallback? actionOnPressed) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(title),
        action: actionLabel != null && actionOnPressed != null
            ? SnackBarAction(
                label: actionLabel.toUpperCase(),
                textColor: Theme.of(this).colorScheme.secondary,
                onPressed: actionOnPressed)
            : null));
  }
}
