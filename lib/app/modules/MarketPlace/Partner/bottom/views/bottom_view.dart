import 'dart:developer';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/views/menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/views/product_management_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';

class BottomBarView extends GetView<BottomController> {
  final CommonController commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    log('Token ~~~>> ${myPref.getToken()}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return HomeView();
          case 1:
            return ProductManagementView();
          case 2:
            return ConnectionInboxView();
          case 3:
            return const MenuView();
          default:
            return const MenuView();
        }
      }),
      // bottomNavigationBar: Obx(() {
      //   return !commonController.hasProfileComplete.value
      //       ? Padding(
      //           padding: EdgeInsets.only(left: 4.h, right: 4.h, bottom: 2.h),
      //           child: RoundedButton(
      //             borderRadius: 0,
      //             buttonName: 'PROCEED',
      //             onTap: () {},
      //           ),
      //         )
      //       : ColoredBox(
      //           color: MyColors.primary,
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 6.0),
      //             child: Theme(
      //               data: Theme.of(context).copyWith(
      //                 splashColor: Colors.transparent,
      //                 highlightColor: Colors.transparent,
      //               ),
      //               child: BottomNavigationBar(
      //                 elevation: 0,
      //                 // selectedFontSize: 0,
      //                 // unselectedFontSize: 0,
      //                 // showSelectedLabels: false,
      //                 // showUnselectedLabels: false,
      //                 type: BottomNavigationBarType.fixed,
      //                 backgroundColor: MyColors.primary,
      //                 currentIndex: controller.currentIndex.value,
      //                 onTap: controller.changeTab,
      //                 selectedItemColor: MyColors.white,
      //                 unselectedItemColor: MyColors.white.withValues(alpha: 0.25),
      //                 selectedLabelStyle: MyTexts.medium13.copyWith(
      //                   color: MyColors.white,
      //                 ),
      //                 unselectedLabelStyle: MyTexts.medium13.copyWith(
      //                   color: MyColors.white.withValues(alpha: 0.25),
      //                 ),
      //                 items: [
      //                   BottomNavigationBarItem(
      //                     icon: Padding(
      //                       padding: const EdgeInsets.only(bottom: 4.0),
      //                       child: SvgPicture.asset(
      //                         Asset.homeIcon,
      //                         width: 24,
      //                         height: 24,
      //                         colorFilter: ColorFilter.mode(
      //                           controller.currentIndex.value == 0
      //                               ? MyColors.white
      //                               : MyColors.white.withValues(alpha: 0.25),
      //                           BlendMode.srcIn,
      //                         ),
      //                       ),
      //                     ),
      //                     label: 'Home',
      //                   ),
      //                   BottomNavigationBarItem(
      //                     icon: Padding(
      //                       padding: const EdgeInsets.only(bottom: 4.0),
      //                       child: SvgPicture.asset(
      //                         Asset.productIcon,
      //                         width: 24,
      //                         height: 24,
      //                         colorFilter: ColorFilter.mode(
      //                           controller.currentIndex.value == 1
      //                               ? MyColors.white
      //                               : MyColors.white.withValues(alpha: 0.25),
      //                           BlendMode.srcIn,
      //                         ),
      //                       ),
      //                     ),
      //                     label: 'Product',
      //                   ),
      //                   BottomNavigationBarItem(
      //                     icon: Padding(
      //                       padding: const EdgeInsets.only(bottom: 4.0),
      //                       child: SvgPicture.asset(
      //                         Asset.supportIcon,
      //                         width: 24,
      //                         height: 24,
      //                         colorFilter: ColorFilter.mode(
      //                           controller.currentIndex.value == 2
      //                               ? MyColors.white
      //                               : MyColors.white.withValues(alpha: 0.25),
      //                           BlendMode.srcIn,
      //                         ),
      //                       ),
      //                     ),
      //                     label: 'Support',
      //                   ),
      //                   BottomNavigationBarItem(
      //                     icon: Padding(
      //                       padding: const EdgeInsets.only(bottom: 4.0),
      //                       child: SvgPicture.asset(
      //                         Asset.connectionIcon,
      //                         width: 24,
      //                         height: 24,
      //                         colorFilter: ColorFilter.mode(
      //                           controller.currentIndex.value == 3
      //                               ? MyColors.white
      //                               : MyColors.white.withValues(alpha: 0.25),
      //                           BlendMode.srcIn,
      //                         ),
      //                       ),
      //                     ),
      //                     label: 'Connection',
      //                   ),
      //                   BottomNavigationBarItem(
      //                     icon: Padding(
      //                       padding: const EdgeInsets.only(bottom: 4.0),
      //                       child: SvgPicture.asset(
      //                         Asset.moreIcon,
      //                         width: 24,
      //                         height: 24,
      //                         colorFilter: ColorFilter.mode(
      //                           controller.currentIndex.value == 4
      //                               ? MyColors.white
      //                               : MyColors.white.withValues(alpha: 0.25),
      //                           BlendMode.srcIn,
      //                         ),
      //                       ),
      //                     ),
      //                     label: 'More',
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         );
      // }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            padding: const EdgeInsets.only(
              right: 30,
              left: 30,
              top: 12,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 30,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomBar(
                    Asset.home,
                    'Home',
                    onTap: () {
                      controller.currentIndex.value = 0;
                    },
                  ),
                  bottomBar(
                    Asset.category,
                    'Category',
                    onTap: () {
                      controller.currentIndex.value = 1;
                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.ADD_PRODUCT);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Center(
                      child: SvgPicture.asset(
                        Asset.center,
                        height: 34,
                        width: 34,
                      ),
                    ),
                  ),
                  bottomBar(
                    Asset.connection,
                    'Connection',
                    onTap: () {
                      controller.currentIndex.value = 2;
                    },
                  ),
                  bottomBar(
                    Asset.more,
                    'Mote',
                    onTap: () {
                      controller.currentIndex.value = 3;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar(String icon, String name, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, height: 24, width: 24),
          Text(name, style: MyTexts.medium14),
        ],
      ),
    );
  }
}
