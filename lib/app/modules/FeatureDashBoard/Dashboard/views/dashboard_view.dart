import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FeatureDashBoard/Dashboard/controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.white,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(Asset.profil, height: 40, width: 40),
                SizedBox(width: 1.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          'Welcome ${controller.profileData.value.data?.user?.firstName}!',
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.fontBlack,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Asset.location,
                            width: 9,
                            height: 12.22,
                          ),
                          SizedBox(width: 0.4.h),
                          Expanded(
                            child: Obx(() {
                              return RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.textFieldBackground,
                                  ),
                                  children: [
                                    TextSpan(text: controller.address.value),
                                    const WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: MyColors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Features",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.black),
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.greyE5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically calculate item width
                    final double itemWidth =
                        (constraints.maxWidth - (3 * 10)) /
                        3; // 4 per row with spacing
                    final double itemHeight = itemWidth + 10; // for icon + text

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.features.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.features[index];

                        return Obx(() {
                          final isSelected =
                              controller.selectedIndex.value == index;
                          return _buildFeatureCard(
                            controller: controller,
                            isSelected: isSelected,
                            item: item,
                            itemWidth: itemWidth,
                            onTap: () {
                              if (index == 0) {
                                controller.selectedIndex.value = index;
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
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Statistics",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.black),
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Partners", "250", Asset.noOfUsers),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        "Connectors",
                        "180",
                        Asset.noOfConectors,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: Center(child: Image.asset(Asset.worldMap, width: 90.w)),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
            child: RoundedButton(
              buttonName: 'PROCEED',
              onTap: () {
                if (controller.selectedIndex.value == 0) {
                  Get.toNamed(Routes.DASHABORD_MARKET_PLACE);
                } else {
                  SnackBars.errorSnackBar(content: 'Please select one feature');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, height: 20, width: 20),
              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: MyTexts.bold18.copyWith(color: MyColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _buildFeatureCard extends StatelessWidget {
  const _buildFeatureCard({
    required this.controller,
    required this.isSelected,
    required this.item,
    required this.itemWidth,
    required this.onTap,
  });

  final DashboardController controller;
  final bool isSelected;
  final Map<String, String> item;
  final double itemWidth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : MyColors.grayD4,
                ),
                color: isSelected ? MyColors.yellow : MyColors.greyE5,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    color: isSelected ? MyColors.primary : MyColors.grey,

                    item['icon']!,
                    height: itemWidth * 0.35, // responsive icon size
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item["title"]!,
                    textAlign: TextAlign.center,
                    style: MyTexts.medium13.copyWith(color: MyColors.fontBlack),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 20,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(5),
                  // shape: BoxShape.s,
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
