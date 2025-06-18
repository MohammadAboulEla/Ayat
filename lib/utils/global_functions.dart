import 'package:flutter/material.dart';

String? extractLastNumber(String input) {
  final regex = RegExp(r'([\u0660-\u0669]+)\s*$');
  final match = regex.firstMatch(input);
  return match?.group(1);
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}
