import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/sub_category_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/view/product_details.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/view/sub_category_item_view.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:construction_technect/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});

  final SubCategoryController controller = Get.find<SubCategoryController>();
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productList = [
      {
        "companyName": "UltraTech Cement",
        "address": "Jp nagar 7th phase rbi layout, Jp na...",
        "price": "4100",
        "unit": "Ton",
        "distance": "5",
        "rating": 4.5,
        "imageUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
        "logoUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
      },
      {
        "companyName": "ACC Cement",
        "address": "Koramangala 4th block, Bangalore...",
        "price": "3900",
        "unit": "Ton",
        "distance": "8",
        "rating": 4.2,
        "imageUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
        "logoUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
      },
      {
        "companyName": "Ambuja Cement",
        "address": "HSR Layout sector 2, Bangalore...",
        "price": "4200",
        "unit": "Ton",
        "distance": "12",
        "rating": 4.7,
        "imageUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
        "logoUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
      },
      {
        "companyName": "Ready Mix Concrete",
        "address": "Whitefield main road, Bangalore...",
        "price": "5500",
        "unit": "M3",
        "distance": "3",
        "rating": 4.0,
        "imageUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
        "logoUrl":
            "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg?semt=ais_user_personalization&w=740&q=80",
      },
    ];
    final Map<String, dynamic> args =
        (Get.arguments ?? {}) as Map<String, dynamic>;

    final int selectedIndexFromPrev = args["selectedSubCategoryIdIndex"] ?? 0;

    final List<CCategory> categoryData = args["categoryData"] ?? [];

    /// 🔥 AUTO LOAD FROM PREVIOUS SCREEN
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryData.isNotEmpty &&
          selectedIndexFromPrev < categoryData.length) {
        controller.loadSubCategory(
          categoryId: categoryData[selectedIndexFromPrev].id ?? "",
          index: selectedIndexFromPrev,
          categoryName: categoryData[selectedIndexFromPrev].name ?? "",
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Construction Materials",
          style: TextStyle(
            fontSize: 18,
            color: MyColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        // title center me chahiye to true
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: MyColors.black),
            onPressed: () {
              // More button action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// 🔥 CUSTOM HEADER (REPLACES APPBAR)
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
          //   ),
          //   child: SafeArea(
          //     bottom: false,
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //       child: Row(
          //         children: [
          //           /// PROFILE IMAGE
          //           GestureDetector(
          //             onTap: () {
          //               Get.toNamed(Routes.ACCOUNT);
          //             },
          //             child: Obx(() {
          //               final isTeamLogin = myPref.getIsTeamLogin();
          //
          //               final profileImage = isTeamLogin
          //                   ? Get.find<CommonController>()
          //                             .profileData
          //                             .value
          //                             .data
          //                             ?.teamMember
          //                             ?.profilePhoto ??
          //                         ''
          //                   : commonController.profileData.value.data?.user?.image ?? '';
          //
          //               if (profileImage.isEmpty) {
          //                 return const Icon(
          //                   Icons.account_circle_sharp,
          //                   size: 48,
          //                   color: Colors.black,
          //                 );
          //               }
          //
          //               return ClipOval(
          //                 child: getImageView(
          //                   finalUrl: "${APIConstants.bucketUrl}$profileImage",
          //                   height: 48,
          //                   width: 48,
          //                   fit: BoxFit.cover,
          //                 ),
          //               );
          //             }),
          //           ),
          //
          //           const SizedBox(width: 12),
          //
          //           /// NAME + LOCATION
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Obx(() {
          //                   final isTeamLogin = myPref.getIsTeamLogin();
          //
          //                   final firstName = isTeamLogin
          //                       ? commonController.profileData.value.data?.teamMember?.firstName ??
          //                             ''
          //                       : commonController.profileData.value.data?.user?.firstName ?? '';
          //
          //                   final lastName = isTeamLogin
          //                       ? commonController.profileData.value.data?.teamMember?.lastName ??
          //                             ''
          //                       : commonController.profileData.value.data?.user?.lastName ?? '';
          //
          //                   return Text(
          //                     '${firstName.capitalizeFirst} ${lastName.capitalizeFirst}! Connector',
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                     style: MyTexts.medium16.copyWith(
          //                       color: MyColors.fontBlack,
          //                       fontFamily: MyTexts.SpaceGrotesk,
          //                     ),
          //                   );
          //                 }),
          //
          //                 const SizedBox(height: 4),
          //
          //                 GestureDetector(
          //                   onTap: myPref.getIsTeamLogin()
          //                       ? null
          //                       : () {
          //                           if (myPref.role.val == "partner") {
          //                             Get.toNamed(Routes.MANUFACTURER_ADDRESS);
          //                           } else {
          //                             Get.toNamed(Routes.DELIVERY_LOCATION);
          //                           }
          //                         },
          //                   child: Row(
          //                     children: [
          //                       SvgPicture.asset(
          //                         Asset.location,
          //                         width: 9,
          //                         height: 12,
          //                         color: MyColors.custom('545454'),
          //                       ),
          //                       const SizedBox(width: 6),
          //                       Expanded(
          //                         child: Obx(() {
          //                           return Text(
          //                             commonController.getCurrentAddress().value,
          //                             maxLines: 1,
          //                             overflow: TextOverflow.ellipsis,
          //                             style: MyTexts.medium14.copyWith(
          //                               color: MyColors.custom('545454'),
          //                             ),
          //                           );
          //                         }),
          //                       ),
          //                       const Icon(
          //                         Icons.keyboard_arrow_down,
          //                         size: 16,
          //                         color: Colors.black54,
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  final category = categoryData[index];

                  return Obx(() {
                    final isSelected = controller.selectedIndex.value == index;

                    return InkWell(
                      onTap: () => {
                        controller.loadSubCategory(
                          categoryId: category.id ?? "",
                          index: index,
                          categoryName: category.name ?? "",
                        ),
                      },
                      child: AnimatedContainer(
                        width: 85,
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          // color:  Colors.white, // optional highlight
                          border: isSelected
                              ? const Border(
                                  top: BorderSide(
                                    color: Colors.amber,
                                    width: 2,
                                  ),
                                  left: BorderSide(
                                    color: Colors.amber,
                                    width: 2,
                                  ),
                                  right: BorderSide(
                                    color: Colors.amber,
                                    width: 2,
                                  ),
                                  bottom:
                                      BorderSide.none, // bottom always hidden
                                )
                              : null, // no border when not selected
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12), // ✅ top left
                            topRight: Radius.circular(12), // ✅ top right
                            bottomLeft: Radius.zero, // ✅ bottom flat
                            bottomRight: Radius.zero, // ✅ bottom flat
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    category.image?.url ??
                                    "https://via.placeholder.com/150",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.category,
                                      color: MyColors.primary,
                                      size: 50,
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
          ),
          SizedBox(height: 5),

          /// 🔥 MAIN CONTENT (LEFT LIST + RIGHT GRID)
          Expanded(
            child: Row(
              children: [
                /// LEFT CATEGORY LIST (🔥 FIXED)
                SizedBox(
                  width: 90,
                  child: ListView.builder(
                    itemCount: categoryData.length,
                    itemBuilder: (context, index) {
                      final category = categoryData[index];

                      return Obx(() {
                        final isSelected =
                            controller.selectedIndex.value == index;

                        return InkWell(
                          onTap: () => {
                            controller.loadSubCategory(
                              categoryId: category.id ?? "",
                              index: index,
                              categoryName: category.name ?? "",
                            ),
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: 90,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade50
                                  : Colors.transparent,

                              border: Border(
                                left: BorderSide(
                                  color: isSelected
                                      ? MyColors.primary
                                      : Colors.transparent,
                                  width: 7,
                                ),
                              ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),    // ✅
                                  bottomRight: Radius.circular(8), // ✅
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          category.image?.url ??
                                          "https://via.placeholder.com/150",
                                      // fallback image
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.category,
                                            color: MyColors.primary,
                                          ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: Container(
                                width: 40.w,

                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.grayEA.withValues(
                                        alpha: 0.32,
                                      ),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: CommonTextField(
                                  // contentPadding: const EdgeInsets.symmetric(
                                  //   horizontal: 12,
                                  //   vertical: 2, // 👈 Default value
                                  // ),
                                  onChange: (value) {
                                    //controller.onSearchChanged(value ?? "");
                                  },
                                  borderRadius: 10,
                                  hintText: 'Search',
                                  prefixIcon: SvgPicture.asset(
                                    Asset.searchIcon,
                                    height: 16,
                                    width: 16,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.filter_alt,
                                    size: 18,
                                  ),
                                  //controller: controller.searchController,
                                  /*suffixIcon: Obx(
                                  () => controller.searchQuery.value.isNotEmpty
                                      ? GestureDetector(
                                          onTap: controller.clearSearch,
                                          child: const Icon(
                                            Icons.clear,
                                            color: MyColors.gray54,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ), */
                                ),
                              ),
                            ),
                            // const Spacer(),
                            GestureDetector(
                              onTap: () {
                                //Get.toNamed(Routes.NEWS);
                              },
                              child: Container(
                                height: 35,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.map_outlined,
                                      color: Colors.grey.shade600,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "5km",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(2),
                            GestureDetector(
                              onTap: () {
                                controller.isGridView.value =
                                    !controller.isGridView.value; // ✅ toggle
                              },
                              child: Container(
                                height: 35,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Obx(
                                  () => Row(
                                    children: [
                                      Icon(
                                        Icons.grid_view_rounded,
                                        color: controller.isGridView.value
                                            ? MyColors
                                                  .warning // ✅ grid selected
                                            : Colors.grey.shade600,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.format_list_bulleted_rounded,
                                        color: !controller.isGridView.value
                                            ? MyColors
                                                  .warning // ✅ list selected
                                            : Colors.grey.shade600,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ✅ Agar parent SingleChildScrollView hai
                        Obx(() => controller.isGridView.value
                            ? GridView.builder(
                          padding: EdgeInsets.all(2.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // ✅ 2 columns
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 1.h,
                            childAspectRatio:
                            0.5, // ✅ height adjust karo
                          ),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final product = productList[index];
                            return _buildGridCard(
                              companyName: product["companyName"],
                              address: product["address"],
                              price: product["price"],
                              unit: product["unit"],
                              distance: product["distance"],
                              rating: product["rating"],
                              imageUrl: product["imageUrl"],
                              logoUrl: product["logoUrl"],
                              onConnect: () {
                                Get.to(ProductDetailScreen());
                              },
                            );
                          },
                        )
                            : ListView.builder(
                          padding: EdgeInsets.only(top: 1.h, bottom: 8.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final product = productList[index];
                            return _buildProductCard(
                              companyName: product["companyName"],
                              address: product["address"],
                              price: product["price"],
                              unit: product["unit"],
                              distance: product["distance"],
                              rating: product["rating"],
                              imageUrl: product["imageUrl"],
                              logoUrl: product["logoUrl"],
                              onConnect: () {
                                Get.to(ProductDetailScreen());

                              },
                            );
                          },
                        ),
                        ),
                        // if (controller.selectedCategoryName.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.only(bottom: 8),
                        //     child: Text(
                        //       controller.selectedCategoryName.value,
                        //       style: MyTexts.bold18, // or any title style
                        //     ),
                        //   ),
                        // Expanded(
                        //   child: GridView.builder(
                        //     itemCount: controller.subCategoryList.length,
                        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       mainAxisSpacing: 12,
                        //       crossAxisSpacing: 12,
                        //       childAspectRatio: 0.9,
                        //     ),
                        //     itemBuilder: (context, index) {
                        //       final subCategory = controller.subCategoryList;
                        //       final item = controller.subCategoryList[index];
                        //
                        //       return GestureDetector(
                        //         onTap: () {
                        //           Get.to(
                        //             SubCategoryItemScreen(),
                        //             arguments: {
                        //               "selectedSubCategoryItemIdIndex": index ?? 0,
                        //               "subCategoryData": subCategory,
                        //             },
                        //           );
                        //         },
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Expanded(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        //                 child: ClipOval(
                        //                   child: CachedNetworkImage(
                        //                     imageUrl:
                        //                         APIConstants.bucketUrl +
                        //                         (item.image ??
                        //                             'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg'),
                        //                     fit: BoxFit.cover,
                        //                     placeholder: (context, url) =>
                        //                         const Center(child: CircularProgressIndicator()),
                        //                     errorWidget: (context, url, error) => const Icon(
                        //                       Icons.category,
                        //                       color: MyColors.primary,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(height: 8),
                        //             Text(
                        //               item.name ?? '',
                        //               style: MyTexts.medium14,
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
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

  Widget _buildGridCard({
    required String companyName,
    required String address,
    required String price,
    required String unit,
    required String distance,
    required double rating,
    required String imageUrl,
    required String logoUrl,
    required VoidCallback onConnect,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Top — Logo + Name + Address
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Row(
              children: [
                /// Logo
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: logoUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.business, size: 16),
                    ),
                  ),
                ),

                SizedBox(width: 2.w),

                /// Name + Address
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ✅ Middle — Product Image
          GestureDetector(
            onTap: onConnect,
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 11.h,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade200),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.grey.shade200),
              ),
            ),
          ),

          /// ✅ Bottom — Price + Rating + Distance + Connect
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ex factory Price",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          "₹$price/$unit",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 0.8.h),

                /// Rating + Distance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$distance Km",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0.8.h),

                /// ✅ Connect Button
                GestureDetector(
                  onTap: onConnect,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: const Center(
                      child: Text(
                        "Connect",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E),
                        ),
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

  Widget _buildProductCard({
    required String companyName,
    required String address,
    required String price,
    required String unit,
    required String distance,
    required double rating,
    required String imageUrl,
    required String logoUrl,
    required VoidCallback onConnect,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ✅ Left Image
          GestureDetector(
            onTap: onConnect,
            child: ClipRRect(
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(12),
              //   bottomLeft: Radius.circular(12),
              // ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 20.w,
                height: 12.h,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade200),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.grey.shade200),
              ),
            ),
          ),

          /// ✅ Right Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Company Name + Logo
                  Row(
                    children: [
                      /// Logo
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: logoUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.business, size: 16),
                          ),
                        ),
                      ),

                      SizedBox(width: 2.w),

                      /// Name + Address
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              address,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 0.8.h),

                  /// Rating + Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$distance Km",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 0.8.h),

                  /// Price + Connect Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ex factory Price",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            "₹$price/$unit",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),

                      /// Connect Button
                      GestureDetector(
                        // onTap: onConnect,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 0.8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: const Text(
                            "Connect",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
