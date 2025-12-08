import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_today_card.dart';

class VrmSaleProspectScreen extends GetView<VrmTaskController> {
  const VrmSaleProspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeSalesFilter.value,
        totalCount: controller.salesTodaysTotal.value,
        leads: controller.filteredSalesProspect,
        emptyMessage: "No prospect lead found",
        todayCard: VrmCommonTodayCard(
          filterName: controller.activeSalesFilter.value,
          totalCount: controller.salesTodaysTotal.value,
        ),
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.salesStatusProspectItems,
          activeStatus: controller.activeSalesProspectStatusFilter.value,
          onStatusTap: (label) => controller.setSalesStatusProspectFilter(label),
        ),
        topSpacing: 10,
      ),
    );
  }
}
