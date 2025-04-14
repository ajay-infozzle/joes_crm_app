import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}