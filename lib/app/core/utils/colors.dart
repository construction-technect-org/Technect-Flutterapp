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
  static const Color primary = Color(0xFF1B2F62);
  static const Color grey = Color(0xFF777777);
  static const Color greySecond = Color(0xFF555555);
  static const Color greyThird = Color(0xFF989898);
  static const Color lightBlue = Color(0xFF013B61);
  static const Color lightBlueSecond = Color(0xFF3D41A7);
  static const Color fontBlack = Color(0xFF000000);
  static const Color red = Color(0xFFD83F3F);
  
  // Text field colors
  static const Color textFieldBorder = Color(0xFFA0A0A0);
  static const Color textFieldDivider = Color(0xFF9F9F9F);
  static const Color textFieldBackground = Color(0xFF1B2F62);
}
