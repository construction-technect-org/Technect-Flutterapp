import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/header_icon_widget.dart';

class DashboardHeaderWidget extends GetView<LeadDashController> {
  const DashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: MyColors.fontBlack,
              ),
            ),
          ),
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
              count: controller.alertNotificationCount.value,
              onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
              isAlert: true,
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
    );
  }
}
