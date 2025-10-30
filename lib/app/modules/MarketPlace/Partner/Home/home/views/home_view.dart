import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  final CommonController commonController = Get.find();
  final HomeController controller = Get.find<HomeController>();

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Center(
                  child: Text(
                    "MarketPlace",
                    style: MyTexts.bold20.copyWith(color: MyColors.primary),
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tabBar(
                          onTap: () {
                            controller.marketPlace.value = 0;
                          },
                          icon: Asset.MM,
                          name: 'Material\nMarketplace',
                          isMarketPlace: controller.marketPlace.value == 0,
                        ),
                        tabBar(
                          onTap: () {
                            controller.marketPlace.value = 1;
                          },
                          icon: Asset.CM,
                          name: 'Construction line\nMarketplace',
                          isMarketPlace: controller.marketPlace.value == 1,
                        ),
                        tabBar(
                          onTap: () {
                            controller.marketPlace.value = 2;
                          },
                          icon: Asset.TEM,
                          name: 'Tools & equipment\nMarketplace',
                          isMarketPlace: controller.marketPlace.value == 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Gap(24),
                              // Text(
                              //   "All Category",
                              //   style: MyTexts.bold20.copyWith(color: MyColors.primary),
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(24),
                              //     border: Border.all(
                              //       color: MyColors.custom('EAEAEA'),
                              //       width: 2,
                              //     ),
                              //   ),
                              //   child: Center(
                              //     child: Text(
                              //       'Waiting for banner content',
                              //       style: MyTexts.medium16,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 2.h),
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
                                  physics: const NeverScrollableScrollPhysics(),
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
                                            if (myPref.role.val ==
                                                "connector") {
                                              if ((controller
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
                                                        mainCategory.id ?? 0,
                                                    "mainCategoryName":
                                                        mainCategory.name ?? '',
                                                  },
                                                );
                                              } else {
                                                Get.dialog(
                                                  AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                    ),
                                                    title: const Text(
                                                      "Add Your Address",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    content: const Text(
                                                      "To view a product, please add your address first.",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                          Get.toNamed(
                                                            Routes
                                                                .DELIVERY_LOCATION,
                                                          );
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          "Add Address",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  barrierDismissible: false,
                                                );
                                              }
                                            } else {
                                              Get.toNamed(
                                                Routes.SELECT_PRODUCT,
                                                arguments: {
                                                  "mainCategoryId":
                                                      mainCategory.id ?? 0,
                                                  "mainCategoryName":
                                                      mainCategory.name ?? '',
                                                },
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                  if (myPref.role.val ==
                                                      "connector") {
                                                    if ((controller
                                                                .profileData
                                                                .value
                                                                .data
                                                                ?.siteLocations ??
                                                            [])
                                                        .isNotEmpty) {
                                                      Get.toNamed(
                                                        Routes.SELECT_PRODUCT,
                                                        arguments: {
                                                          "selectedSubCategoryId":
                                                              subCategory.id ??
                                                              0,
                                                          "mainCategoryId":
                                                              mainCategory.id ??
                                                              0,
                                                          "mainCategoryName":
                                                              mainCategory
                                                                  .name ??
                                                              '',
                                                        },
                                                      );
                                                    } else {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  16,
                                                                ),
                                                          ),
                                                          title: const Text(
                                                            "Add Your Address",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          content: const Text(
                                                            "To view a product, please add your address first.",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                                Get.toNamed(
                                                                  Routes
                                                                      .DELIVERY_LOCATION,
                                                                );
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                "Add Address",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        barrierDismissible:
                                                            false,
                                                      );
                                                    }
                                                  } else {
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
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                              ).withOpacity(0),
                                                              MyColors.custom(
                                                                'EAEAEA',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
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
                                                                width: double
                                                                    .infinity,
                                                                fit:
                                                                    BoxFit.fill,
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
                                                                      size: 24,
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
                                                          style:
                                                              MyTexts.medium14,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        SizedBox(height: 2.h),
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
      style: MyTexts.medium17.copyWith(
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
