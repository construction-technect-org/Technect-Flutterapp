import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/controllers/approval_Inbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalInboxView extends GetView<ApprovalInboxController> {
  const ApprovalInboxView({super.key});

  Widget buildStatusCard({
    required Color borderColor,
    required Color iconBgColor,
    required IconData icon,
    required Color iconColor,
    required String message,
    required String product,
    required String category,
    required String dateTime,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: borderColor, width: 3)),
        boxShadow: const [
          BoxShadow(
            color: MyColors.americanSilver,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),

            // Message Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message,
                      style: MyTexts.medium14.copyWith(color: MyColors.fontBlack)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("Product: ",
                          style: MyTexts.medium12.copyWith(color: MyColors.fontBlack)),
                      Text(product,
                          style: MyTexts.medium14.copyWith(color: MyColors.fontBlack)),
                      const SizedBox(width: 16),
                      Text("Category: ",
                          style: MyTexts.medium12.copyWith(color: MyColors.fontBlack)),
                      Text(category,
                          style: MyTexts.medium14.copyWith(color: MyColors.fontBlack)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(dateTime,
                      style: MyTexts.medium12.copyWith(color: MyColors.darkGray)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
                scrolledUnderElevation: 0.0,

        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 6.h, left: 16, right: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(50),
                child: Icon(Icons.arrow_back_rounded,
                    size: 24, color: MyColors.black),
              ),
              const SizedBox(width: 8),
              Text("APPROVAL INBOX",
                  style: MyTexts.medium18.copyWith(color: MyColors.fontBlack)),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => ListView.builder(
              itemCount: controller.statusCards.length,
              itemBuilder: (context, index) {
                final card = controller.statusCards[index];
                return buildStatusCard(
                  borderColor: card["borderColor"],
                  iconBgColor: card["iconBgColor"],
                  icon: card["icon"],
                  iconColor: card["iconColor"],
                  message: card["message"],
                  product: card["product"],
                  category: card["category"],
                  dateTime: card["dateTime"],
                );
              },
            )),
      ),
    );
  }
}
