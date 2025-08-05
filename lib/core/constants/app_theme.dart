import 'package:flutter/material.dart';

class AppTheme {
  static final TextTheme customTextTheme = TextTheme(
    displayLarge: TextStyle(
      // h1
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      // h2
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      // h3
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      // h4
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      // h5
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      // h6
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      // Subtitle1
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      // Subtitle2
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      // BodyText1
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      // BodyText2
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      // Caption
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: TextStyle(
      // Button
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      // Overline
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.0,
    ),
  );
}
