// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:construction_technect/app/modules/Connector/ConnectorMenu/views/connector_menu_view.dart';
// import 'package:construction_technect/app/modules/Connector/MainTab/controllers/main_tab_controller.dart';
// import 'package:construction_technect/app/modules/Connector/home/views/home_view.dart';

// class MainTab extends GetView<MainTabController> {
//   const MainTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         switch (controller.currentIndex.value) {
//           case 0:
//             return HomeView();
//           case 1:
//             return const Center(child: Text("1"));
//           case 2:
//             return const Center(child: Text("2"));
//           case 3:
//             return const ConnectorMenuView ();
//           default:
//             return HomeView();
//         }
//       }),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(left: 26, right: 26, bottom: 30),
//         height: 60,
//         decoration: BoxDecoration(
//           color: MyColors.primary,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildTabItem(0, Asset.homeIcon, 'Home'),
//             _buildTabItem(1, Asset.wishlistIcon, 'Wishlist'),
//             _buildTabItem(2, Asset.supportIcon, 'Support'),
//             _buildTabItem(3, Asset.settingsIcon, 'Settings'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabItem(int index, String iconPath, String label) {
//     return GestureDetector(
//       onTap: () => controller.changeTab(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             iconPath,
//             width: 20,
//             height: 20,
//             colorFilter: ColorFilter.mode(MyColors.white, BlendMode.srcIn),
//           ),
//           const SizedBox(height: 4),
//           Text(label, style: MyTexts.medium12.copyWith(color: MyColors.white)),
//         ],
//       ),
//     );
//   }
// }

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorMenu/views/connector_menu_view.dart';
import 'package:construction_technect/app/modules/Connector/MainTab/controllers/main_tab_controller.dart';
import 'package:construction_technect/app/modules/Connector/SelectMainCategory/views/select_main_category_view.dart';
import 'package:construction_technect/app/modules/Connector/home/views/home_view.dart';

class MainTab extends GetView<MainTabController> {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return HomeView();
          case 1:
            return SelectMainCategoryView();
          case 2:
            return const Center(child: Text("2"));
          case 3:
            return const Center(child: Text("3"));
          default:
            return const ConnectorMenuView();
        }
      }),
      bottomNavigationBar: ColoredBox(
        color: MyColors.primary,
        child: SafeArea(
          top: false, // we only care about bottom safe area
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Obx(
                () => BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: MyColors.primary,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeTab,
                  selectedItemColor: MyColors.white,
                  unselectedItemColor: MyColors.white.withOpacity(0.25),
                  selectedLabelStyle: MyTexts.medium13.copyWith(color: MyColors.white),
                  unselectedLabelStyle: MyTexts.medium13.copyWith(
                    color: MyColors.white.withOpacity(0.25),
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Asset.homeIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 0
                              ? MyColors.white
                              : MyColors.white.withOpacity(0.25),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Asset.productIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 1
                              ? MyColors.white
                              : MyColors.white.withOpacity(0.25),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: 'Product',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Asset.supportIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 2
                              ? MyColors.white
                              : MyColors.white.withOpacity(0.25),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: 'Support',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Asset.connectionIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 3
                              ? MyColors.white
                              : MyColors.white.withOpacity(0.25),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: 'Connection',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Asset.moreIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 4
                              ? MyColors.white
                              : MyColors.white.withOpacity(0.25),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: 'More',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String iconPath, String label) {
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(MyColors.white, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(label, style: MyTexts.medium12.copyWith(color: MyColors.white)),
        ],
      ),
    );
  }
}
