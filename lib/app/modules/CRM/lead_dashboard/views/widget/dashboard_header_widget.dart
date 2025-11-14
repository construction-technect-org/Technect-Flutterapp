import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/controller/crm_dashboard_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/crm_vrm_toggle_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/header_icon_widget.dart';

class DashboardHeaderWidget extends GetView<LeadDashController> {
  const DashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = Get.find<CRMDashboardController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.ACCOUNT),
            behavior: HitTestBehavior.translucent,
            child: Obx(() {
              return (dash.profileData.value.data?.user?.image ?? "").isEmpty
                  ? const Icon(
                      Icons.account_circle_sharp,
                      color: MyColors.primary,
                      size: 30,
                    )
                  : ClipOval(
                      child: getImageView(
                        finalUrl:
                            "${APIConstants.bucketUrl}${dash.profileData.value.data?.user?.image ?? ""}",
                        fit: BoxFit.cover,
                      ),
                    );
            }),
          ),
          const Gap(15),
          const Flexible(child: CRMVRMToggleWidget()),
          const Gap(18),
          Obx(
            () => HeaderIconWidget(
              icon: Asset.chat,
              count: controller.chatNotificationCount.value,
              onTap: () => Get.toNamed(Routes.All_CHAT_LIST),
            ),
          ),
          const Gap(12),
          Obx(
            () => HeaderIconWidget(
              icon: Asset.notification,
              count: controller.alertNotificationCount.value,
              onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
              isAlert: true,
            ),
          ),
          const Gap(12),
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
