import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/controllers/construction_service_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/views/merchant_project_view_details.dart';

class MerchantHomeView extends StatelessWidget {
  final CommonController commonController = Get.find();
  final HomeController controller = Get.put(HomeController());

  static const double _selectionBarWidth = 5.0;
  static const double _leftPanelWidth = 0.27;
  static const double _itemHeight = 120.0;
  static const double _imageHeight = 80.0;

  static const double _horizontalPadding = 10.0;
  static const double _itemSpacing = 8.0;
  static const Color _sidebarBgColor = Color(0xFFF8F9FA);
  static const Color _itemBgColor = Color(0xFFFAFBFF);
  static const Color _borderColor = Color(0xFFE9ECEF);
  static const Color _dividerColor = Color(0xFFEAEAEA);

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
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
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                      Padding(
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
                      ),
                    ],
                  ),
                  const Divider(thickness: 1.0, color: MyColors.gra54EA),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildSideBar(context),
                        const Gap(4),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFilterButtons(context),
                              const Gap(4),
                              Flexible(
                                child: Obx(() {
                                  return controller.isGridView.value
                                      ? _buildServicesGrid(context)
                                      : buildMaterialListView(context);
                                }),
                              ),
                              //_buildServicesGrid(context)),
                            ],
                          ),
                        ),
                        const Gap(4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton({
    required String label,
    required String iconPath,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: MyTexts.medium14.copyWith(
                color: MyColors.custom('2E2E2E'),
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(iconPath, width: 16, height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    //final controller = Get.find<ConstructionServiceController>();
    return Row(
      children: [
        const Gap(4),
        _buildFilterButton(
          label: 'Sort',
          iconPath: Asset.sort,
          // onTap: () => controller.showSortBottomSheet(context),
        ),
        const Gap(4),
        _buildFilterButton(
          label: 'Radius',
          iconPath: Asset.location,
          //onTap: () => controller.showLocationBottomSheet(context),
        ),
        const Gap(4),
        _buildFilterButton(
          label: 'Filter',
          iconPath: Asset.filter,
          //onTap: () => controller.showLocationBottomSheet(context),
        ),
        const Spacer(),
        const Gap(4),
        GestureDetector(
          onTap: () =>
              controller.isGridView.value = !controller.isGridView.value,
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Obx(() {
              return Icon(
                controller.isGridView.value ? Icons.list : Icons.grid_view,
                size: 20,
                color: MyColors.custom('2E2E2E'),
              );
            }),
          ),
        ),

        const Gap(4),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    // final controller = Get.find<ConstructionServiceController>();
    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        childAspectRatio: .45,
        crossAxisSpacing: 8,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2.w)),
                border: Border.all(color: MyColors.gra54EA, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 12.h,
                        width: double.infinity,
                        child: ClipRRect(
                          child: Image.asset(Asset.building, fit: BoxFit.cover),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(11),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 13,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "32 KM",
                              style: MyTexts.regular12.copyWith(fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    "Luna;s Traquil Project",
                    style: MyTexts.bold12.copyWith(fontSize: 13.sp),
                  ),
                  SizedBox(height: 0.8.h),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Asset.renovation,
                          width: 6.w,
                          height: 6.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        "Saanvi Kumari",
                        style: MyTexts.medium12.copyWith(
                          color: const Color(0xFF545454),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: const Color(0xFF545454),
                        size: 12.sp,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          "Jayanagar ,bng 560078 ",
                          style: MyTexts.regular12.copyWith(
                            color: const Color(0xFF545454),
                            fontSize: 10.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(7),
                  Container(
                    height: 38,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topCenter,
                        end: AlignmentGeometry.bottomCenter,
                        colors: [
                          const Color(0xFFFFF9BD).withValues(alpha: 0),
                          const Color(0xFFFFF9BD),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("₹ 1600 Sqft", style: MyTexts.medium15),
                    ),
                  ),
                  const Gap(6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: RoundedButton(
                      buttonName: "Connect",
                      onTap: () {},
                      height: 4.h,
                      fontSize: 13.sp,
                      borderRadius: 1.5.w,
                      style: MyTexts.medium13.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 13,
                width: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFC1FFC3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Ongoing",
                    style: MyTexts.regular12.copyWith(fontSize: 8),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildMaterialListView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            border: Border.all(color: MyColors.gra54EA, width: 1.0),
          ),
          //width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Asset.building,
                height: 13.5.h,
                width: 28.w,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Luna;s Traquil Project",
                      style: MyTexts.bold12.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),

                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            Asset.renovation,
                            width: 6.w,
                            height: 6.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          "Saanvi Kumari",
                          style: MyTexts.medium12.copyWith(
                            color: const Color(0xFF545454),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: const Color(0xFF545454),
                          size: 12.sp,
                        ),
                        const Gap(2),
                        Text(
                          "Jayanagar ,bng 560078 ",
                          style: MyTexts.regular12.copyWith(
                            color: const Color(0xFF545454),
                            fontSize: 10.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const Gap(7),
                    Container(
                      height: 38,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [
                            const Color(0xFFFFF9BD).withValues(alpha: 0),
                            const Color(0xFFFFF9BD),
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("₹ 1600 Sqft", style: MyTexts.medium15),
                      ),
                    ),
                    const Gap(6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: RoundedButton(
                        buttonName: "Connect",
                        onTap: () {
                          Get.to(() => MerchantProjectViewDetails());
                        },
                        height: 4.h,
                        fontSize: 13.sp,
                        borderRadius: 1.5.w,
                        style: MyTexts.medium13.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<String> _imageURL = [
    Asset.residential,
    Asset.commercial,
    Asset.industrial,
    Asset.infrastructure,
    Asset.renovation,
    Asset.renovation,
  ];
  final List<String> _imageNames = [
    "Residential",
    "Commercial",
    "Industrial",
    "Infrastructure",
    "Renovation",
    "Manufacturer",
  ];
  Widget buildSideBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * _leftPanelWidth,

      decoration: const BoxDecoration(
        color: _sidebarBgColor,
        border: Border(right: BorderSide(color: _borderColor)),
      ),
      child: ListView.separated(
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: _itemHeight,
            color: _itemBgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: _selectionBarWidth,
                      height: _imageHeight,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                        color: MyColors.primary,
                      ),
                    ),
                    const SizedBox(width: _selectionBarWidth),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: _imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: [
                              MyColors.custom('EAEAEA').withValues(alpha: 0),
                              MyColors.custom('EAEAEA'),
                            ],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalPadding,
                              ),
                              child: Image.asset(_imageURL[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(right: _horizontalPadding),
                const SizedBox(height: _itemSpacing),
                Text(
                  _imageNames[index],
                  style: MyTexts.medium13,
                  textAlign: TextAlign.center,
                ).paddingOnly(
                  right: _horizontalPadding,
                  left: _horizontalPadding,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: _dividerColor, thickness: 1),
        itemCount: 6,
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
    return GestureDetector(
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
