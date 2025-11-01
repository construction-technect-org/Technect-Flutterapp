import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/components/dashboard.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/views/menu_view.dart';
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
            return Dashboard();
          case 1:
            return HomeView();
          case 2:
            return ConnectionInboxView();
          case 3:
            return const MenuView();
          default:
            return const MenuView();
        }
      }),
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
                    'Product',
                    onTap: () {
                      controller.currentIndex.value = 1;
                    },
                    index: 1,
                  ),

                  // bottomBar(
                  //   Asset.category,
                  //   Asset.category1,
                  //   'Category',
                  //   onTap: () {
                  //     controller.currentIndex.value = 1;
                  //   },
                  //   index: 1,
                  // ),
                  bottomBar(
                    Asset.add,
                    Asset.add,
                    myPref.role.val != "connector" ? "Sell" : 'Request',
                    onTap: () {
                      if (Get.find<HomeController>().marketPlace.value == 0) {
                        if (myPref.role.val != "connector") {
                          if (!commonController.hasProfileComplete.value) {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text(
                                  "Complete Your Profile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: const Text(
                                  "To add a product, please complete your business profile first.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.grey),
                                    ),
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
                          } else if ((Get.find<HomeController>()
                                      .profileData
                                      .value
                                      .data
                                      ?.addresses ??
                                  [])
                              .isEmpty) {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text(
                                  "Add Your Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: const Text(
                                  "To add a product, please add your address first.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.grey),
                                    ),
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
                          } else {
                            Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        margin: const EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Select an Option",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Add Product
                                    ListTile(
                                      leading: SvgPicture.asset(Asset.add),
                                      title: const Text("Add New Product"),
                                      titleTextStyle: MyTexts.medium16.copyWith(
                                        color: MyColors.black,
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.toNamed(Routes.ADD_PRODUCT);
                                      },
                                    ),
                                    const Divider(),
                                    // Manage Product
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        Asset.inventory,
                                      ),
                                      title: const Text("Manage Products"),
                                      titleTextStyle: MyTexts.medium16.copyWith(
                                        color: MyColors.black,
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.toNamed(Routes.INVENTORY);
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }
                        } else {
                          Get.toNamed(Routes.ADD_REQUIREMENT);
                        }
                      } else if (Get.find<HomeController>().marketPlace.value ==
                          1) {
                        Get.bottomSheet(
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Select an Option",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Add Product
                                ListTile(
                                  leading: SvgPicture.asset(Asset.add),
                                  title: const Text("Add New Service"),
                                  titleTextStyle: MyTexts.medium16.copyWith(
                                    color: MyColors.black,
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.ADD_PRODUCT);
                                  },
                                ),
                                const Divider(),
                                // Manage Product
                                ListTile(
                                  leading: SvgPicture.asset(
                                    Asset.inventory,
                                  ),
                                  title: const Text("Manage Services"),
                                  titleTextStyle: MyTexts.medium16.copyWith(
                                    color: MyColors.black,
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.INVENTORY);
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      }
                      else{
                        showModalBottomSheet(
                          context: Get.context!,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              width: 150,
                              height: 316,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
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
                    },
                  ),
                  bottomBar(
                    Asset.connection,
                    Asset.connection1,
                    'Connection',
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
          ),
        ],
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
          Obx(() {
            return SvgPicture.asset(
              controller.currentIndex.value == index ? icon2 : icon,
              height: 24,
              width: 24,
            );
          }),
          Text(name, style: MyTexts.medium14),
        ],
      ),
    );
  }
}
