import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSwitchAccountBottomSheet() {
  final controller = Get.find<SwitchAccountController>();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Text(
              'Account Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Add Partner Account
            if (controller.canAddPartner)
              ListTile(
                leading: const Icon(Icons.person_add_alt),
                title: const Text('Add Partner Account'),
                onTap: controller.addPartnerAccount,
              ),

            // Add Connector Account
            if (controller.canAddConnector)
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Add Connector Account'),
                onTap: controller.addConnectorAccount,
              ),

            // Switch Account
            if (controller.canSwitchAccount)
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: Text(
                  'Switch to ${controller.currentRole.value == 'partner' ? 'Connector' : 'Partner'} Account',
                ),
                onTap: controller.switchAccount,
              ),

            if (!controller.canAddPartner &&
                !controller.canAddConnector &&
                !controller.canSwitchAccount)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'All accounts are active.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        );
      }),
    ),
  );
}
