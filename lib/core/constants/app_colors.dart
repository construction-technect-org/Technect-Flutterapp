import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1B2F62);
  static Color splashSecondaryTextColor = fromHex('#383838');
  static Color scaffolfBackGroundColor = fromHex('#FDFBEF');

  // for converting hex color strings to Color objects
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    hexString = hexString.replaceFirst('#', '');
    buffer.write(hexString);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
