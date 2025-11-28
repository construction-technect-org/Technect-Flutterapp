import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/sales/controller/sales_controller.dart';

class SaleSegmentFiltersWidget extends GetView<SalesController> {
  const SaleSegmentFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [MyColors.custom("FFF9BD"), Colors.white],
        ),
      ),
      padding: const EdgeInsets.only(right: 5),
      child: Obx(
        () => SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.items.map((it) {
              final bool isActive = controller.activeFilter.value == it;
              return GestureDetector(
                onTap: () => controller.setFilter(it),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        it,
                        style: MyTexts.medium14.copyWith(color: MyColors.black),
                      ),
                      const Gap(10),
                      if (isActive)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 3,
                          width: 73,
                          decoration: const BoxDecoration(
                            color: MyColors.primary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 3, width: 73),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
