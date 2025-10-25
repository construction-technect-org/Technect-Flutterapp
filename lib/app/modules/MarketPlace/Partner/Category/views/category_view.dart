import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/view/new_launches_product.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:gap/gap.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Construction Materials",
      // "Interior Materials",
      // "Brands",
      "New Launches",
      // "Best Sellers",
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.categoryBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Text(
                  "Category",
                  style: MyTexts.medium20.copyWith(
                    color: MyColors.gray2E,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            if ((Get.find<HomeController>()
                                        .profileData
                                        .value
                                        .data
                                        ?.siteLocations ??
                                    [])
                                .isNotEmpty) {
                              Get.toNamed(
                                Routes.SELECT_PRODUCT,
                                arguments: {
                                  "mainCategoryId":
                                      Get.find<HomeController>()
                                          .categoryHierarchyData
                                          .value
                                          .data![0]
                                          .id ??
                                      0,
                                  "mainCategoryName":
                                      Get.find<HomeController>()
                                          .categoryHierarchyData
                                          .value
                                          .data![0]
                                          .name ??
                                      '',
                                },
                              );
                            } else {
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
                                    "To view a product, please add your address first.",
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
                                        Get.toNamed(Routes.DELIVERY_LOCATION);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Add Address"),
                                    ),
                                  ],
                                ),
                                barrierDismissible: false,
                              );
                            }
                          } else if (index == 1) {
                            if ((Get.find<HomeController>()
                                        .profileData
                                        .value
                                        .data
                                        ?.siteLocations ??
                                    [])
                                .isNotEmpty) {
                              Get.to(() => NewLaunchesProduct());
                            } else {
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
                                    "To view a product, please add your address first.",
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
                                        Get.toNamed(Routes.DELIVERY_LOCATION);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Add Address"),
                                    ),
                                  ],
                                ),
                                barrierDismissible: false,
                              );
                            }
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Asset.cBg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      categories[index],
                                      style: MyTexts.medium16.copyWith(
                                        color: MyColors.gray2E,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: MyColors.gra54,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  "Need Help in Buying ?",
                  style: MyTexts.bold18.copyWith(
                    color: MyColors.gray2E,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
