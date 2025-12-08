import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_today_card.dart';

class VrmSaleQualifiedScreen extends GetView<VrmTaskController> {
  const VrmSaleQualifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeSalesFilter.value,
        totalCount: controller.salesTodaysTotal.value,
        leads: controller.filteredSalesQualified,
        emptyMessage: 'No qualified lead available',
        todayCard: VrmCommonTodayCard(
          filterName: controller.activeSalesFilter.value,
          totalCount: controller.salesTodaysTotal.value,
        ),
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.salesQualifiedStatus,
          activeStatus: controller.activeSalesQualifiedStatusFilter.value,
          onStatusTap: (label) => controller.setSalesStatusQualifiedFilter(label),
        ),
        topSpacing: 10,
      ),
    );
  }
}
