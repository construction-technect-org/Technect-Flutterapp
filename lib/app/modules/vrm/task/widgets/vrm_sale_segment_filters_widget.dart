import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/widgets/common/vrm_common_segment_filters.dart';

class VrmSaleSegmentFiltersWidget extends GetView<VrmTaskController> {
  const VrmSaleSegmentFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => VrmCommonSegmentFilters(
        items: controller.salesItems,
        activeFilter: controller.activeSalesFilter.value,
        onFilterTap: (filter) => controller.setSalesFilter(filter),
      ),
    );
  }
}
