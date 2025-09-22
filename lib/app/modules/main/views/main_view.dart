import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/customer_support_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/views/product_management_view.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:construction_technect/app/modules/main/controllers/main_controller.dart';
import 'package:construction_technect/app/modules/menu/views/menu_view.dart';

class MainTabBarView extends GetView<MainController> {
  final CommonController commonController = Get.put(CommonController());

  // const MainTabBarView({super.key});

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
            return const MenuView();
          default:
            return HomeView();
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
            : Container(
                // margin: const EdgeInsets.symmetric(vertical: 20),
                height: 80,
                decoration: const BoxDecoration(
                  color: MyColors.primary,
                  // borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabItem(0, Asset.homeIcon, 'Home'),
                    _buildTabItem(1, Asset.wishlistIcon, 'Product Management'),
                    _buildTabItem(2, Asset.supportIcon, 'Support'),
                    _buildTabItem(3, Asset.settingsIcon, 'Settings'),
                  ],
                ),
              );
      }),
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
