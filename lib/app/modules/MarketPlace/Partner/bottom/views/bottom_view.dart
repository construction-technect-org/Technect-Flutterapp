import 'dart:developer';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashboard.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/merchant_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/show_switch_account_bottomsheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

class BottomBarView extends GetView<BottomController> {
  final CommonController commonController = Get.put(CommonController());

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

              WidgetsBinding.instance.addPostFrameCallback((val) async {
                await Get.find<CommonController>().fetchProfileData();
                await Get.find<HomeController>().fetchCategoryHierarchy();
                await Get.find<HomeController>()
                    .fetchCategoryServiceHierarchy();
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
        return Dashboard();
      case 1:
        return myPref.getRole() == "connector"
            ? HomeView()
            : MerchantHomeView();
      case 2:
        return ConnectionInboxView();
      case 3:
        return const MenuView();
      default:
        return const MenuView();
    }
  }

  Widget _buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                //margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Color(0xFFFFFCE5)],
                  ),
                  //color: Colors.white,
                  /*boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 30,
                      offset: Offset(5, 0),
                    ),
                  ], */
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
                    //Gap(5.5.w),
                    bottomBar(
                      Asset.category,
                      Asset.category1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 1;
                      },
                      index: 1,
                    ),
                    //Gap(5.5.w),
                    if (PermissionLabelUtils.canShow(
                      PermissionKeys.catalogManager,
                    ))
                      bottomBar(
                        Asset.add,
                        Asset.add,
                        myPref.role.val != "connector" ? "" : '',
                        onTap: onSellTap,
                      ),
                    //Gap(5.5.w),
                    bottomBar(
                      Asset.connection,
                      Asset.connection1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 2;
                      },
                      index: 2,
                    ),
                    //Gap(5.5.w),
                    bottomBar(
                      Asset.more,
                      Asset.more1,
                      '',
                      onTap: () {
                        controller.currentIndex.value = 3;
                      },
                      index: 3,
                    ),
                  ],
                ),
              ),
            ),
            if (myPref.getIsTeamLogin() == false)
              GestureDetector(
                onTap: () {
                  Get.put<SwitchAccountController>(SwitchAccountController());
                  showSwitchAccountBottomSheet();
                  // Get.to(() => const ExploreView());
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
                        myPref.getRole() == "partner"
                            ? "Merchant"
                            : "Connector",
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

  void onSellTap() {
    if (Get.find<CommonController>().marketPlace.value == 0) {
      if (myPref.role.val != "connector") {
        if (!commonController.hasProfileComplete.value) {
          _showProfileIncompleteDialog();
        } else if ((Get.find<CommonController>()
                    .profileData
                    .value
                    .data
                    ?.addresses ??
                [])
            .isEmpty) {
          _showAddAddressDialog();
        } else {
          _showProductOptions();
        }
      } else {
        Get.toNamed(Routes.ADD_REQUIREMENT);
      }
    } else if (Get.find<CommonController>().marketPlace.value == 1) {
      if (myPref.role.val != "connector") {
        if (!commonController.hasProfileComplete.value) {
          _showProfileIncompleteDialog();
        } else if ((Get.find<CommonController>()
                    .profileData
                    .value
                    .data
                    ?.addresses ??
                [])
            .isEmpty) {
          _showAddAddressDialog();
        } else {
          _showServiceOptions();
        }
      } else {
        Get.toNamed(Routes.ADD_SERVICE_REQUIREMENT);
      }
    } else {
      _showComingSoonSheet();
    }
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
          child: Center(
            child: Image.asset(
              Asset.comingSoon,
              height: 316,
              fit: BoxFit.cover,
            ),
          ),
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
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
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

class HearderText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const HearderText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          textStyle ??
          MyTexts.medium18.copyWith(
            color: MyColors.black,
            fontFamily: MyTexts.SpaceGrotesk,
          ),
    );
  }
}
