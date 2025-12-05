import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/marketing/controller/marketing_controller.dart';

class LeadStatusWidget extends GetView<MarketingController> {
  const LeadStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          final String active = controller.activeLeadStatusFilter.value;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.leadStatus.length,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final String label = controller.leadStatus[index];
              final bool isActive = active == label;
              return Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.setStatusLeadFilter(label),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: MyTexts.medium15.copyWith(
                      color: isActive ? const Color(0xFF17345A) : MyColors.grey,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                    child: Text(label),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
