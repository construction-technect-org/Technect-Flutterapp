import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart' hide Category;
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/controller/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/module_models.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/view/sub_category_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Projects/views/projects_view.dart';

class ConnectorHomeView extends StatelessWidget {
  final CommonController commonController = Get.find();
  final ConnectorHomeController controller = Get.put(ConnectorHomeController());

  CachedNetworkImage getImageView({
    required String finalUrl,
    double height = 40,
    double width = 40,
    Decoration? shape,
    BoxFit? fit,
    Color? color,
  }) {
    return CachedNetworkImage(
      imageUrl: finalUrl,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        margin: const EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: const BoxDecoration(color: MyColors.grayF7),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2, color: MyColors.primary),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: SizedBox(
          height: height,
          width: width,
          // decoration: const BoxDecoration(color: MyColors.grayD4, shape: BoxShape.circle),
          child: Image.asset(Asset.appLogo, height: height, width: width, fit: BoxFit.contain),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => hideKeyboard(),
        child: Scaffold(
          backgroundColor: MyColors.lightWhite,
          bottomNavigationBar: const ProjectsBottomNavBar(),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(50),
                    /* Center(
                    child: Text(
                      "MarketPlace",
                      style: MyTexts.bold20.copyWith(color: MyColors.primary),
                    ),
                  ),*/
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ACCOUNT);
                            },
                            behavior: HitTestBehavior.translucent,
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
                                  color: Colors.black,
                                  size: 48,
                                );
                              }

                              return ClipOval(
                                child: getImageView(
                                  finalUrl: "${APIConstants.bucketUrl}$profileImage",
                                  fit: BoxFit.cover,
                                  height: 48,
                                  width: 48,
                                ),
                              );
                            }),
                          ),

                          SizedBox(width: 1.h),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  final userProfile = commonController.profileDataM.value;
                                  return RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${userProfile.user?.firstName?.capitalizeFirst ?? ''} ${userProfile.user?.lastName?.capitalizeFirst ?? ''}',
                                          // '${firstName.capitalizeFirst} ${lastName.capitalizeFirst}! Connector',
                                          style: MyTexts.medium16.copyWith(
                                            color: MyColors.fontBlack,
                                            fontFamily: MyTexts.SpaceGrotesk,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

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
                                        height: 12.22,
                                        color: MyColors.custom('545454'),
                                      ),
                                      SizedBox(width: 0.4.h),
                                      Expanded(
                                        child: Obx(() {
                                          return RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            text: TextSpan(
                                              style: MyTexts.medium14.copyWith(
                                                color: MyColors.custom('545454'),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Lat: ${commonController.currentPosition.value.latitude}, "
                                                      "Lng: ${commonController.currentPosition.value.longitude}",
                                                ),
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
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),

                          /* if (myPref.getIsTeamLogin() == false)
                                GestureDetector(
                                  onTap: () {
                                    Get.put<SwitchAccountController>(SwitchAccountController());
                                    showSwitchAccountBottomSheet();
                                    // Get.to(() => const ExploreView());
                                  },
                                  child: Stack(
                                    alignment: AlignmentGeometry.center,
                                    children: [
                                      Image.asset(Asset.explore, width: 18.w),
                                      Text(
                                        "Switch",
                                        style: MyTexts.medium14.copyWith(color: MyColors.white),
                                      ),
                                    ],
                                  ),
                                ), */
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.NOTIFICATIONS);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: MyColors.white,
                                border: Border.all(color: MyColors.custom('EAEAEA')),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Asset.notification,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.NEWS);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: MyColors.white,
                                border: Border.all(color: MyColors.custom('EAEAEA')),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Asset.info,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.NEWS);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: MyColors.white,
                                border: Border.all(color: MyColors.custom('EAEAEA')),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Asset.chat,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                              ),
                            ),
                          ),

                          //const Gap(10),
                          /*  Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                          child: Container(
                            width: 15.h,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColors.grayEA.withValues(alpha: 0.32),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: CommonTextField(
                              onChange: (value) {
                                //controller.onSearchChanged(value ?? "");
                              },
                              borderRadius: 50,
                              hintText: 'Search',
                              prefixIcon: SvgPicture.asset(
                                Asset.searchIcon,
                                height: 16,
                                width: 16,
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
                        ), */
                        ],
                      ),
                    ),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              controller.connectorModuleData.value.data?.modules?.length ?? 0,
                              (index) {
                                final module =
                                    controller.connectorModuleData.value.data?.modules?[index];

                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: tabBar(
                                    onTap: () async {
                                      hideKeyboard();
                                      Get.printInfo(info: '✅ Module Name : ${module?.name}');
                                      await controller.fetchMainCategory(module?.id);
                                      controller.marketPlace.value = index;
                                    },
                                    iconUrl: module?.image?.url,
                                    // explained below
                                    name: module?.name ?? "-",
                                    isMarketPlace: controller.marketPlace.value == index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Divider(color: Colors.red, height: 2),
                    // const Gap(10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                              //   child: Container(
                              //     width: 88.w,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(50),
                              //       // boxShadow: [
                              //       //   BoxShadow(
                              //       //     color: MyColors.grayEA.withValues(
                              //       //         alpha: 0.32),
                              //       //     blurRadius: 4,
                              //       //   ),
                              //       // ],
                              //     ),
                              //     child: CommonTextField(
                              //       onChange: (value) {},
                              //       borderRadius: 50,
                              //       hintText: 'Search for',
                              //       prefixIcon: SvgPicture.asset(
                              //         Asset.searchIcon,
                              //         height: 16,
                              //         width: 16,
                              //       ),
                              //       suffixIcon: const Icon(Icons.filter_alt, size: 20),
                              //     ),
                              //   ),
                              // ),
                              // Row(
                              //   children: [
                              //
                              //     Padding(
                              //       padding: const EdgeInsets.fromLTRB(
                              //         0,
                              //         8,
                              //         16,
                              //         0,
                              //       ),
                              //       child: Container(
                              //         width: 85.w,
                              //
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.circular(50),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: MyColors.grayEA.withValues(
                              //                 alpha: 0.32,
                              //               ),
                              //               blurRadius: 4,
                              //             ),
                              //           ],
                              //         ),
                              //         child: CommonTextField(
                              //           onChange: (value) {
                              //             //controller.onSearchChanged(value ?? "");
                              //           },
                              //           borderRadius: 50,
                              //           hintText: 'Search for',
                              //           prefixIcon: SvgPicture.asset(
                              //             Asset.searchIcon,
                              //             height: 16,
                              //             width: 16,
                              //           ),
                              //           suffixIcon: SvgPicture.asset(
                              //             Asset.filter,
                              //             height: 16,
                              //             width: 16,
                              //           ),
                              //           //controller: controller.searchController,
                              //           /*suffixIcon: Obx(
                              //     () => controller.searchQuery.value.isNotEmpty
                              //         ? GestureDetector(
                              //             onTap: controller.clearSearch,
                              //             child: const Icon(
                              //               Icons.clear,
                              //               color: MyColors.gray54,
                              //             ),
                              //           )
                              //         : const SizedBox.shrink(),
                              //   ), */
                              //         ),
                              //       ),
                              //     ),
                              //     const Spacer(),
                              //     // GestureDetector(
                              //     //   onTap: () {
                              //     //     //Get.toNamed(Routes.NEWS);
                              //     //   },
                              //     //   child: Container(
                              //     //     padding: const EdgeInsets.all(6),
                              //     //     decoration: BoxDecoration(
                              //     //       color: MyColors.white,
                              //     //       border: Border.all(
                              //     //         color: MyColors.custom('EAEAEA'),
                              //     //       ),
                              //     //       shape: BoxShape.circle,
                              //     //     ),
                              //     //     child: SvgPicture.asset(
                              //     //       Asset.location,
                              //     //       width: 16,
                              //     //       height: 16,
                              //     //       colorFilter: ColorFilter.mode(
                              //     //         MyColors.black,
                              //     //         BlendMode.srcIn,
                              //     //       ),
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     // const Gap(1),
                              //     // GestureDetector(
                              //     //   onTap: () {
                              //     //     //Get.toNamed(Routes.NEWS);
                              //     //   },
                              //     //   child: Container(
                              //     //     padding: const EdgeInsets.all(6),
                              //     //     decoration: BoxDecoration(
                              //     //       color: MyColors.white,
                              //     //       border: Border.all(
                              //     //         color: MyColors.custom('EAEAEA'),
                              //     //       ),
                              //     //       shape: BoxShape.circle,
                              //     //     ),
                              //     //     child: SvgPicture.asset(
                              //     //       Asset.filter,
                              //     //       width: 16,
                              //     //       height: 16,
                              //     //       colorFilter: ColorFilter.mode(
                              //     //         MyColors.black,
                              //     //         BlendMode.srcIn,
                              //     //       ),
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),
                              // const Gap(24),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //     vertical: 11,
                              //     horizontal: 12,
                              //   ),
                              //   width: double.maxFinite,
                              //   decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.all(
                              //       Radius.circular(20),
                              //     ),
                              //     border: Border.all(
                              //       color: const Color(0xFFDADADA),
                              //       width: 1.0,
                              //     ),
                              //     gradient: const LinearGradient(
                              //       begin: Alignment.topCenter,
                              //       end: Alignment.bottomCenter,
                              //       colors: [Color(0xFFFFF9BE), Colors.white],
                              //     ),
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Image.asset(
                              //         Asset.connFlow,
                              //         width: 20.w,
                              //         fit: BoxFit.contain,
                              //       ),
                              //       const SizedBox(width: 13),
                              //       Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             "Total Materials",
                              //             style: MyTexts.bold13.copyWith(
                              //               color: MyColors.primary,
                              //             ),
                              //           ),
                              //           const SizedBox(height: 3),
                              //           Text(
                              //             "3200",
                              //             style: MyTexts.bold24.copyWith(
                              //               fontSize: 36,
                              //               color: const Color(0xFF058200),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       const Spacer(),
                              //       Image.asset(
                              //         Asset.connGraph,
                              //         width: 17.w,
                              //         fit: BoxFit.contain,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //
                              //   height: 2.h,
                              //   decoration: BoxDecoration(
                              //     gradient: LinearGradient(
                              //       begin: AlignmentGeometry.topCenter,
                              //       end: AlignmentGeometry.bottomCenter,
                              //       colors: [
                              //         MyColors.custom(
                              //           'FFF9BD',
                              //         ).withValues(alpha: 0.1),
                              //         Colors.white,
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Obx(() {
                                if (Get.find<ConnectorHomeController>().marketPlace.value ==
                                    0) {
                                  /// ------------------- MATERIAL MARKETPLACE -------------------
                                  final materialList = controller.mainCategories;

                                  if (materialList.isEmpty) {
                                    return _buildComingSoon(context);
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.mainCategories.length,
                                    itemBuilder: (context, index) {
                                      final mainCategory = controller.mainCategories[index];
                                      final categories =
                                          controller.categoryMap[mainCategory.id] ?? [];

                                      return _buildCategorySection(
                                        context,
                                        mainCategory,
                                        categories,
                                        route: Routes.SELECT_PRODUCT,
                                      );
                                    },
                                  );
                                } else if (Get.find<CommonController>().marketPlace.value ==
                                    1) {
                                  /// ------------------- CONSTRUCTION MARKETPLACE -------------------
                                  final materialList = controller.mainCategories;

                                  if (materialList.isEmpty) {
                                    return _buildComingSoon(context);
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.mainCategories.length,
                                    itemBuilder: (context, index) {
                                      final mainCategory = controller.mainCategories[index];
                                      final categories =
                                          controller.categoryMap[mainCategory.id] ?? [];

                                      return _buildCategorySection(
                                        context,
                                        mainCategory,
                                        categories,
                                        route: Routes.SELECT_PRODUCT,
                                      );
                                    },
                                  );
                                  // final serviceList = controller
                                  //     .categoryHierarchyData
                                  //     .value
                                  //     .data;
                                  //
                                  // if (serviceList == null ||
                                  //     serviceList.isEmpty) {
                                  //   return _buildComingSoon(context);
                                  // }
                                  // return const Text(
                                  //   "CONSTRUCTION MARKETPLACE",
                                  // );

                                  // return _buildServiceList(
                                  //   context,
                                  //   serviceList,
                                  // );
                                } else {
                                  /// ------------------- TOOLS MARKETPLACE -------------------
                                  final toolsList =
                                      controller.categoryHierarchyData2.value.data;

                                  if (toolsList == null || toolsList.isEmpty) {
                                    return _buildComingSoon(context);
                                  }
                                  return const Text("TOOLS MARKETPLACE");

                                  // return _buildToolsList(context, toolsList);
                                }
                              }),
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
        ),
      ),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
        child: const Text("Coming soon"),
      ),
    );
  }

  /// ============================
  /// COMMON CATEGORY SECTION BUILDER
  /// ============================
  Widget _buildCategorySection(
    BuildContext context,
    dynamic mainCategory,
    List<CCategory> category, {
    required String route,
  }) {
    // final category = controller
    //     .categoryData
    //     .value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // if (myPref.role.val == "connector") {
            //   if ((Get.find<CommonController>()
            //               .profileData
            //               .value
            //               .data
            //               ?.siteLocations ??
            //           [])
            //       .isEmpty) {
            //     _showAddAddressDialog();
            //     return;
            //   }
            // }
            // Get.toNamed(
            //   route,
            //   arguments: {
            //     "mainCategoryId": mainCategory.id ?? 0,
            //     "mainCategoryName": mainCategory.name ?? '',
            //   },
            // );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  mainCategory.name ?? '',
                  style: MyTexts.bold18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        SizedBox(height: 2.h),

        // if(category.data!=null)
        //     Text("${category.data?.length??0}"),
        //     Text("${category.data?.length??0}"),
        if (category.isNotEmpty)
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 6,
              childAspectRatio: 0.45,
            ),
            itemCount: category.length,
            itemBuilder: (context, subIndex) {
              final subCategory = category[subIndex];

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: GestureDetector(
                  onTap: () {
                    // if (myPref.role.val == "connector") {
                    //   if ((Get.find<CommonController>()
                    //               .profileData
                    //               .value
                    //               .data
                    //               ?.siteLocations ??
                    //           [])
                    //       .isEmpty) {
                    //     _showAddAddressDialog();
                    //     return;
                    //   }
                    // }
                    Get.to(
                      SubCategoryScreen(),
                      arguments: {
                        "selectedSubCategoryIdIndex": subIndex ?? 0,
                        "categoryData": category,
                        "mainCategoryName": mainCategory.name ?? '',
                      },
                    );
                    // Get.toNamed(
                    //   route,
                    //   arguments: {
                    //     "selectedSubCategoryId":  0,
                    //     "mainCategoryId":  0,
                    //     "mainCategoryName": mainCategory.name ?? '',
                    //   },
                    // );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColors.lightWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(60), // more rounded bottom
                        bottomRight: Radius.circular(60), // more rounded bottom
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 🔹 Title
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            subCategory.name ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                          ),
                        ),

                        /// 🔹 Circular Image (Large & Bottom Aligned)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    subCategory.image?.url ?? "https://via.placeholder.com/150",
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.category, size: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget tabBar({
    required String? iconUrl,
    required String name,
    required bool isMarketPlace,
    required void Function()? onTap,
  }) {
    return SizedBox(
      width: 22.w,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isMarketPlace
                ? Colors
                      .white // 👈 Selected color
                : null, // 👈 Unselected color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconUrl != null && iconUrl!.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: iconUrl!,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.image, size: 24),
                )
              else
                const SizedBox(height: 24, width: 24),
              const SizedBox(height: 6),
              Text(
                name,
                style: MyTexts.medium14.copyWith(color: isMarketPlace ? Colors.black : Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String _getIconFromModule(ModuleModel? module) {
    switch (module?.name?.toLowerCase()) {
      case 'material':
        return Asset.MM;
      case 'construction':
        return Asset.CM;
      case 'design':
        return Asset.design1;
      case 'fleet':
        return Asset.fleet;
      case 'tools':
        return Asset.TEM;
      case 'equipment':
        return Asset.equipment;
      case 'ppe':
        return Asset.ppe;
      default:
        return Asset.add;
    }
  }
}

class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyTexts.medium17.copyWith(color: MyColors.black, fontFamily: MyTexts.SpaceGrotesk),
    );
  }
}
