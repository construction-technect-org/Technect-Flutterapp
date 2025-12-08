import 'dart:developer';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/views/crm_dashboard.dart';
import 'package:construction_technect/app/modules/CRM/more/views/more_screen.dart';
import 'package:construction_technect/app/modules/CRM/task/views/task_screen.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/mainDashboard/views/lead_dashboard_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

class VrmBottomBarView extends GetView<VrmBottomController> {
  final CommonController commonController = Get.put(CommonController());

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

              WidgetsBinding.instance.addPostFrameCallback((val) async {
                // await Get.find<HomeController>().fetchProfileData();
                // await Get.find<HomeController>().fetchCategoryHierarchy();
                // await Get.find<HomeController>()
                //     .fetchCategoryServiceHierarchy();
              });
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
        return CRMDashboardScreen(); //TODO: Change to VRM Task Screen
      case 1:
        return const VrmLeadDashboardScreen();
      case 2:
        return CRMTaskScreen(); //TODO: Change to VRM Task Screen
      case 3:
        return CRMMoreScreen(); //TODO: Change to VRM Task Screen
      default:
        return CRMMoreScreen(); //TODO: Change to VRM Task Screen
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

  void _showProfileIncompleteDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Complete Your Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: const Text(
          "To add a product, please complete your business profile first.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.PROFILE);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Complete Now"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showAddAddressDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Add Your Address",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: const Text(
          "To add a product, please add your address first.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.MANUFACTURER_ADDRESS);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Add Address"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showProductOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sheetHandle(),
            const Text(
              "Select an Option",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: SvgPicture.asset(Asset.add),
              title: const Text("Add New Product"),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADD_PRODUCT);
              },
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(Asset.inventory),
              title: const Text("Manage Products"),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.INVENTORY);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sheetHandle(),
            const Text(
              "Select an Option",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: SvgPicture.asset(Asset.add),
              title: const Text("Add New Service"),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADD_SERVICES);
              },
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(Asset.inventory),
              title: const Text("Manage Services"),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.INVENTORY);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoonSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 316,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(child: Image.asset(Asset.comingSoon, height: 316, fit: BoxFit.cover)),
        );
      },
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      ),
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
