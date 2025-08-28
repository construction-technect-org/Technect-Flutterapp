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
  static const Color redgray = Color(0xFFB62A2A);
  static const Color greyDetails = Color(0xFF7D7D7D);
  static const Color warning = Color(0xFFEB842A);
  static const Color menuTile = Color(0xFFF7FAFF);
  static const Color profileFill = Color(0xFFFFB26E);
  static const Color profileRemaining = Color(0xFF2F4479);
  static const Color iconColor = Color(0xFF999999);
  static const Color progressFill = Color(0xFFEB842A);
  static const Color progressRemaining = Color(0xFFD9D9D9);
  static const Color metricBackground = Color(0xFFEFEFEF);
  static const Color textGrey = Color(0xFF505050);
  static const Color oldLace = Color(0xFFFFF5E8);
  static const Color graniteGray = Color(0xFF676767);
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color  hexGray92 = Color(0xFFEBEBEB);
  static const Color  shadeOfGray = Color(0xFF7C7A7A);



  // Text field colors
  static const Color textFieldBorder = Color(0xFFA0A0A0);
  static const Color textFieldDivider = Color(0xFF9F9F9F);
  static const Color textFieldBackground = Color(0xFF1B2F62);
   static const Color darkGrayishRed = Color(0xFF9D9999);
   static const Color darkGray = Color(0xFF5B5B5B);
    static const Color dimGray = Color(0xFF696969);
}
