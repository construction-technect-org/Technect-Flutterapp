import 'package:flutter/material.dart';

class MyColors {
  static Color custom(String c) {
    final int color = int.parse('0xFF$c');
    return Color(color);
  }

  // Basic colors
  static Color trans = Colors.transparent;
  static Color white = Colors.white;
  static Color black = Colors.black;

  // Primary colors
  static Color primary = const Color(0xFF1B2F62);
}
