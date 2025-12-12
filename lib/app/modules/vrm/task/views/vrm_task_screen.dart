import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/controller/vrm_task_controller.dart';
import 'package:construction_technect/app/modules/vrm/task/views/vrm_accounts_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/views/vrm_marketing_screen.dart';
import 'package:construction_technect/app/modules/vrm/task/views/vrm_sales_screen.dart';

class VrmTaskScreen extends GetView<VrmTaskController> {
  const VrmTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VrmTaskController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [MyColors.custom("FFF9BD"), MyColors.custom("FFF9BD")],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _tabBar(
                      onTap: () => controller.setTab(0),
                      icon: Asset.MM,
                      name: 'Enquiry',
                      isSelected: controller.currentTab.value == 0,
                    ),
                    _tabBar(
                      onTap: () => controller.setTab(1),
                      icon: Asset.bar_chart,
                      name: 'Purchase',
                      isSelected: controller.currentTab.value == 1,
                    ),
                    _tabBar(
                      onTap: () => controller.setTab(2),
                      icon: Asset.users,
                      name: 'Accounts',
                      isSelected: controller.currentTab.value == 2,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.currentTab.value == 0) return const VrmMarketingScreen();
                if (controller.currentTab.value == 1) return const VrmSalesScreen();
                return const VrmAccountsScreen();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBar({
    required VoidCallback onTap,
    required String icon,
    required String name,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: isSelected == true
            ? [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [],
        borderRadius: BorderRadius.circular(10),
      ),

      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
              color: isSelected ? MyColors.primary : MyColors.gray2E,
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: MyTexts.medium14.copyWith(
                color: isSelected ? MyColors.primary : MyColors.gray2E,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
