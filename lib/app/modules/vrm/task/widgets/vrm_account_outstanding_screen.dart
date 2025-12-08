import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_lead_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_status_widget.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_today_card.dart';

class VrmAccountOutstandingScreen extends GetView<VrmTaskController> {
  const VrmAccountOutstandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonLeadScreen(
        filterName: controller.activeAccountFilter.value,
        totalCount: controller.accountTodaysTotal.value,
        leads: controller.filteredAccountOutStanding,
        emptyMessage: 'No Out Standing Bills available',
        todayCard: VrmCommonTodayCard(
          filterName: controller.activeAccountFilter.value,
          totalCount: controller.accountTodaysTotal.value,
        ),
        addButton: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 22),
                const SizedBox(width: 8),
                Text('Add New Bill', style: MyTexts.medium14),
              ],
            ),
          ),
        ),
        statusWidget: VrmCommonStatusWidget(
          statusList: controller.outStandingStatus,
          activeStatus: controller.activeOutStandingStatusFilter.value,
          onStatusTap: (label) => controller.setAccountStatusOutStandingFilter(label),
        ),
        topSpacing: 15,
      ),
    );
  }
}
