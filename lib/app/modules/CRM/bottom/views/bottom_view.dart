import 'dart:developer';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/views/crm_dashboard.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/views/lead_dashboard_screen.dart';
import 'package:construction_technect/app/modules/CRM/more/views/more_screen.dart';
import 'package:construction_technect/app/modules/CRM/task/views/task_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

class CRMBottomBarView extends GetView<CRMBottomController> {
  @override
  Widget build(BuildContext context) {
    log('Token ~~~>> ${myPref.getToken()}');

    return OfflineBuilder(
      child: _buildUpgradeAlert(context),
      connectivityBuilder:
          (BuildContext context, List<ConnectivityResult> connectivity, Widget child) {
            final bool connected = !connectivity.contains(ConnectivityResult.none);

            if (!connected && !controller.isBottomSheetOpen.value) {
              controller.isBottomSheetOpen.value = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                  builder: (_) => PopScope(canPop: false, child: NoInternetBottomSheet()),
                ).whenComplete(() {
                  controller.isBottomSheetOpen.value = false;
                });
              });
            } else if (connected && controller.isBottomSheetOpen.value) {
              controller.isBottomSheetOpen.value = false;
              Get.back();
            }

            return child;
          },
    );
  }

  Widget _buildUpgradeAlert(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      shouldPopScope: () => true,
      barrierDismissible: true,
      upgrader: Upgrader(durationUntilAlertAgain: const Duration(days: 1)),
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          body: _getCurrentScreen(),
          bottomNavigationBar: _buildBottomBar(),
        );
      }),
    );
  }

  Widget _getCurrentScreen() {
    switch (controller.currentIndex.value) {
      case 0:
        return CRMHomeView();
      case 1:
        return const LeadDashboardScreen();
      case 2:
        return CRMTaskScreen();
      case 3:
        return CRMMoreScreen();
      default:
        return CRMMoreScreen();
    }
  }

  Widget _buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Color(0x19000000), blurRadius: 30, offset: Offset(5, 0)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomBar(
                Asset.home,
                Asset.home1,
                'Home',
                onTap: () {
                  controller.currentIndex.value = 0;
                },
                index: 0,
              ),
              bottomBar(
                Asset.category,
                Asset.category1,
                'Dashboard',
                onTap: () {
                  controller.currentIndex.value = 1;
                },
                index: 1,
              ),
              bottomBar(
                Asset.add,
                Asset.add,
                myPref.role.val != "connector" ? "Lead" : 'Lead',
                onTap: onSellTap,
              ),
              bottomBar(
                Asset.task,
                Asset.task1,
                'Task',
                onTap: () {
                  controller.currentIndex.value = 2;
                },
                index: 2,
              ),
              bottomBar(
                Asset.more,
                Asset.more1,
                'More',
                onTap: () {
                  controller.currentIndex.value = 3;
                },
                index: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onSellTap() {
    Get.toNamed(
      Routes.ADD_LEAD,
      arguments: {
        "onLeadCreate": () {
          Get.back();
        },
      },
    );
  }

  Widget bottomBar(String icon, String icon2, String name, {void Function()? onTap, int? index}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => SvgPicture.asset(
              controller.currentIndex.value == index ? icon2 : icon,
              height: 24,
              width: 24,
            ),
          ),
          Text(name, style: MyTexts.medium14),
        ],
      ),
    );
  }
}
