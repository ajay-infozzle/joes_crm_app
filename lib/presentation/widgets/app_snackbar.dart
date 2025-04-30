import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.red,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}
