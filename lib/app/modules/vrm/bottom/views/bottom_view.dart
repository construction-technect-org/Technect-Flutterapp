import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/chat/views/vrm_chat_list_screen.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/views/vrm_dashboard_screen.dart';
import 'package:construction_technect/app/modules/vrm/home/views/vrm_home_view.dart';
import 'package:construction_technect/app/modules/vrm/more/views/more_screen.dart';
import 'package:construction_technect/app/modules/vrm/switchAccount/switchVRMAccount.dart';
import 'package:construction_technect/app/modules/vrm/switchAccount/switchVRMAccountController.dart';
import 'package:construction_technect/app/modules/vrm/task/views/vrm_task_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

class VRMBottomBarView extends GetView<VRMBottomController> {
  final commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    log('Token ~~~>> ${myPref.getToken()}');

    return OfflineBuilder(
      child: _buildUpgradeAlert(context),
      connectivityBuilder:
          (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected = !connectivity.contains(
              ConnectivityResult.none,
            );

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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  builder: (_) =>
                      PopScope(canPop: false, child: NoInternetBottomSheet()),
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
          bottomNavigationBar: _buildBottomBar(context),
        );
      }),
    );
  }

  Widget _getCurrentScreen() {
    switch (controller.currentIndex.value) {
      case 0:
        return VRMHomeView();
      case 1:
        return const VRMDashboardScreen();
      case 2:
        return const VrmTaskScreen();
      case 3:
        return const VRMChatListScreen();
      case 4:
        return const VrmMoreScreen();
      default:
        return VRMHomeView();
    }
  }

  void _showCrmVrmSwitchSheet(
    BuildContext context,
    CommonController commonController,
  ) {
    Get.bottomSheet(
      myPref.getRole() != "connector"
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const Text(
                    'Switch Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  _switchTile(
                    title: 'Connector',
                    subtitle: 'Switch to Connector',
                    asset: Asset.contractor,
                    onTap: () {
                      Get.back();
                      Get.put<SwitchAccountController>(
                        SwitchAccountController(),
                      ).switchAccount();
                      print("what123 ${myPref.getRole()}");
                      Get.offAllNamed(Routes.VRM_MAIN);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const Text(
                    'Switch Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  _switchTile(
                    title: 'Merchant',
                    subtitle: 'Switch to Merchant',
                    asset: Asset.role1,
                    onTap: () {
                      Get.back();
                      Get.put<SwitchAccountController>(
                        SwitchAccountController(),
                      ).switchAccount();
                      print("what ${myPref.getRole()}");
                      Get.offAllNamed(Routes.CRM_MAIN);
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required String asset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.custom('EAEAEA')),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(asset, height: 40, width: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: MyTexts.regular12.copyWith(color: MyColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    print("Cont123 ${controller.myRole.value}");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Color(0xFFFFFCE5)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bottomBar(
                      Asset.home,
                      Asset.home1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 0;
                      },
                      index: 0,
                    ),
                    bottomBar(
                      Asset.category,
                      Asset.category1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 1;
                      },
                      index: 1,
                    ),
                    bottomBar(
                      Asset.add,
                      Asset.add,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 2;
                      },
                      index: 2,
                    ),
                    bottomBar(
                      Asset.connection,
                      Asset.connection1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 3;
                      },
                      index: 3,
                    ),
                    bottomBar(
                      Asset.more,
                      Asset.more1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 4;
                      },
                      index: 4,
                    ),
                  ],
                ),
              ),
            ),
            if (myPref.getIsTeamLogin() == false)
              GestureDetector(
                onTap: () {
                  Get.put<SwitchVRMAccountController>(
                    SwitchVRMAccountController(),
                  );
                  showSwitchVRMAccountBottomSheet();
                  //_showCrmVrmSwitchSheet(context, commonController);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1B2F62),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.autorenew,
                        color: Colors.white,
                        size: 30,
                      ),

                      Text(
                        myPref.getRole() == "connector"
                            ? "Connector"
                            : "Merchant",
                        style: MyTexts.medium12.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget bottomBar(
    String icon,
    String icon2,
    String name, {
    void Function()? onTap,
    int? index,
  }) {
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
