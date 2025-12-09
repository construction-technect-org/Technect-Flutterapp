import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/vrm_add_new_lead_button.dart';

class VrmLeadScreen extends GetView<VrmTaskController> {
  const VrmLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeFilter.value,
        totalCount: controller.todaysTotal.value,
        leads: controller.filteredLead,
        emptyMessage: "No lead found",
        addButton: VrmAddNewLeadButton(
          onTap: () {
            // TODO: Add navigation to add lead screen
          },
        ),
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.leadStatus,
          activeStatus: controller.activeLeadStatusFilter.value,
          onStatusTap: (label) => controller.setStatusLeadFilter(label),
        ),
        topSpacing: 18,
      ),
    );
  }
}
