import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/DashboardMarketPlace/controllers/market_place_controller.dart';

class DashboardMarketPlaceView extends GetView<DashboardMarketPlaceController> {
  const DashboardMarketPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: CommonAppBar(isCenter: false, title: const Text("MARKETPLACE")),
        backgroundColor: MyColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text(
                  "Select Your Marketplace",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.primary,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                SizedBox(height: 1.h),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double itemWidth =
                        (constraints.maxWidth - (3 * 10)) /
                        1; // 4 per row with spacing
                    final double itemHeight = itemWidth + 5; // for icon + text

                    return GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.marketplaces.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.marketplaces[index];

                        return Obx(() {
                          final selected =
                              controller.selectedMarketplace.value ==
                              item['title'];
                          return _buildTile(
                            item['title']!,
                            item['icon']!,
                            selected,
                            () {
                              if (index == 0) {
                                controller.selectMarketplace(item['title']!);
                              } else {
                                SnackBars.successSnackBar(
                                  content: 'This feature will come soon',
                                );
                              }
                            },
                          );
                        });
                      },
                    );
                  },
                ),

                SizedBox(height: 2.h),
                Obx(() {
                  return controller.selectedMarketplace.value.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Your Role",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.primary,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                // Dynamically calculate item width
                                final double itemWidth =
                                    (constraints.maxWidth - (3 * 10)) /
                                    1; // 4 per row with spacing
                                final double itemHeight =
                                    itemWidth + 1; // for icon + text

                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.roles.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio:
                                            itemWidth / itemHeight,
                                      ),
                                  itemBuilder: (context, index) {
                                    final role = controller.roles[index];
                                    return Obx(() {
                                      final selected =
                                          controller.selectedRole.value ==
                                          role['title'];
                                      return _buildTile(
                                        role['title'] ?? '',
                                        role['icon'] ?? '',
                                        selected,
                                        () {
                                          if (index == 0) {
                                            controller.selectRole(
                                              role['title']!,
                                            );
                                          } else {
                                            SnackBars.successSnackBar(
                                              content:
                                                  'This feature will come soon',
                                            );
                                          }
                                        },
                                      );
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        );
                }),

                // ✅ Proceed Button
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
          child: RoundedButton(
            buttonName: 'PROCEED',
            onTap: () {
              if (controller.selectedRole.isNotEmpty) {
                controller.marketPlace();
              } else {
                if (controller.selectedMarketplace.isEmpty) {
                  SnackBars.errorSnackBar(content: 'please select marketplace');
                } else {
                  SnackBars.errorSnackBar(content: 'please select role');
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    String title,
    String icon,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,

      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              alignment: Alignment.center,
              width: (Get.width - 47) / 2,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              decoration: BoxDecoration(
                color: selected ? MyColors.yellow : MyColors.greyE5,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? MyColors.primary : MyColors.greyE5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image.asset(icon, height: 10.h),
                  if (icon.contains('.svg')) ...[
                    SvgPicture.asset(
                      icon,
                      height: 9.h,
                      color: selected ? MyColors.primary : MyColors.grey,
                    ),
                  ] else ...[
                    Image.asset(
                      icon,
                      height: 8.h,
                      width: 9.h,
                      color: selected ? MyColors.primary : MyColors.grey,
                    ),
                  ],
                  // SvgPicture.asset(icon),
                  SizedBox(height: 1.h),
                  Text(
                    title,
                    style: MyTexts.bold16.copyWith(
                      color: selected ? MyColors.primary : MyColors.fontBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          if (selected)
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                height: 2.5.h,
                width: 2.5.h,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(5),
                  // shape: BoxShape.s,
                ),
                child: const Icon(Icons.check, size: 20, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
