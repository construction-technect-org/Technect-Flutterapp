import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';

class SegmentFiltersWidget extends GetView<MarketingController> {
  const SegmentFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Obx(
        () => SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.items.map((it) {
                final bool isActive = controller.activeFilter.value == it;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () => controller.setFilter(it),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF17345A)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isActive
                            ? const [
                                BoxShadow(color: Colors.black12, blurRadius: 6),
                              ]
                            : null,
                      ),
                      child: Text(
                        it,
                        style: MyTexts.medium14.copyWith(
                          color: isActive ? Colors.white : MyColors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
