import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/views/connector_selected_product_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/sub_category_item_controller.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:construction_technect/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubCategoryItemScreen extends StatelessWidget {
  SubCategoryItemScreen({super.key});

  final SubCategoryItemController controller = Get.find<SubCategoryItemController>();
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = (Get.arguments ?? {}) as Map<String, dynamic>;

    final int selectedIndexFromPrev = args["selectedSubCategoryItemIdIndex"] ?? 0;

    final List<SubCategory> subCategoryData = args["subCategoryData"] ?? [];

    /// 🔥 AUTO LOAD FROM PREVIOUS SCREEN
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (subCategoryData.isNotEmpty && selectedIndexFromPrev < subCategoryData.length) {
        controller.loadSubCategoryItem(
          subCategoryId: subCategoryData[selectedIndexFromPrev].id ?? "",
          index: selectedIndexFromPrev,
          subCategoryName: subCategoryData[selectedIndexFromPrev].name ?? "",
        );
      }
    });

    return Scaffold(
      body: Column(
        children: [
          /// 🔥 CUSTOM HEADER (REPLACES APPBAR)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    /// PROFILE IMAGE
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ACCOUNT);
                      },
                      child: Obx(() {
                        final isTeamLogin = myPref.getIsTeamLogin();

                        final profileImage = isTeamLogin
                            ? Get.find<CommonController>()
                                      .profileData
                                      .value
                                      .data
                                      ?.teamMember
                                      ?.profilePhoto ??
                                  ''
                            : commonController.profileData.value.data?.user?.image ?? '';

                        if (profileImage.isEmpty) {
                          return const Icon(
                            Icons.account_circle_sharp,
                            size: 48,
                            color: Colors.black,
                          );
                        }

                        return ClipOval(
                          child: getImageView(
                            finalUrl: "${APIConstants.bucketUrl}$profileImage",
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(width: 12),

                    /// NAME + LOCATION
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            final isTeamLogin = myPref.getIsTeamLogin();

                            final firstName = isTeamLogin
                                ? commonController.profileData.value.data?.teamMember?.firstName ??
                                      ''
                                : commonController.profileData.value.data?.user?.firstName ?? '';

                            final lastName = isTeamLogin
                                ? commonController.profileData.value.data?.teamMember?.lastName ??
                                      ''
                                : commonController.profileData.value.data?.user?.lastName ?? '';

                            return Text(
                              '${firstName.capitalizeFirst} ${lastName.capitalizeFirst}! Connector',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            );
                          }),

                          const SizedBox(height: 4),

                          GestureDetector(
                            onTap: myPref.getIsTeamLogin()
                                ? null
                                : () {
                                    if (myPref.role.val == "partner") {
                                      Get.toNamed(Routes.MANUFACTURER_ADDRESS);
                                    } else {
                                      Get.toNamed(Routes.DELIVERY_LOCATION);
                                    }
                                  },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Asset.location,
                                  width: 9,
                                  height: 12,
                                  color: MyColors.custom('545454'),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Obx(() {
                                    return Text(
                                      commonController.getCurrentAddress().value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: MyTexts.medium14.copyWith(
                                        color: MyColors.custom('545454'),
                                      ),
                                    );
                                  }),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🔥 MAIN CONTENT (LEFT LIST + RIGHT GRID)
          Expanded(
            child: Row(
              children: [
                /// LEFT CATEGORY LIST (🔥 FIXED)
                SizedBox(
                  width: 90,
                  child: ListView.builder(
                    itemCount: subCategoryData.length,
                    itemBuilder: (context, index) {
                      final category = subCategoryData[index];

                      return Obx(() {
                        final isSelected = controller.selectedIndex.value == index;

                        return InkWell(
                          onTap: () => {
                            controller.loadSubCategoryItem(
                              subCategoryId: category.id ?? "",
                              index: index,
                              subCategoryName: category.name ?? "",
                            ),
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: 90,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                              border: Border(
                                left: BorderSide(
                                  color: isSelected ? Colors.blue : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          APIConstants.bucketUrl +
                                          (category.image?.url ??
                                              'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg'),
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.category, color: MyColors.primary),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.name ?? '',
                                  style: MyTexts.medium14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),

                /// RIGHT GRID
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.selectedCategoryItemName.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                controller.selectedCategoryItemName.value,
                                style: MyTexts.bold18, // or any title style
                              ),
                            ),
                          Expanded(
                            child: GridView.builder(
                              itemCount: controller.subCategoryItemList.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.9,
                              ),
                              itemBuilder: (context, index) {
                                final item = controller.subCategoryItemList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.to(SelectedProductView());
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  APIConstants.bucketUrl +
                                                  (item.image?.url ??
                                                      'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg'),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => const Icon(
                                                Icons.category,
                                                color: MyColors.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.name ?? '',
                                        style: MyTexts.medium14,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
