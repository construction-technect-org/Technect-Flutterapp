import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FeatureDashBoard/Dashboard/controllers/dashboard_controller.dart';
import 'package:gap/gap.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
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
                    Row(
                      children: [
                        Obx(() {
                          return (controller
                                          .profileData
                                          .value
                                          .data
                                          ?.user
                                          ?.image ??
                                      "")
                                  .isEmpty
                              ? Image.asset(Asset.profil, height: 48, width: 48)
                              : ClipOval(
                                  child: getImageView(
                                    finalUrl:
                                        "${APIConstants.bucketUrl}${controller.profileData.value.data?.user?.image ?? ""}",
                                    fit: BoxFit.cover,
                                    height: 48,
                                    width: 48,
                                  ),
                                );
                        }),
                        SizedBox(width: 1.h),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  '${(controller.profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(controller.profileData.value.data?.user?.lastName ?? "").capitalizeFirst}!',
                                  style: MyTexts.medium16.copyWith(
                                    color: MyColors.fontBlack,
                                    fontFamily: MyTexts.SpaceGrotesk,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      Asset.location,
                                      width: 9,
                                      height: 12.22,
                                      color: MyColors.custom('545454'),
                                    ),
                                    SizedBox(width: 0.4.h),
                                    Expanded(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                          style: MyTexts.medium14.copyWith(
                                            color: MyColors.custom('545454'),
                                          ),
                                          children: const [
                                            TextSpan(
                                              text:
                                                  "Jp nagar 7th phase rbi layout",
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 4,
                                                ),
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 16,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Image.asset(Asset.explore, width: 18.w),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NOTIFICATIONS);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              border: Border.all(
                                color: MyColors.custom('EAEAEA'),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              Asset.notification,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    Text(
                      "Features",
                      style: MyTexts.extraBold18.copyWith(
                        color: MyColors.black,
                      ),
                    ),
                    const Gap(16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth =
                            (constraints.maxWidth - (2 * 10)) /
                            3; // 4 per row with spacing
                        final double itemHeight =
                            itemWidth + 10; // for icon + text
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.features.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
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
                    SizedBox(height: 1.h),
                    Text(
                      "Statics",
                      style: MyTexts.bold18.copyWith(color: MyColors.black),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "Partners",
                            "32",
                            Asset.noOfUsers,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            "Connectors",
                            "22",
                            Asset.noOfConectors,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
            child: RoundedButton(
              buttonName: 'PROCEED',
              onTap: () {
                if (controller.selectedIndex.value == 0) {
                  Get.toNamed(Routes.MAIN);
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
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFFDEA)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Image.asset(Asset.role1, height: 31, width: 31),
                const Gap(7),
                Text(
                  title,
                  style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color:  const Color(0xFFFFFDEA),
              border: Border.all(color: const Color(0xFFFFFDEA)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: MyTexts.bold18.copyWith(color: MyColors.primary),
            ),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(Asset.categoryBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item['icon']!, height: itemWidth * 0.50),
                  const SizedBox(height: 6),
                  Text(
                    item["title"]!,
                    textAlign: TextAlign.center,
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
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
