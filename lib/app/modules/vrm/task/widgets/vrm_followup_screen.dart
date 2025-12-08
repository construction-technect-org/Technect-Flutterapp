import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_today_card.dart';

class VrmFollowupScreen extends GetView<VrmTaskController> {
  const VrmFollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeFilter.value,
        totalCount: controller.todaysTotal.value,
        leads: controller.filteredFollowups,
        emptyMessage: 'No follow-ups available',
        todayCard: VrmCommonTodayCard(
          filterName: controller.activeFilter.value,
          totalCount: controller.todaysTotal.value,
        ),
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.statusItems,
          activeStatus: controller.activeFollowUpStatusFilter.value,
          onStatusTap: (label) => controller.setStatusFilter(label),
        ),
        topSpacing: 10,
      ),
    );
  }
}
