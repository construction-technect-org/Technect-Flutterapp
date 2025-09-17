import 'package:flutter/material.dart';
import 'package:get/get.dart';

void hideKeyboard() {
  final context = Get.context;
  if (context != null) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      currentFocus.unfocus();
    }
  }
}
