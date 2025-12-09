import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';

class VrmSaleFollowupScreen extends GetView<VrmTaskController> {
  const VrmSaleFollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeSalesFilter.value,
        totalCount: controller.salesTodaysTotal.value,
        leads: controller.filteredSalesFollowups,
        emptyMessage: 'No follow-ups available',
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.salesStatusItems,
          activeStatus: controller.activeSalesFollowUpStatusFilter.value,
          onStatusTap: (label) => controller.setSalesStatusFilter(label),
        ),
        topSpacing: 10,
      ),
    );
  }
}
