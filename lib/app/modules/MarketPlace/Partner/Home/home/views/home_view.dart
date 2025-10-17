import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/FeatureDashBoard/Dashboard/views/dashboard_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put<HomeController>(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
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
                              onTap: () {
                                final addresses =
                                    controller.addressData.data?.addresses ??
                                    [];

                                if (addresses.isEmpty) {
                                  Get.snackbar(
                                    "No Address",
                                    "Please add an address first",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  return;
                                }

                                final officeAddress = addresses.firstWhere(
                                  (a) =>
                                      a.addressType?.toLowerCase() == 'office',
                                  orElse: () => Address(),
                                );

                                final factoryAddress = addresses.firstWhere(
                                  (a) =>
                                      a.addressType?.toLowerCase() == 'factory',
                                  orElse: () => Address(),
                                );

                                showModalBottomSheet(
                                  context: Get.context!,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Select Address",
                                              style: MyTexts.extraBold18
                                                  .copyWith(
                                                    color: MyColors.black,
                                                  ),
                                            ),
                                            const SizedBox(height: 16),
                                            IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        officeAddress
                                                                .addressType !=
                                                            null
                                                        ? _addressCard(
                                                            address:
                                                                officeAddress,
                                                            addressType:
                                                                officeAddress
                                                                    .addressType,
                                                            isSelected:
                                                                controller
                                                                    .isDefaultOffice
                                                                    .value ==
                                                                true,
                                                          )
                                                        : Container(),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child:
                                                        factoryAddress
                                                                .addressType !=
                                                            null
                                                        ? _addressCard(
                                                            address:
                                                                factoryAddress,
                                                            addressType:
                                                                factoryAddress
                                                                    .addressType,
                                                            isSelected:
                                                                controller
                                                                    .isDefaultOffice
                                                                    .value ==
                                                                false,
                                                          )
                                                        : Container(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
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
                                              text: controller
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
                ),
                const Gap(24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
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
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 17,
                                      childAspectRatio: itemWidth / itemHeight,
                                    ),
                                itemBuilder: (context, index) {
                                  final item = controller.features[index];

                                  return Obx(() {
                                    final isSelected =
                                        controller.selectedIndex.value == index;
                                    return BuildFeatureCard(
                                      isSelected: isSelected,
                                      item: item,
                                      itemWidth: itemWidth,
                                      onTap: () {
                                        if (index == 0 || index == 1) {
                                          controller.selectedIndex.value =
                                              index;
                                        }
                                      },
                                    );
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(height: 3.5.h),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tabBar(
                                  onTap: () {
                                    controller.marketPlace.value = 0;
                                  },
                                  icon: Asset.MM,
                                  name: 'Material\nMarketplace',
                                  isMarketPlace:
                                      controller.marketPlace.value == 0,
                                ),
                                tabBar(
                                  onTap: () {
                                    controller.marketPlace.value = 1;
                                  },
                                  icon: Asset.CM,
                                  name: 'Construction line\nMarketplace',
                                  isMarketPlace:
                                      controller.marketPlace.value == 1,
                                ),
                                tabBar(
                                  onTap: () {
                                    controller.marketPlace.value = 2;
                                  },
                                  icon: Asset.TEM,
                                  name: 'Tools & equipment\nMarketplace',
                                  isMarketPlace:
                                      controller.marketPlace.value == 2,
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
                                  MyColors.custom('FFF9BD').withOpacity(0.1),
                                  MyColors.white,
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: MyColors.custom('EAEAEA'),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Waiting for banner content',
                                    style: MyTexts.medium16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              // Main Categories ListView
                              Obx(() {
                                if (controller
                                            .categoryHierarchyData
                                            .value
                                            .data ==
                                        null ||
                                    controller
                                        .categoryHierarchyData
                                        .value
                                        .data!
                                        .isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .categoryHierarchyData
                                      .value
                                      .data!
                                      .length,
                                  itemBuilder: (context, mainIndex) {
                                    final mainCategory = controller
                                        .categoryHierarchyData
                                        .value
                                        .data![mainIndex];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.SELECT_PRODUCT,
                                              arguments: {
                                                "mainCategoryId":
                                                    mainCategory.id ?? 0,
                                                "mainCategoryName":
                                                    mainCategory.name ?? '',
                                              },
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                '${mainCategory.name ?? ''}  ',
                                                style: MyTexts.bold18,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        if (mainCategory.subCategories !=
                                                null &&
                                            mainCategory
                                                .subCategories!
                                                .isNotEmpty)
                                          GridView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 12,
                                                  mainAxisSpacing: 6,
                                                  childAspectRatio: 0.8,
                                                ),
                                            itemCount: mainCategory
                                                .subCategories!
                                                .length,
                                            itemBuilder: (context, subIndex) {
                                              final subCategory = mainCategory
                                                  .subCategories![subIndex];
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                    Routes.SELECT_PRODUCT,
                                                    arguments: {
                                                      "selectedSubCategoryId":
                                                          subCategory.id ?? 0,
                                                      "mainCategoryId":
                                                          mainCategory.id ??
                                                          0,
                                                      "mainCategoryName":
                                                          mainCategory.name ??
                                                          '',
                                                    },
                                                  );
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                          gradient: LinearGradient(
                                                            end: Alignment
                                                                .bottomCenter,
                                                            begin: Alignment
                                                                .topCenter,
                                                            colors: [
                                                              MyColors.custom(
                                                                'EAEAEA',
                                                              ).withOpacity(
                                                                0,
                                                              ),
                                                              MyColors.custom(
                                                                'EAEAEA',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                  ),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                    APIConstants
                                                                        .bucketUrl +
                                                                    (subCategory
                                                                            .image ??
                                                                        ''),
                                                                fit: BoxFit
                                                                    .fill,
                                                                placeholder:
                                                                    (
                                                                      context,
                                                                      url,
                                                                    ) => const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                errorWidget:
                                                                    (
                                                                      context,
                                                                      url,
                                                                      error,
                                                                    ) => const Icon(
                                                                      Icons
                                                                          .category,
                                                                      color: MyColors
                                                                          .primary,
                                                                      size:
                                                                          24,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    SizedBox(
                                                      height: 50,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 4,
                                                            ),
                                                        child: Text(
                                                          subCategory.name ??
                                                              '',
                                                          style: MyTexts
                                                              .medium14,
                                                          textAlign: TextAlign
                                                              .center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                      ],
                                    );
                                  },
                                );
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

  Widget _addressCard({
    Address? address,
    String? addressType,
    bool isSelected = false,
  }) {
    final displayText =
        "${address?.addressLine1}, ${address?.addressLine2}, ${address?.landmark}, ${address?.city}, ${address?.state} , ${address?.pinCode}";
    return GestureDetector(
      onTap: () {
        if (addressType == "office") {
          myPref.setDefaultAdd(true);
          controller.isDefaultOffice.value = true;
          controller.isDefaultOffice.refresh();
        } else {
          myPref.setDefaultAdd(false);
          controller.isDefaultOffice.value = false;
          controller.isDefaultOffice.refresh();
        }
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: MyColors.white,
          border: Border.all(
            color: isSelected ? MyColors.primary : MyColors.grayD4,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  addressType ?? "",
                  style: MyTexts.medium14.copyWith(color: MyColors.primary),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final Placemark place = Placemark(
                      name: address?.addressLine1,
                      subAdministrativeArea: address?.landmark,
                      postalCode: address?.pinCode,
                      administrativeArea: address?.state,
                      locality: address?.city,
                      street: address?.addressLine2,
                      country: address?.country,
                    );
                    Get.back();
                    Get.toNamed(
                      Routes.ADD_LOCATION_MANUALLY,
                      arguments: {
                        "from": "Home",
                        "isCLocation": place,
                        "isOffice": addressType == "office" ? 0 : 1,
                        "id": address?.id,
                        "latitude": address?.latitude,
                        "longitude": address?.longitude,
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              displayText ?? "",
              style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Widget icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Container(
        width: 180,
        height: 89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayD4),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 0.6.h),
                Text(
                  title,
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,

                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.8.h),
            Text(
              value,
              style: MyTexts.extraBold18.copyWith(
                color: MyColors.textFieldBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotiCard({
    String? title,
    String? value,
    Function()? onTap,
    String? icon,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.greyE5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 4, top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: (color ?? Colors.black).withValues(alpha: 0.3),
                  ),
                  child: SvgPicture.asset(
                    icon ?? "",
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Gap(12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.gray5D,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                  Text(
                    value ?? "",
                    style: MyTexts.bold20.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
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
}

class StaticsCard extends StatefulWidget {
  String? icon;
  String? title;
  String? value;
  Color? color;
  Color? bColor;

  StaticsCard({
    super.key,
    this.icon,
    this.title,
    this.value,
    this.color,
    this.bColor,
  });

  @override
  State<StaticsCard> createState() => _StaticsCardState();
}

class _StaticsCardState extends State<StaticsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        border: Border.all(color: widget.bColor ?? MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SvgPicture.asset(
            widget.icon ?? "",
            height: 20,
            width: 20,
            colorFilter: widget.color == null
                ? null
                : ColorFilter.mode(
                    widget.color ?? Colors.black,
                    BlendMode.srcIn,
                  ),
          ),
          const Gap(6),
          Text(
            widget.title ?? "",
            overflow: TextOverflow.ellipsis,
            style: MyTexts.regular14.copyWith(
              color: MyColors.fontBlack,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          Text(
            widget.value ?? "",
            style: MyTexts.bold16.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderText extends StatefulWidget {
  String text;

  HeaderText({super.key, required this.text});

  @override
  State<HeaderText> createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: MyTexts.medium18.copyWith(
        color: MyColors.black,
        fontFamily: MyTexts.SpaceGrotesk,
      ),
    );
  }
}

final List<int> barCounts = [0, 2, 4, 0, 3, 4, 3, 5, 0, 4, 3, 5];

List<String> _monthNames = [
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
  "Feb",
  "Mar",
];
