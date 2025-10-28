import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:get/get.dart';

void showSwitchAccountBottomSheet() {
  final controller = Get.find<SwitchAccountController>();
  controller.currentRole.value = myPref.role.val;
  controller.hasPartnerAccount.value =
      Get.find<HomeController>().profileData.value.data?.merchantProfile !=
      null;
  controller.hasConnectorAccount.value =
      Get.find<HomeController>().profileData.value.data?.connectorProfile !=
      null;
  print(controller.currentRole.value);
  print(controller.hasPartnerAccount.value);
  print(controller.hasConnectorAccount.value);
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(() {
        final isPartner =
            controller.currentRole.value.toLowerCase() == 'partner';
        final hasPartner = controller.hasPartnerAccount.value;
        final hasConnector = controller.hasConnectorAccount.value;

        Widget? content;
        if (isPartner && !hasConnector) {
          content = ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Add Connector Account'),
            onTap: controller.addConnectorAccount,
          );
        } else if (!isPartner && !hasPartner) {
          content = ListTile(
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Add Partner Account'),
            onTap: controller.addPartnerAccount,
          );
        } else if (hasPartner && hasConnector) {
          content = ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: Text(
              'Switch to ${isPartner ? 'Connector' : 'Partner'} Account',
            ),
            onTap: controller.switchAccount,
          );
        } else {
          content = const Center(child: Text('No account actions available.'));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MyColors.grayEA),
              ),
              child: content,
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    ),
  );
}
