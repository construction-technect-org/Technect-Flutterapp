import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';

class VrmQualifiedScreen extends GetView<VrmTaskController> {
  const VrmQualifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeFilter.value,
        totalCount: controller.todaysTotal.value,
        leads: controller.filteredQualified,
        emptyMessage: 'No qualified lead available',
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.qualifiedStatus,
          activeStatus: controller.activeQualifiedStatusFilter.value,
          onStatusTap: (label) => controller.setStatusQualifiedFilter(label),
        ),
        topSpacing: 10,
      ),
    );
  }
}
