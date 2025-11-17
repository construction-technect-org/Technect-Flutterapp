import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/header_icon_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/pill_button.dart';

class TopBarHeader extends GetView<MarketingController> {
  const TopBarHeader({super.key});

  static const double height = 96.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.transparent,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              color: MyColors.black,
            ),

            const SizedBox(width: 6),

            Expanded(
              child: Obx(() {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: PillButton(text: controller.category.value),
                );
              }),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => HeaderIconWidget(
                    icon: Asset.chat,
                    count: controller.chatNotificationCount.value,
                    onTap: () => Get.toNamed(Routes.All_CHAT_LIST),
                  ),
                ),
                const Gap(10),
                Obx(
                  () => HeaderIconWidget(
                    icon: Asset.notification,
                    isAlert: true,
                    count: controller.alertNotificationCount.value,
                    onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                  ),
                ),
                const Gap(10),
                Obx(
                  () => HeaderIconWidget(
                    icon: Asset.notification,
                    count: controller.bellNotificationCount.value,
                    onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
