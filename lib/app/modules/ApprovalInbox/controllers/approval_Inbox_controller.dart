import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:construction_technect/app/core/utils/colors.dart';

class ApprovalInboxController extends GetxController {
  // Rx list of status cards
  final statusCards = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStatusCards();
  }

  void loadStatusCards() {
    statusCards.value = [
      {
        "borderColor": MyColors.green,
        "iconBgColor": MyColors.paleMagentaGreen,
        "icon": Icons.check_circle_outline_outlined,
        "iconColor": MyColors.green,
        "message": "Your Product named M-Sand has been approved by the Admin",
        "product": "M Sand",
        "category": "Sand",
        "dateTime": "12 Aug 2025, 08:00pm",
      },
      {
        "borderColor": MyColors.red,
        "iconBgColor": MyColors.mistyRosecolor,
        "icon": Icons.cancel_outlined,
        "iconColor": MyColors.red,
        "message": "Your Product named M-Sand has been rejected by the Admin",
        "product": "M Sand",
        "category": "Sand",
        "dateTime": "12 Aug 2025, 08:00pm",
      },
      {
        "borderColor": MyColors.warning,
        "iconBgColor": MyColors.oldLacelight,
        "icon": Icons.error_outline,
        "iconColor": MyColors.warning,
        "message": "Your Product named M-Sand has been kept On Hold by the Admin",
        "product": "M Sand",
        "category": "Sand",
        "dateTime": "12 Aug 2025, 08:00pm",
      },
    ];
  }
}
