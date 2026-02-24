import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashboard.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/show_switch_account_bottomsheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
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
        return const MenuView();
      default:
        return const MenuView();
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
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                  onTap: () => controller.currentIndex.value = 3,
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
                  Icon(Icons.autorenew, color: Colors.white, size: 20),
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
                controller.currentIndex.value == index ? Color(0xFF1B2F62) : Color(0xFF555555),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: MyTexts.medium13.copyWith(
              color: controller.currentIndex.value == index ? Color(0xFF1B2F62) : Color(0xFF555555),
              fontWeight: controller.currentIndex.value == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MyColors.tertiary
      ..style = PaintingStyle.fill;

    double cornerRadius = 40.0;
    double notchWidth = 80.0;
    double topY = 25.0;

    Path path = Path();
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
      radius: Radius.circular(notchWidth / 2.2),
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
