import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/view/add_service_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/controller/add_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/components/business_detail_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/controllers/product_detail_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/views/bottom_view.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: (controller.isFromConnector.value == true)
          ? false.obs
          : (controller.isFromAdd.value
                ? Get.find<AddProductController>().isLoading
                : false.obs),
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 24,
            ),
          ),
          isCenter: false,
        ),
        bottomNavigationBar: buildBottom(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    alignment: AlignmentGeometry.topRight,
                    children: [
                      Container(
                        width: 360.w,
                        height: 35.h,
                        decoration: const BoxDecoration(color: MyColors.grayF2),
                        alignment: Alignment.center,
                        child: Obx(() {
                          final isNetwork = controller.isFromAdd.value == false;
                          final List<String> imageUrls = [];
                          String? videoUrl;

                          if (isNetwork) {
                            if (controller.product.images?.isNotEmpty ??
                                false) {
                              imageUrls.addAll(
                                controller.product.images!
                                    .map(
                                      (img) =>
                                          "${APIConstants.bucketUrl}${img.s3Key ?? controller.product.productImage ?? ''}",
                                    )
                                    .toList(),
                              );
                            } else if (controller.product.productImage !=
                                null) {
                              imageUrls.add(
                                "${APIConstants.bucketUrl}${controller.product.productImage!}",
                              );
                            }

                            if (controller.product.productVideo != null &&
                                controller.product.productVideo!.isNotEmpty) {
                              videoUrl =
                                  "${APIConstants.bucketUrl}${controller.product.productVideo!}";
                            }
                          } else {
                            if (controller.product.images?.isNotEmpty ??
                                false) {
                              imageUrls.addAll(
                                controller.product.images!
                                    .map(
                                      (img) =>
                                          img.s3Url ??
                                          controller.product.productImage ??
                                          '',
                                    )
                                    .toList(),
                              );
                            } else if (controller.product.productImage !=
                                null) {
                              imageUrls.add(
                                "${APIConstants.bucketUrl}${controller.product.productImage!}",
                              );
                            }

                            if (controller.product.productVideo != null) {
                              videoUrl = controller.product.productVideo;
                            }
                          }

                          if (imageUrls.isEmpty && videoUrl == null) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey,
                              ),
                            );
                          }

                          final List<Map<String, dynamic>> mediaList = [
                            ...imageUrls.map(
                              (e) => {'type': 'image', 'path': e},
                            ),
                            if (videoUrl != null)
                              {'type': 'video', 'path': videoUrl},
                          ];

                          return Container(
                            height: 35.h,
                            width: 360.w,
                            color: MyColors.white,
                            child: PageView.builder(
                              itemCount: mediaList.length,
                              controller: PageController(),
                              onPageChanged: (index) =>
                                  controller.currentIndex.value = index,
                              itemBuilder: (context, index) {
                                final media = mediaList[index];
                                final path = media['path'] as String;
                                final isHttp = path.startsWith('http');

                                if (media['type'] == 'video') {
                                  return Obx(() {
                                    final videoPlayerController =
                                        controller.videoPlayerController;
                                    final isReady =
                                        controller.isVideoReady.value;

                                    if (isReady &&
                                        videoPlayerController != null &&
                                        videoPlayerController
                                            .value
                                            .isInitialized) {
                                      return GestureDetector(
                                        onTap: () => controller.openVideoDialog(
                                          context,
                                          path,
                                          isHttp,
                                        ),
                                        child: Stack(
                                          alignment: AlignmentGeometry.center,
                                          children: [
                                            ClipRRect(
                                              child: AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: VideoPlayer(
                                                  videoPlayerController,
                                                ),
                                              ),
                                            ),
                                            const VideoPlay(),
                                          ],
                                        ),
                                      );
                                    } else if (videoPlayerController != null &&
                                        videoPlayerController.value.hasError) {
                                      return Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.error_outline,
                                                color: Colors.white,
                                                size: 48,
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                'Failed to load video',
                                                style: MyTexts.medium14
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Video codec may not be supported on this device',
                                                style: MyTexts.medium12
                                                    .copyWith(
                                                      color: Colors.white70,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      controller
                                                          .retryVideoInitialization();
                                                    },
                                                    child: const Text(
                                                      'Retry',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  TextButton(
                                                    onPressed: () {
                                                      final videoPath =
                                                          controller
                                                              .product
                                                              .productVideo ??
                                                          "";
                                                      if (videoPath
                                                          .isNotEmpty) {
                                                        final videoUrl =
                                                            videoPath
                                                                .startsWith(
                                                                  'http',
                                                                )
                                                            ? videoPath
                                                            : APIConstants
                                                                      .bucketUrl +
                                                                  videoPath;
                                                        controller
                                                            .openReferenceUrl(
                                                              videoUrl,
                                                            );
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Open in Browser',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.grey.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
                                //Image
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        insetPadding: const EdgeInsets.all(16),
                                        child: InteractiveViewer(
                                          child: isHttp
                                              ? Image.network(
                                                  path,
                                                  width: 360.w,
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.file(
                                                  File(path),
                                                  fit: BoxFit.contain,
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: isHttp
                                          ? Image.network(
                                              path,
                                              fit: BoxFit.fitHeight,
                                              height: 35.h,
                                              width: 360.w,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.broken_image,
                                                    size: 60,
                                                    color: Colors.grey,
                                                  ),
                                            )
                                          : Image.file(
                                              File(path),
                                              fit: BoxFit.contain,
                                              height: 35.h,
                                              width: 360.w,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),

                      /// =============== SERVICE INFO SECTION ===============
                      if (myPref.role.val == "connector")
                        Obx(() {
                          return (controller.isFromAdd.value == false &&
                                  controller.isFromConnector.value == false)
                              ? const SizedBox()
                              : !(controller.isFromAdd.value == true &&
                                    controller.isFromConnector.value == false)
                              ? Container(
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.white,
                                  ),
                                  child: Obx(() {
                                    return GestureDetector(
                                      onTap: () async {
                                        await Get.find<HomeController>()
                                            .wishListApi(
                                              status:
                                                  controller.isLiked.value ==
                                                      true
                                                  ? "remove"
                                                  : "add",
                                              mID: controller.product.id ?? 0,
                                              onSuccess: () {
                                                controller.onApiCall?.call();
                                              },
                                            );
                                        controller.isLiked.value =
                                            !controller.isLiked.value;
                                      },
                                      child: Icon(
                                        (controller.isLiked.value)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 24,
                                        color: controller.isLiked.value
                                            ? MyColors.custom('E53D26')
                                            : MyColors.gray54,
                                      ),
                                    );
                                  }),
                                )
                              : const SizedBox();
                        }),
                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          (controller.product.images ?? []).length + 1,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: controller.currentIndex.value == index
                                ? 14
                                : 9,
                            width: controller.currentIndex.value == index
                                ? 14
                                : 9,
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == index
                                  ? MyColors.primary
                                  : MyColors.primary.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller
                                  .product
                                  .categoryProductName
                                  ?.capitalizeFirst ??
                              '-',
                          style: MyTexts.medium18.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        Obx(() {
                          return (controller.isFromAdd.value == false &&
                                  controller.isFromConnector.value == false)
                              ? TextButton.icon(
                                  onPressed: controller.onEditProduct,
                                  icon: SvgPicture.asset(
                                    Asset.edit,
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      MyColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  label: Text(
                                    "Edit",
                                    style: MyTexts.regular16.copyWith(
                                      color: MyColors.primary,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        if ((controller.product.merchantLogo ?? "")
                            .isNotEmpty) ...[
                          GestureDetector(
                            onTap: () {
                              Get.to(() => BusinessDetailView());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: getImageView(
                                finalUrl:
                                    APIConstants.bucketUrl +
                                    (controller.product.merchantLogo ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ] else ...[
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Image.asset(
                              Asset.appLogo,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.product.brand?.capitalizeFirst ?? '',
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.black,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "GSTIN - ${controller.product.merchantGstNumber ?? ''}",
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if ((controller.isFromConnector.value == true &&
                                controller.isFromAdd.value == false) ||
                            (controller.isFromConnector.value == false &&
                                controller.isFromAdd.value == false))
                          Container(
                            decoration: BoxDecoration(
                              color: controller.product.totalRatings == 0
                                  ? MyColors.grayD4
                                  : MyColors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: MyColors.white,
                                  size: 16,
                                ),
                                const Gap(4),
                                Text(
                                  controller.product.totalRatings == 0
                                      ? "(No ratings yet)"
                                      : double.parse(
                                          controller.product.averageRating
                                              .toString(),
                                        ).toStringAsFixed(1),
                                  style: MyTexts.bold14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Obx(() {
                      return Gap(
                        (controller.isFromAdd.value == false &&
                                controller.isFromConnector.value == false)
                            ? 20
                            : 20,
                      );
                    }),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFF9BD),
                            const Color(0xFFFFF9BD).withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          rowText(
                            '₹ ${controller.product.price ?? 0}',

                            'Ex factory rate',
                          ),
                          const Gap(4),
                          rowText(
                            '₹ ${controller.product.gstPercentage?.split(".").first ?? 0}% - (₹${controller.product.gstAmount ?? 0})',
                            'Gst',
                          ),
                          Divider(color: MyColors.white),
                          rowText(
                            "₹ ${controller.product.totalAmount ?? "0"}",
                            'Ex Factory Amount',
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    if (myPref.role.val == "connector")
                      Obx(() {
                        if (controller.isFromAdd.value == false &&
                            controller.isFromConnector.value == false) {
                          return const SizedBox();
                        } else {
                          return !(controller.isFromAdd.value == true &&
                                  controller.isFromConnector.value == false)
                              ? Container(
                                  margin: EdgeInsets.only(top: 2.h),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: MyColors.brightGray,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery address",
                                        style: MyTexts.medium16.copyWith(
                                          color: MyColors.gray54,
                                        ),
                                      ),
                                      const Gap(12),
                                      Text(
                                        "Deliver to",
                                        style: MyTexts.medium14.copyWith(
                                          color: MyColors.grayA5,
                                        ),
                                      ),
                                      const Gap(8),

                                      Text(
                                        "Location : ${homeController.getCurrentAddress().value}",
                                        style: MyTexts.medium16.copyWith(
                                          color: MyColors.gray54,
                                        ),
                                      ),
                                      const Gap(12),
                                      Text(
                                        "Manufacturing Unit",
                                        style: MyTexts.medium14.copyWith(
                                          color: MyColors.grayA5,
                                        ),
                                      ),
                                      const Gap(8),
                                      if ((controller.product.distanceKm ??
                                              "") !=
                                          "")
                                        Text(
                                          "Near by : ${_formatDistance(controller.productDetailsModel.value.data?.product?.distanceKm)} km",
                                          style: MyTexts.medium16.copyWith(
                                            color: MyColors.gray54,
                                          ),
                                        ),
                                      const Gap(8),
                                      if (controller.product.status == "" ||
                                          controller.product.status == null)
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.DELIVERY_LOCATION,
                                            )?.then((val) {
                                              controller.productDetails(
                                                controller.product.id ?? 0,
                                              );
                                              controller.onApiCall?.call();
                                            });
                                          },
                                          child: SvgPicture.asset(Asset.edit),
                                        ),
                                    ],
                                  ),
                                )
                              : const SizedBox();
                        }
                      }),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        HearderText(
                          text: "Product Specifications",
                          textStyle: MyTexts.bold18.copyWith(
                            color: MyColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildSpecificationsTable(),
                        SizedBox(height: 2.h),
                        _buildFilterSpecificationsTable(),
                        SizedBox(height: 2.h),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF7E8),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFFDEBC8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes",
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.grayA5,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                controller.product.productNote ?? "-",
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.gray54,
                                ),
                              ),
                              const Gap(12),
                              Text(
                                "Terms and condition",
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.grayA5,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                controller.product.termsAndConditions ?? "-",
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.gray54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Obx(() {
                          return controller.reviewList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HearderText(
                                      text: "Ratings and reviews",
                                      textStyle: MyTexts.bold16.copyWith(
                                        color: MyColors.black,
                                        fontFamily: MyTexts.SpaceGrotesk,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Obx(() {
                                      return controller.reviewList.isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  controller.reviewList.length,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                              itemBuilder: (context, index) {
                                                final review = controller
                                                    .reviewList[index];
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 12,
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                    14,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    border: Border.all(
                                                      color: MyColors.greyE5,
                                                    ),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withValues(
                                                              alpha: 0.08,
                                                            ),
                                                        blurRadius: 6,
                                                        offset: const Offset(
                                                          0,
                                                          3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: MyColors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        4,
                                                                      ),
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: MyColors
                                                                      .green,
                                                                  size: 20,
                                                                ),
                                                                const Gap(4),
                                                                Text(
                                                                  controller.product.totalRatings ==
                                                                          0
                                                                      ? "(No ratings yet)"
                                                                      : double.parse(
                                                                          controller
                                                                              .product
                                                                              .averageRating
                                                                              .toString(),
                                                                        ).toStringAsFixed(
                                                                          1,
                                                                        ),
                                                                  style: MyTexts
                                                                      .bold16
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            DateFormat(
                                                              'dd MMM yyyy',
                                                            ).format(
                                                              DateTime.parse(
                                                                review.createdAt ??
                                                                    "",
                                                              ),
                                                            ),
                                                            style: MyTexts
                                                                .regular14
                                                                .copyWith(
                                                                  color: MyColors
                                                                      .black,
                                                                  fontFamily:
                                                                      MyTexts
                                                                          .SpaceGrotesk,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),

                                                      /// 💬 Review Text
                                                      Text(
                                                        review.reviewText ?? '',
                                                        style: MyTexts.medium16
                                                            .copyWith(
                                                              color: MyColors
                                                                  .black,
                                                              fontFamily: MyTexts
                                                                  .SpaceGrotesk,
                                                            ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 16,
                                                            backgroundColor:
                                                                MyColors.primary
                                                                    .withValues(
                                                                      alpha:
                                                                          0.1,
                                                                    ),
                                                            child: Text(
                                                              review.isAnonymous ??
                                                                      false
                                                                  ? "A"
                                                                  : (review.userName
                                                                            ?.substring(
                                                                              0,
                                                                              1,
                                                                            )
                                                                            .toUpperCase() ??
                                                                        "?"),
                                                              style: MyTexts
                                                                  .medium16
                                                                  .copyWith(
                                                                    color: MyColors
                                                                        .primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        MyTexts
                                                                            .SpaceGrotesk,
                                                                  ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              review.isAnonymous ??
                                                                      false
                                                                  ? "Anonymous User"
                                                                  : (review.userName ??
                                                                        ""),
                                                              style: MyTexts
                                                                  .regular14
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: MyColors
                                                                        .dustyGray,
                                                                    fontFamily:
                                                                        MyTexts
                                                                            .SpaceGrotesk,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16.0,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "No review given yet",
                                                  style: MyTexts.regular14
                                                      .copyWith(
                                                        color:
                                                            MyColors.dustyGray,
                                                        fontFamily: MyTexts
                                                            .SpaceGrotesk,
                                                      ),
                                                ),
                                              ),
                                            );
                                    }),
                                  ],
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              Obx(
                () =>
                    (controller.isFromAdd.value == false &&
                        controller.isFromConnector.value == false)
                    ? const SizedBox()
                    : (controller
                              .productDetailsModel
                              .value
                              .data
                              ?.similarProducts
                              ?.isEmpty ??
                          true)
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Explore our other product',
                                style: MyTexts.bold18,
                              ),
                              // const Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
                          const Gap(12),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  (controller
                                              .productDetailsModel
                                              .value
                                              .data
                                              ?.similarProducts
                                              ?.length ??
                                          0)
                                      .clamp(0, 5),
                              itemBuilder: (context, index) {
                                final Product data =
                                    controller
                                        .productDetailsModel
                                        .value
                                        .data
                                        ?.similarProducts?[index] ??
                                    Product();
                                return GestureDetector(
                                  onTap: () {
                                    final finalData = {
                                      "product": data,
                                      "isFromAdd": controller.isFromAdd.value,
                                      "isFromConnector":
                                          controller.isFromConnector.value,
                                      "onApiCall": controller.onApiCall,
                                    };
                                    Get.offNamed(
                                      Routes.PRODUCT_DETAILS,
                                      arguments: finalData,
                                      preventDuplicates: false,
                                    );
                                  },
                                  child: Container(
                                    width: 112,
                                    margin: EdgeInsets.only(
                                      right: index < 4 ? 12 : 0,
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: CachedNetworkImage(
                                            height: 90,
                                            width: 112,
                                            imageUrl:
                                                APIConstants.bucketUrl +
                                                (data.images?.first.s3Key ??
                                                    ''),
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.category,
                                                      color: MyColors.primary,
                                                      size: 24,
                                                    ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Text(
                                          data.brand ?? '',
                                          style: MyTexts.medium14,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx buildBottom(BuildContext context) {
    return Obx(() {
      return (controller.isFromAdd.value == false &&
              controller.isFromConnector.value == false)
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (myPref.role.val == "connector")
                  if (!(controller.isFromAdd.value == true &&
                      controller.isFromConnector.value == false))
                    const Gap(16),
                if (myPref.role.val == "connector")
                  if (!(controller.isFromAdd.value == true &&
                      controller.isFromConnector.value == false))
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.MAIN);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Explore More!",
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.grayA5,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "View Categories >",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.gray54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                Obx(() {
                  final product = controller.product;
                  if (controller.isFromAdd.value == true &&
                      controller.isFromConnector.value == false) {
                    if (myPref.role.val == "partner") {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          width: MediaQuery.of(context).size.width / 1.15,
                          horizontalPadding: 20,
                          buttonName: 'Submit',
                          onTap:
                              Get.find<AddProductController>().isLoading.value
                              ? null
                              : Get.find<AddProductController>().createProduct,
                        ),
                      );
                    }
                  }
                  if (myPref.role.val == "connector") {
                    if (product.outOfStock == true ||
                        (product.stockQty ?? 0) <= 0) {
                      if (product.isNotify == true) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: RoundedButton(
                            horizontalPadding: 20,
                            buttonName: 'Notified',
                            color: Colors.grey[400],
                            fontColor: Colors.white,
                            borderRadius: 8,
                            fontSize: 16.sp,
                            style: MyTexts.medium16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: RoundedButton(
                            horizontalPadding: 20,
                            buttonName: 'Notify Me',
                            color: MyColors.primary,
                            fontColor: Colors.white,
                            borderRadius: 8,
                            style: MyTexts.medium16.copyWith(
                              color: Colors.white,
                            ),
                            onTap: () async {
                              await Get.find<HomeController>().notifyMeApi(
                                mID: product.id ?? 0,
                                onSuccess: () {
                                  controller.onApiCall?.call();
                                },
                              );
                              Get.back();
                            },
                          ),
                        );
                      }
                    }

                    final String? connectionStatus = product.status;

                    if ((connectionStatus ?? "").isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          horizontalPadding: 20,
                          buttonName: 'Connect',
                          color: MyColors.primary,
                          style: MyTexts.medium16.copyWith(color: Colors.white),
                          onTap: () {
                            ConnectionDialogs.showSendConnectionDialog(
                              context,
                              controller.product,
                              isFromIn: true,
                              onTap: () async {
                                Get.back();
                                await Get.find<HomeController>()
                                    .addToConnectApi(
                                      mID:
                                          controller
                                              .product
                                              .merchantProfileId ??
                                          0,
                                      message: '',
                                      pID: controller.product.id ?? 0,
                                      onSuccess: () {
                                        controller.onApiCall?.call();
                                        Get.back();
                                        // Get.back();
                                      },
                                    );
                              },
                            );
                          },
                        ),
                      );
                    } else if (connectionStatus == 'pending') {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          color: MyColors.pendingBtn,
                          horizontalPadding: 20,
                          buttonName: 'Pending',
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.gray54,
                          ),
                        ),
                      );
                    } else if (connectionStatus == 'accepted') {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          horizontalPadding: 20,
                          color: MyColors.grayEA,
                          buttonName: 'Connected',
                          borderRadius: 8,
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.gray54,
                          ),
                        ),
                      );
                    } else if (connectionStatus == 'rejected') {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          horizontalPadding: 20,
                          color: MyColors.rejectBtn,
                          buttonName: 'Rejected',
                          borderRadius: 8,
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.gray54,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: RoundedButton(
                          horizontalPadding: 20,
                          color: MyColors.grey,
                          buttonName: connectionStatus ?? '',
                          fontColor: Colors.white,
                        ),
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            );
    });
  }

  Widget buildRatingRow(Product product) {
    final double averageRating =
        double.tryParse(product.averageRating ?? '0') ?? 0.0;
    final int totalRatings = product.totalRatings ?? 0;

    final int fullStars = averageRating.floor();
    final bool hasHalfStar = (averageRating - fullStars) >= 0.5;

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star, color: Colors.orangeAccent, size: 18),

        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.orangeAccent, size: 18),
        for (int i = 0; i < (5 - fullStars - (hasHalfStar ? 1 : 0)); i++)
          const Icon(Icons.star, color: Colors.grey, size: 18),

        const SizedBox(width: 4),

        Text(
          totalRatings == 0
              ? "(No ratings yet)"
              : "(${averageRating.toStringAsFixed(1)}/5)",
          style: MyTexts.regular14.copyWith(
            color: Colors.black,
            fontFamily: MyTexts.SpaceGrotesk,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecificationsTable() {
    final product = controller.product;
    final specifications = [
      {'label': 'Brand Name', 'value': product.brand.toString()},
      {'label': 'Category', 'value': product.categoryProductName.toString()},
      {'label': 'Sub category', 'value': product.subCategoryName.toString()},
      {'label': 'Warehouse type', 'value': product.warehouseType ?? "-"},
      if ((product.stockYardAddress ?? "").isNotEmpty)
        {
          'label': 'Stock yard address',
          'value': product.stockYardAddress.toString(),
        },
      if ((product.productSubCategoryName ?? "").isNotEmpty)
        {
          'label': 'Product type',
          'value': product.productSubCategoryName.toString(),
        },
      {'label': 'Stock Quantity', 'value': product.stockQty.toString()},
    ];

    return _buildSpecificationTable(specifications);
  }

  Widget _buildFilterSpecificationsTable() {
    final filterValues = controller.product.filterValues;

    if (filterValues == null || filterValues.isEmpty) {
      return const SizedBox.shrink();
    }

    final specifications = filterValues.entries.map((e) {
      final value = e.value;
      Map<String, dynamic> valueMap = {};

      if (value is Map<String, dynamic>) {
        valueMap = value;
      }

      var displayValue =
          valueMap['display_value'] ?? valueMap['value'] ?? value;

      if (displayValue is String &&
          displayValue.trim().startsWith('[') &&
          displayValue.trim().endsWith(']')) {
        try {
          final decoded = jsonDecode(displayValue);
          if (decoded is List) {
            displayValue = decoded.join(', ');
          }
        } catch (_) {}
      }

      if (displayValue is List) {
        displayValue = displayValue.join(', ');
      }

      return {
        'label': (valueMap['label'] ?? e.key).toString(),
        'value': displayValue.toString(),
      };
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HearderText(
              text: "Technical Specifications:",
              textStyle: MyTexts.bold18.copyWith(color: MyColors.black),
            ),
            const Spacer(),
            if (myPref.role.val == "partner")
              if (controller.isFromAdd.value == true &&
                  controller.isFromConnector.value == false)
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(Asset.edit),
                ),
          ],
        ),
        const SizedBox(height: 10),
        _buildSpecificationTable(specifications),
      ],
    );
  }

  Widget _buildSpecificationTable(List<Map<String, String>> specifications) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.grayE6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          children: [
            TableRow(
              decoration: const BoxDecoration(color: MyColors.grayE6),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Specification',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            ...specifications.map(
              (spec) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      (spec['label'] ?? "").capitalize ?? "",
                      style: MyTexts.medium15.copyWith(color: MyColors.gray54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Text(
                        spec['value']?.toUpperCase() ?? '',
                        style: MyTexts.medium15.copyWith(color: MyColors.black),
                        textAlign: TextAlign.end,
                      ),
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

  Widget rowText(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              fontSize: 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDistance(dynamic distance) {
    if (distance == null) return "0";
    try {
      final parsed = double.tryParse(distance.toString()) ?? 0;
      return parsed.toStringAsFixed(2);
    } catch (e) {
      return "0";
    }
  }
}
