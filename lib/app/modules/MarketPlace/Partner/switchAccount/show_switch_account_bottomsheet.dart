import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';

Future<void> showSwitchAccountBottomSheet() async { // ✅ async
  final controller = Get.find<SwitchAccountController>();
  final CommonController commonController = Get.find<CommonController>();

  controller.currentRole.value = myPref.role.val;

  // ✅  data fetch
  await commonController.fetchProfileDataM();

  Get.printInfo(info: '🌐 profileDataM: ${commonController.profileDataM.value}');

  controller.hasPartnerAccount.value = (commonController
      .profileDataM
      .value
      .merchantProfile?.verificationId ?? "").isNotEmpty;

  controller.hasConnectorAccount.value =
      commonController.profileDataM.value.connectorProfile != null;
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(() {
        final isPartner =
            controller.currentRole.value.toLowerCase() == 'partner';
        final hasPartner = controller.hasPartnerAccount.value;
        final hasConnector = controller.hasConnectorAccount.value;

        String title = '';
        String subtitle = '';
        VoidCallback? onTap;
        IconData? trailingIcon;

        Get.printInfo(info: '🌐has Partner  :$hasPartner');
        Get.printInfo(info: '🌐has Connector  :$hasConnector');
        //if you have only one account then first add the sec account
        //if u have already sec account  then direct call  switch method
        // Decide what to show
        if (isPartner) {
          // Current: Partner
          if (!hasConnector) {
            title = 'Connector';
            subtitle = 'Add Connector Account';
            trailingIcon = Icons.add;
            onTap = controller.addConnectorAccount;
          } else {
            title = 'Connector';
            subtitle = 'Switch to Connector';
            onTap = controller.switchAccount;
          }
        } else {
          // Current: Connector
          if (!hasPartner) {
            title = 'Merchant';
            subtitle = 'Add Partner Account';
            trailingIcon = Icons.add;
            onTap = controller.addPartnerAccount;
          } else {
            title = 'Merchant';
            subtitle = 'Switch to Partner';
            onTap = controller.switchAccount;
          }
        }

        final emoji = title.toLowerCase() == 'merchant'
            ? Asset.role1
            : Asset.contractor;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 60,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const Text(
              'Switch Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFFAF5E4)),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(emoji, height: 40, width: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: MyTexts.bold16.copyWith(
                              color: MyColors.primary,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            subtitle,
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trailingIcon != null)
                      Icon(trailingIcon, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    ),
  );
}
