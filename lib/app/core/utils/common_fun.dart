import 'package:construction_technect/app/core/utils/imports.dart';
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

Future<void> openUrl({required String url}) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not launch $url';
  }
}