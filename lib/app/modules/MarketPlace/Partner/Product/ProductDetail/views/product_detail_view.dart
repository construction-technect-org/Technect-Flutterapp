import 'dart:convert';
import 'dart:io';

import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/controller/add_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/controllers/product_detail_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isFromAdd.value == true
          ? Get.find<AddProductController>().isLoading
          : false.obs,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: const Text("Product Details"),
          isCenter: false,
          // action: [
          //   // SvgPicture.asset(Asset.link),
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.more_vert, color: Colors.black),
          //   ),
          // ],
        ),
        bottomNavigationBar: Obx(
          () => controller.isFromAdd.value == true
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RoundedButton(
                    buttonName: 'SUBMIT',
                    onTap: Get.find<AddProductController>().isLoading.value
                        ? null
                        : Get.find<AddProductController>().createProduct,
                  ),
                )
              : const SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 360.w,
                height: 35.h,
                decoration: const BoxDecoration(color: MyColors.grayF2),
                alignment: Alignment.center,
                child:
                    (
                        (controller.product.images??[]).isNotEmpty)
                    ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Image list
                        Obx(() {
                          final isNetwork = controller.isFromAdd.value == false;
                          final List<String> imageUrls = [];
                          print("isNetwork==>$isNetwork");

                          if (isNetwork) {
                            // From API (network)
                            if (controller.product.images != null &&
                                controller.product.images!.isNotEmpty) {
                              imageUrls.addAll(
                                controller.product.images!
                                    .map((img) =>
                                "${APIConstants.bucketUrl}${img.s3Key ?? controller.product.productImage ?? ''}")
                                    .toList(),
                              );
                            } else if (controller.product.productImage != null) {
                              imageUrls.add(
                                  "${APIConstants.bucketUrl}${controller.product.productImage!}");
                            }
                          } else {
                            // From local files
                            if (
                                controller.product.images!.isNotEmpty) {
                              imageUrls.addAll(
                                controller.product.images!
                                    .map((img) =>
                                img.s3Url ?? controller.product.productImage ?? '')
                                    .toList(),
                              );
                            } else if (controller.product.productImage != null) {
                              imageUrls.add(
                                  "${APIConstants.bucketUrl}${controller.product.productImage!}");
                            }
                          }

                          if (imageUrls.isEmpty) {
                            return const Center(
                              child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                            );
                          }
                          return SizedBox(
                            height: 35.h,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: imageUrls.length,
                                itemBuilder: (context, index) {
                                  final imagePath = imageUrls[index];
                                  final isHttp = imagePath.startsWith('http');
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          insetPadding: const EdgeInsets.all(16),
                                          child: InteractiveViewer(
                                            child: isHttp
                                                ? Image.network(imagePath, fit: BoxFit.contain)
                                                : Image.file(File(imagePath), fit: BoxFit.contain),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: isHttp
                                            ? Image.network(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          height: 35.h,
                                          width: 35.h,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image,
                                              size: 60, color: Colors.grey),
                                        )
                                            : Image.file(
                                          File(imagePath),
                                          fit: BoxFit.cover,
                                          height: 35.h,
                                          width: 35.h,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),

                        // Bottom Info: stock + rating
                        Obx(() {
                          return controller.isFromAdd.value == false
                              ? Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.product.outOfStock == true
                                          ? "Out Of Stock"
                                          : "In Stock",
                                      style: MyTexts.bold18.copyWith(
                                        color: controller.product.outOfStock == true
                                            ? Colors.red
                                            : Colors.green,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Gap(4),
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.product.outOfStock == true
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                buildRatingRow(controller.product),
                              ],
                            ),
                          )
                              : const SizedBox();
                        }),
                      ],
                    )
                        : const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey,
                      ),
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
                          controller.product.productName?.capitalizeFirst ??
                              '-',
                          style: MyTexts.medium18.copyWith(
                            color: MyColors.fontBlack,
                          ),
                        ),

                        Obx(() {
                          return controller.isFromAdd.value == false
                              ? TextButton.icon(
                                  onPressed: controller.onEditProduct,
                                  icon: SvgPicture.asset(
                                    Asset.editIcon,
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
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                    Obx(() {
                      return Gap(controller.isFromAdd.value == false ? 0 : 20);
                    }),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          rowText(
                            'Product Rate:',
                            '${controller.product.price ?? 0}',
                          ),
                          rowText(
                            'GST(${controller.product.gstPercentage ?? 0}%):',
                            '${controller.product.gstAmount ?? 0}',
                          ),
                          const Divider(),
                          rowText(
                            'Total Price:',
                            controller.product.totalAmount ?? "0",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "${controller.product.price ?? 0}/Unit",
                    //       style: MyTexts.medium24.copyWith(
                    //         color: MyColors.primary,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     if (controller.product.ratingCount != 0)
                    //       const Icon(Icons.star, color: Colors.amber, size: 20),
                    //     if (controller.product.ratingCount != 0)
                    //       Text(
                    //         '(${controller.product.ratingCount}/${controller.product.totalRatings})',
                    //         style: MyTexts.extraBold20.copyWith(
                    //           color: MyColors.darkCharcoal,
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    SizedBox(height: 1.h),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.brightGray),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Category: ",
                                style: MyTexts.regular16.copyWith(
                                  color: MyColors.fontBlack,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text:
                                        controller.product.mainCategoryName ??
                                        '',
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.green,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.brightGray),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Sub-Category: ",
                                style: MyTexts.regular16.copyWith(
                                  color: MyColors.fontBlack,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text:
                                        controller.product.subCategoryName ??
                                        '',
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.green,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Company Details:",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.black,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Text(
                          controller.product.brand ?? '',
                          style: MyTexts.extraBold18.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Image.asset(Asset.virify, height: 4.h, width: 4.w),
                      ],
                    ),
                    Text(
                      "GSTIN: ${controller.profileData.data?.merchantProfile?.gstinNumber ?? ''}",
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    const Divider(),
                    SizedBox(height: 1.h),
                    InkWell(
                      onTap: () => controller.showProductDetails.toggle(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          border: Border.all(color: MyColors.grayD4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "View Product Details",
                                  style: MyTexts.extraBold16.copyWith(
                                    color: MyColors.primary,
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => Icon(
                                    controller.showProductDetails.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: MyColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => controller.showProductDetails.value
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        HearderText(
                                          text: "Product Specifications:",
                                          textStyle: MyTexts.bold16.copyWith(
                                            color: MyColors.black,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        _buildSpecificationsTable(),
                                        SizedBox(height: 2.h),
                                        _buildFilterSpecificationsTable(),
                                        SizedBox(height: 2.h),
                                        if ((controller
                                                    .product
                                                    .termsAndConditions ??
                                                '') !=
                                            '') ...[
                                          HearderText(
                                            text: "Terms & Condition:",
                                            textStyle: MyTexts.bold16.copyWith(
                                              color: MyColors.black,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                          Text(
                                            controller
                                                    .product
                                                    .termsAndConditions ??
                                                '',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.green,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                        ],
                                        if ((controller.product.productNote ??
                                                '') !=
                                            '') ...[
                                          SizedBox(height: 1.h),
                                          HearderText(
                                            text: "Notes:",
                                            textStyle: MyTexts.bold16.copyWith(
                                              color: MyColors.black,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                          Text(
                                            controller.product.productNote ??
                                                '',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.black,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ).paddingOnly(bottom: 1.h),
                                        ],

                                        SizedBox(height: 2.h),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
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
      ),
    );
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
            fontFamily: MyTexts.Roboto,
          ),
        ),
      ],
    );
  }

  String _formatKeyName(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word,
        )
        .join(' ');
  }

  Widget _buildSpecificationGrid(List<Map<String, String>> specifications) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColors.veryPaleBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.brightGray),
      ),
      child: Column(
        children: [
          for (int i = 0; i < specifications.length; i += 2)
            Padding(
              padding: EdgeInsets.only(
                bottom: i + 2 < specifications.length ? 12 : 0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSpecificationItem(
                      specifications[i]['label']!,
                      specifications[i]['value']!,
                    ),
                  ),
                  if (i + 1 < specifications.length) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSpecificationItem(
                        specifications[i + 1]['label']!,
                        specifications[i + 1]['value']!,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSpecificationItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.brightGray.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: MyTexts.medium14.copyWith(
              color: MyColors.fontBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: MyTexts.regular16.copyWith(
              color: MyColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationsTable() {
    final product = controller.product;
    final specifications = [
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

      // 🟩 Handle nested map type
      if (value is Map<String, dynamic>) {
        valueMap = value;
      }

      var displayValue = valueMap['display_value'] ?? valueMap['value'] ?? value;

      // 🟦 Handle if it's a JSON array in string format
      if (displayValue is String &&
          displayValue.trim().startsWith('[') &&
          displayValue.trim().endsWith(']')) {
        try {
          final decoded = jsonDecode(displayValue);
          if (decoded is List) {
            displayValue = decoded.join(', ');
          }
        } catch (_) {
          // not a valid JSON list, keep as string
        }
      }

      // 🟨 Handle if it's a Dart List directly
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
        HearderText(
          text: "Technical Specifications:",
          textStyle: MyTexts.bold16.copyWith(
            color: MyColors.black,
            fontFamily: MyTexts.Roboto,
          ),
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
        border: Border.all(color: MyColors.grayD4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          border: const TableBorder(
            horizontalInside: BorderSide(color: MyColors.grayD4),
            verticalInside: BorderSide(color: MyColors.grayD4),
          ),
          children: [
            /// ✅ Header Row
            TableRow(
              decoration: const BoxDecoration(color: MyColors.primary),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Specification",
                    style: MyTexts.medium16.copyWith(
                      color: Colors.white,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Details",
                    style: MyTexts.medium16.copyWith(
                      color: Colors.white,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
              ],
            ),
            ...specifications.map(
              (spec) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      spec['label']!,
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.primary,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      spec['value']!,
                      style: MyTexts.medium16.copyWith(
                        color: Colors.black,
                        fontFamily: MyTexts.Roboto,
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
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ],
      ),
    );
  }
}
