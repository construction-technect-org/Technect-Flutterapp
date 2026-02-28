import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_drawer.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/views/setting_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashboard.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/show_switch_account_bottomsheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

class BottomBarView extends GetView<BottomController> {
  final CommonController commonController = Get.find<CommonController>();

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
                await Get.find<CommonController>().fetchProfileData();
                // await Get.find<HomeController>().fetchCategoryHierarchy();
                // await Get.find<HomeController>().fetchCategoryServiceHierarchy();
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
          drawer: const CustomDrawer(),
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
        return myPref.getRole() == "connector" ? ConnectorHomeView() : HomeView();
      case 2:
        return ConnectionInboxView();
      case 3:
        return const SettingView();
      default:
        return const SettingView();
    }
  }

  Widget _buildBottomBar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: Size(100.w, 100),
          painter: BNBCustomPainter(),
          child: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomBar(
                  Asset.home,
                  Asset.home1,
                  'Home',
                  index: 0,
                  onTap: () => controller.currentIndex.value = 0,
                ),
                _bottomBar(
                  Asset.connection,
                  Asset.connection1,
                  'Connect',
                  index: 2,
                  onTap: () => controller.currentIndex.value = 2,
                ),
                const SizedBox(width: 40),
                _bottomBar(
                  Asset.setting,
                  Asset.setting,
                  'Settings',
                  index: 3, // Menu/Setting index
                  onTap: () {
                    // Logic for profile tap
                    Get.toNamed(Routes.SETTING);
                  },
                ),
                _bottomBar(
                  Asset.person,
                  Asset.person,
                  'Profile',
                  index: 4, // Profile index (need to add to controller if not exists)
                  onTap: () {
                    // Logic for profile tap
                    Get.toNamed(Routes.PROFILE);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: GestureDetector(
            onTap: () async {
              await commonController.fetchProfileDataM();
              Get.put<SwitchAccountController>(SwitchAccountController());
              showSwitchAccountBottomSheet();
            },
            child: Container(
              width: 65,
              height: 115,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B4F92), Color(0xFF1B2F62)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(color: Colors.blue.withOpacity(0.3), spreadRadius: 4, blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.autorenew, color: Colors.white, size: 20),
                  Text(
                    'Switch',
                    style: MyTexts.medium10.copyWith(color: Colors.white, fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSellTap() {
    log("commonController.hasProfileComplete.value: ${commonController.hasProfileComplete.value}");
    log("marketPlace.value: ${Get.find<CommonController>().marketPlace.value}");
    if (Get.find<CommonController>().marketPlace.value == 0) {
      if (myPref.role.val != "connector") {
        if (!commonController.hasProfileComplete.value) {
          _showProfileIncompleteDialog();
        } else if ((Get.find<CommonController>().profileData.value.data?.addresses ?? []).isEmpty) {
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
        } else if ((Get.find<CommonController>().profileData.value.data?.addresses ?? []).isEmpty) {
          _showAddAddressDialog();
        } else {
          _showProductOptions(); // Fallback to product options or some other logic if needed?
          // Actually, let's just leave it empty or show a dialog for now if service options are not ready.
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
            // _sheetHandle(),
            const Text(
              "Select an Option",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            /* ListTile(
              leading: SvgPicture.asset(Asset.add),
              title: const Text("Add New Product"),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADD_PRODUCT);
              },
            ), */
            //const Divider(),
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

  Widget _bottomBar(
    String icon,
    String icon2,
    String name, {
    required int index,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => SvgPicture.asset(
              controller.currentIndex.value == index ? icon2 : icon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                controller.currentIndex.value == index
                    ? const Color(0xFF1B2F62)
                    : const Color(0xFF555555),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: MyTexts.medium14.copyWith(
              color: controller.currentIndex.value == index
                  ? const Color(0xFF1B2F62)
                  : const Color(0xFF555555),
              fontWeight: controller.currentIndex.value == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          // Text(name, style: MyTexts.medium14),
        ],
      ),
    );
  }

  void _showComingSoonSheet() {}

  void _sheetHandle() {}
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = MyColors.tertiary
      ..style = PaintingStyle.fill;

    const double cornerRadius = 40.0;
    const double notchWidth = 80.0;
    const double topY = 25.0;

    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, topY + cornerRadius);
    path.quadraticBezierTo(0, topY, cornerRadius, topY); // Top-left rounded edge

    path.lineTo(size.width / 2 - notchWidth / 2 - 12, topY);

    // Smooth transition into the notch
    path.quadraticBezierTo(
      size.width / 2 - notchWidth / 2,
      topY,
      size.width / 2 - notchWidth / 2,
      topY + 8,
    );

    // The notch circle cutout
    path.arcToPoint(
      Offset(size.width / 2 + notchWidth / 2, topY + 8),
      radius: const Radius.circular(notchWidth / 2.2),
      clockwise: false,
    );

    // Smooth transition out of the notch
    path.quadraticBezierTo(
      size.width / 2 + notchWidth / 2,
      topY,
      size.width / 2 + notchWidth / 2 + 12,
      topY,
    );

    path.lineTo(size.width - cornerRadius, topY);
    path.quadraticBezierTo(
      size.width,
      topY,
      size.width,
      topY + cornerRadius,
    ); // Top-right rounded edge

    path.lineTo(size.width, size.height);

    // Bottom edge with center curve
    path.lineTo(size.width / 2 + notchWidth / 2 + 20, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 15,
      size.width / 2 - notchWidth / 2 - 20,
      size.height,
    );

    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 8, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
          MyTexts.medium18.copyWith(color: MyColors.black, fontFamily: MyTexts.SpaceGrotesk),
    );
  }
}

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 2; // center button by default

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: CurvedNavigationBar(
        index: selectedIndex,
        backgroundColor: Colors.transparent,
        color: const Color(0xFFE8E1B0),
        buttonBackgroundColor: const Color(0xFF1565C0),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,

        /// ✅ Custom items — no color change
        items: [
          _navItem(Icons.home_outlined, "Home"),
          _navItem(Icons.grid_view_rounded, "Category"),
          _switchItem(), // center button
          _navItem(Icons.add_box_outlined, "Manage"),
          _navItem(Icons.extension_outlined, "Connect"),
        ],

        onTap: (index) {
          // ✅ Update selectedIndex but keep same color
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  /// 🔹 Normal nav item (no color change)
  Widget _navItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.black87, // ✅ fixed color, not reactive
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87, // ✅ fixed color
          ),
        ),
      ],
    );
  }

  /// 🔹 Center "Switch" button
  Widget _switchItem() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.sync, color: Colors.white, size: 28),
        SizedBox(height: 4),
        Text("Switch", style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
