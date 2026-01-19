import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final CommonController commonController = Get.find();
  final HomeController controller = Get.put(HomeController());

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
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: MyColors.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: SizedBox(
          height: height,
          width: width,
          // decoration: const BoxDecoration(color: MyColors.grayD4, shape: BoxShape.circle),
          child: Image.asset(
            Asset.appLogo,
            height: height,
            width: width,
            fit: BoxFit.contain,
          ),
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
          backgroundColor: MyColors.white,
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
              Column(
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
                                : commonController
                                          .profileData
                                          .value
                                          .data
                                          ?.user
                                          ?.image ??
                                      '';

                            if (profileImage.isEmpty) {
                              return const Icon(
                                Icons.account_circle_sharp,
                                color: Colors.black,
                                size: 48,
                              );
                            }

                            return ClipOval(
                              child: getImageView(
                                finalUrl:
                                    "${APIConstants.bucketUrl}$profileImage",
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
                                final isTeamLogin = myPref.getIsTeamLogin();

                                final firstName = isTeamLogin
                                    ? commonController
                                              .profileData
                                              .value
                                              .data
                                              ?.teamMember
                                              ?.firstName ??
                                          ''
                                    : commonController
                                              .profileData
                                              .value
                                              .data
                                              ?.user
                                              ?.firstName ??
                                          '';

                                final lastName = isTeamLogin
                                    ? commonController
                                              .profileData
                                              .value
                                              .data
                                              ?.teamMember
                                              ?.lastName ??
                                          ''
                                    : commonController
                                              .profileData
                                              .value
                                              .data
                                              ?.user
                                              ?.lastName ??
                                          '';

                                return RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${firstName.capitalizeFirst} ${lastName.capitalizeFirst}!',
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
                                          Get.toNamed(
                                            Routes.MANUFACTURER_ADDRESS,
                                          );
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
                                                text: commonController
                                                    .getCurrentAddress()
                                                    .value,
                                              ),
                                              const WidgetSpan(
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
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NEWS);
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
                              Asset.info,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                MyColors.black,
                                BlendMode.srcIn,
                              ),
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
                              border: Border.all(
                                color: MyColors.custom('EAEAEA'),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              Asset.chat,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                MyColors.black,
                                BlendMode.srcIn,
                              ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    0;
                              },
                              icon: Asset.MM,
                              name: 'Material',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  0,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    1;
                              },
                              icon: Asset.CM,
                              name: 'Construction',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  1,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    2;
                              },
                              icon: Asset.design1,
                              name: 'Design',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  2,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    3;
                              },
                              icon: Asset.fleet,
                              name: 'Fleet',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  3,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    4;
                              },
                              icon: Asset.TEM,
                              name: 'Tools',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  4,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    5;
                              },
                              icon: Asset.equipment,
                              name: 'Equipment',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  5,
                            ),
                            const Gap(12),
                            tabBar(
                              onTap: () {
                                hideKeyboard();
                                Get.find<CommonController>().marketPlace.value =
                                    6;
                              },
                              icon: Asset.ppe,
                              name: 'PPE',
                              isMarketPlace:
                                  Get.find<CommonController>()
                                      .marketPlace
                                      .value ==
                                  6,
                            ),
                            const Gap(12),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(24),

                  //const Gap(10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    8,
                                    16,
                                    0,
                                  ),
                                  child: Container(
                                    width: 70.w,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
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
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    //Get.toNamed(Routes.NEWS);
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
                                      Asset.location,
                                      width: 16,
                                      height: 16,
                                      colorFilter: ColorFilter.mode(
                                        MyColors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(7),
                                GestureDetector(
                                  onTap: () {
                                    //Get.toNamed(Routes.NEWS);
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
                                      Asset.filter,
                                      width: 16,
                                      height: 16,
                                      colorFilter: ColorFilter.mode(
                                        MyColors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Gap(24),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 11,
                                horizontal: 12,
                              ),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: const Color(0xFFDADADA),
                                  width: 1.0,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFFFFF9BE), Colors.white],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    Asset.connFlow,
                                    width: 20.w,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 13),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Materials",
                                        style: MyTexts.bold13.copyWith(
                                          color: MyColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        "3200",
                                        style: MyTexts.bold24.copyWith(
                                          fontSize: 36,
                                          color: const Color(0xFF058200),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    Asset.connGraph,
                                    width: 17.w,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 2.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                  colors: [
                                    MyColors.custom(
                                      'FFF9BD',
                                    ).withValues(alpha: 0.1),
                                    MyColors.white,
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  if (Get.find<CommonController>()
                                          .marketPlace
                                          .value ==
                                      0) {
                                    /// ------------------- MATERIAL MARKETPLACE -------------------
                                    final materialList = controller
                                        .categoryHierarchyData
                                        .value
                                        .data;

                                    if (materialList == null ||
                                        materialList.isEmpty) {
                                      return _buildComingSoon(context);
                                    }

                                    return _buildMaterialList(
                                      context,
                                      materialList,
                                    );
                                  } else if (Get.find<CommonController>()
                                          .marketPlace
                                          .value ==
                                      1) {
                                    /// ------------------- CONSTRUCTION MARKETPLACE -------------------
                                    final serviceList = controller
                                        .categoryHierarchyDataCM
                                        .value
                                        .data;

                                    if (serviceList == null ||
                                        serviceList.isEmpty) {
                                      return _buildComingSoon(context);
                                    }

                                    return _buildServiceList(
                                      context,
                                      serviceList,
                                    );
                                  } else {
                                    /// ------------------- TOOLS MARKETPLACE -------------------
                                    final toolsList = controller
                                        .categoryHierarchyData2
                                        .value
                                        .data;

                                    if (toolsList == null ||
                                        toolsList.isEmpty) {
                                      return _buildComingSoon(context);
                                    }

                                    return _buildToolsList(context, toolsList);
                                  }
                                }),
                              ],
                            ),
                          ],
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
  /// MATERIAL MARKETPLACE VIEW
  /// ============================
  Widget _buildMaterialList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, mainIndex) {
        final mainCategory = data[mainIndex];

        return _buildCategorySection(
          context,
          mainCategory,
          route: Routes.SELECT_PRODUCT,
        );
      },
    );
  }

  /// ============================
  /// CONSTRUCTION MARKETPLACE VIEW
  /// ============================
  Widget _buildServiceList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, mainIndex) {
        final mainCategory = data[mainIndex];
        return _buildCategorySection(
          context,
          mainCategory,
          route: Routes.SELECT_SERVICE,
        );
      },
    );
  }

  /// ============================
  /// TOOLS & EQUIPMENT MARKETPLACE VIEW
  /// ============================
  Widget _buildToolsList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, mainIndex) {
        final mainCategory = data[mainIndex];
        return _buildCategorySection(
          context,
          mainCategory,
          route: Routes.SEARCH_SERVICE, // create this route if not already
        );
      },
    );
  }

  /// ============================
  /// COMMON CATEGORY SECTION BUILDER
  /// ============================
  Widget _buildCategorySection(
    BuildContext context,
    dynamic mainCategory, {
    required String route,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (myPref.role.val == "connector") {
              if ((Get.find<CommonController>()
                          .profileData
                          .value
                          .data
                          ?.siteLocations ??
                      [])
                  .isEmpty) {
                _showAddAddressDialog();
                return;
              }
            }

            Get.toNamed(
              route,
              arguments: {
                "mainCategoryId": mainCategory.id ?? 0,
                "mainCategoryName": mainCategory.name ?? '',
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(mainCategory.name ?? '', style: MyTexts.bold18),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        SizedBox(height: 2.h),

        if (mainCategory.subCategories != null)
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 6,
              childAspectRatio: 0.8,
            ),
            itemCount: mainCategory.subCategories!.length,
            itemBuilder: (context, subIndex) {
              final subCategory = mainCategory.subCategories![subIndex];

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: GestureDetector(
                  onTap: () {
                    if (myPref.role.val == "connector") {
                      if ((Get.find<CommonController>()
                                  .profileData
                                  .value
                                  .data
                                  ?.siteLocations ??
                              [])
                          .isEmpty) {
                        _showAddAddressDialog();
                        return;
                      }
                    }

                    Get.toNamed(
                      route,
                      arguments: {
                        "selectedSubCategoryId": subCategory.id ?? 0,
                        "mainCategoryId": mainCategory.id ?? 0,
                        "mainCategoryName": mainCategory.name ?? '',
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                APIConstants.bucketUrl +
                                (subCategory.image ??
                                    'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg'),
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.category,
                              color: MyColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subCategory.name ?? '',
                        style: MyTexts.medium14,
                        textAlign: TextAlign.center,
                      ),
                    ],
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
    required String icon,
    required String name,
    required bool isMarketPlace,
    required void Function()? onTap,
  }) {
    return SizedBox(
      width: 22.w,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(icon, height: 24, width: 24),
            Text(name, style: MyTexts.medium14, textAlign: TextAlign.center),
            const Gap(10),
            if (isMarketPlace)
              Container(
                height: 3,
                width: 73,
                decoration: const BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
              )
            else
              const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Add Your Address",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: const Text(
          "To view a product, please add your address first.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.DELIVERY_LOCATION);
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
  }
}

class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyTexts.medium17.copyWith(
        color: MyColors.black,
        fontFamily: MyTexts.SpaceGrotesk,
      ),
    );
  }
}
