import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';

void showSwitchAccountBottomSheet() {
  final controller = Get.put<SwitchAccountController>(
    SwitchAccountController(),
  );

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // Text(
            //   'Account Options',
            //   style: MyTexts.bold16.copyWith(color: MyColors.primary),
            // ),
            // const SizedBox(height: 20),

            // Add Partner Account
            if (controller.canAddPartner)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.grayEA),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person_add_alt),
                  title: const Text('Add Partner Account'),
                  onTap: controller.addPartnerAccount,
                ),
              ),

            // Add Connector Account
            if (controller.canAddConnector)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.grayEA),
                ),
                child:    ListTile(
                  leading: const Icon(Icons.person_add),
                  title: const Text('Add Connector Account'),
                  onTap: controller.addConnectorAccount,
                ),
              ),


            // Switch Account
            if (controller.canSwitchAccount)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.grayEA),
                ),
                child: ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: Text(
                    'Switch to ${controller.currentRole.value == 'partner' ? 'Connector' : 'Partner'} Account',
                  ),
                  onTap: controller.switchAccount,
                ),
              ),
            const SizedBox(height: 20),

          ],
        );
      }),
    ),
  );
}
