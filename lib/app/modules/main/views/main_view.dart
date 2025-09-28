import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/customer_support_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/views/product_management_view.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:construction_technect/app/modules/main/controllers/main_controller.dart';
import 'package:construction_technect/app/modules/menu/views/menu_view.dart';

class MainTabBarView extends GetView<MainController> {
  final CommonController commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return HomeView();
          case 1:
            return ProductManagementView();
          case 2:
            return CustomerSupportView();
          case 3:
            return ConnectionInboxView();
          default:
            return const MenuView();
        }
      }),
      bottomNavigationBar: Obx(() {
        return !commonController.hasProfileComplete.value
            ? Padding(
                padding: EdgeInsets.only(left: 4.h, right: 4.h, bottom: 2.h),
                child: RoundedButton(
                  borderRadius: 0,
                  buttonName: 'PROCEED',
                  onTap: () {},
                ),
              )
            : ColoredBox(
                color: MyColors.primary,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      elevation: 0,
                      // selectedFontSize: 0,
                      // unselectedFontSize: 0,
                      // showSelectedLabels: false,
                      // showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: MyColors.primary,
                      currentIndex: controller.currentIndex.value,
                      onTap: controller.changeTab,
                      selectedItemColor: MyColors.white,
                      unselectedItemColor: MyColors.white.withValues(
                        alpha: 0.25,
                      ),
                      selectedLabelStyle: MyTexts.medium13.copyWith(
                        color: MyColors.white,
                      ),
                      unselectedLabelStyle: MyTexts.medium13.copyWith(
                        color: MyColors.white.withValues(alpha: 0.25),
                      ),
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(
                              Asset.homeIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                controller.currentIndex.value == 0
                                    ? MyColors.white
                                    : MyColors.white.withValues(alpha: 0.25),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(
                              Asset.productIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                controller.currentIndex.value == 1
                                    ? MyColors.white
                                    : MyColors.white.withValues(alpha: 0.25),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'Product',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(
                              Asset.supportIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                controller.currentIndex.value == 2
                                    ? MyColors.white
                                    : MyColors.white.withValues(alpha: 0.25),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'Support',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(
                              Asset.connectionIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                controller.currentIndex.value == 3
                                    ? MyColors.white
                                    : MyColors.white.withValues(alpha: 0.25),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'Connection',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(
                              Asset.moreIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                controller.currentIndex.value == 4
                                    ? MyColors.white
                                    : MyColors.white.withValues(alpha: 0.25),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'More',
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
