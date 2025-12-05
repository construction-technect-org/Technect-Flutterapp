import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/controller/accounts_controller.dart';

class AccountOutStandingStatusWidget extends GetView<AccountsController> {
  const AccountOutStandingStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          final String active = controller.activeOutStandingStatusFilter.value;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.billStatus.length,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final String label = controller.billStatus[index];
              final bool isActive = active == label;

              return Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.setStatusFilter(label),
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
