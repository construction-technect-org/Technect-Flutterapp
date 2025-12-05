import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/mainDashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/mainDashboard/views/widget/stat_card_widget.dart';

class LeadsSectionWidget extends GetView<VrmLeadDashController> {
  const LeadsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: MyColors.grayE6,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayEA),
        ),
        child: Row(
          children: [
            Expanded(
              child: StatCardWidget(
                title: controller.rawLeadsText.value,
                value: controller.rawLeads.toString(),
              ),
            ),
            const Gap(12),
            Expanded(
              child: StatCardWidget(
                title: controller.followUpLeadsText.value,
                value: controller.followUpLeads.toString(),
              ),
            ),
            const Gap(12),
            Expanded(
              child: StatCardWidget(
                title: controller.pendingLeadsText.value,
                value: controller.pendingLeads.toString(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
