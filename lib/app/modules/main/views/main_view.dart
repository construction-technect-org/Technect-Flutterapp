import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/customer_support_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/views/product_management_view.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:construction_technect/app/modules/main/controllers/main_controller.dart';
import 'package:construction_technect/app/modules/settings/views/settings_view.dart';

class MainTabBarView extends GetView<MainController> {
  const MainTabBarView({super.key});

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
            return  const SettingsView();
          default:
            return HomeView();
        }
      }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 26, right: 26, bottom: 30),
        height: 60,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(50),
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
