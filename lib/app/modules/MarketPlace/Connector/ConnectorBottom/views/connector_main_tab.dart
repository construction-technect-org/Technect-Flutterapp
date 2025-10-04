
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorBottom/controllers/connector_main_tab_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorConnectionInbox/views/connector_connection_inbox_vies.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorCustomerSupportTicket/views/connector_customer_support_ticket_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorMenu/views/connector_menu_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/views/connector_selected_product_view.dart';

class ConnectorBottom extends GetView<ConnectorBottomController> {
  const ConnectorBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return ConnectorHomeView();
          case 1:
            return ConnectorSelectedProductView();
          case 2:
            return ConnectorCustomerSupportTicketView();
          case 3:
            return ConnectorConnectionInboxVies();
          default:
            return const ConnectorMenuView();
        }
      }),
      bottomNavigationBar: ColoredBox(
        color: MyColors.primary,
        child: SafeArea(
          top: false, 
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
