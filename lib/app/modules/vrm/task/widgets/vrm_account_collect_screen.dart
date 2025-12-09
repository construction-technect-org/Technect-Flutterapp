import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';

class VrmAccountCollectScreen extends GetView<VrmTaskController> {
  const VrmAccountCollectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeAccountFilter.value,
        totalCount: controller.accountTodaysTotal.value,
        leads: controller.filteredAccountCollect,
        emptyMessage: "No Collect found",
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.collectStatus,
          activeStatus: controller.activeCollectStatusFilter.value,
          onStatusTap: (label) => controller.setAccountStatusCollectFilter(label),
        ),
        topSpacing: 15,
      ),
    );
  }
}
