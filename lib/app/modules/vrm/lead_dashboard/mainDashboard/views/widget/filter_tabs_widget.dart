import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/mainDashboard/controller/lead_dash_controller.dart';

class FilterTabsWidget extends GetView<VrmLeadDashController> {
  const FilterTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedIndex = controller.selectedFilterIndex.value;
      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filterTabs.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => controller.onFilterTabChanged(index),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? MyColors.primary : Colors.transparent,
                      width: 4,
                    ),
                  ),
                ),
                child: Text(
                  controller.filterTabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? MyColors.primary : MyColors.fontBlack,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
