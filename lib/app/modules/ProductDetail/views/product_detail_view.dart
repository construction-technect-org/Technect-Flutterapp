import 'dart:convert';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductDetail/controllers/product_detail_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final List<String> specifications = [
    "Particle size ranging from 0 to 4.75mm.",
    "High compressive strength.",
    "Free from impurities.",
    "Durable and long-lasting.",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColors.veryPaleBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.veryPaleBlue,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        ),
        title: Text(
          "Product Details",
          style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
        ),
      ),

      body: SingleChildScrollView(
        child: Obx(() {
          final Map<String, dynamic> filterValues = jsonDecode(
            controller.product.value.filterValues ?? '',
          );

          final keys = filterValues.keys.toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product Image Section
              Center(
                child: Container(
                  width: 360.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                    color: MyColors.veryPaleBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(37),
                      bottomRight: Radius.circular(37),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 2.h),
                  alignment: Alignment.center,
                  child:
                      (controller.product.value.productImage != null &&
                          controller.product.value.productImage!.isNotEmpty)
                      ? Image.network(
                          "${APIConstants.bucketUrl}${controller.product.value.productImage!}",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image, // "no image" icon
                              size: 60,
                              color: Colors.grey,
                            );
                          },
                        )
                      : const Icon(
                          Icons.image_not_supported, // shown if null/empty
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),

              /// Details Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Edit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${controller.product.value.brand}',
                          style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                        ),
                        TextButton.icon(
                          onPressed: controller.onEditProduct,
                          icon: SvgPicture.asset(
                            Asset.editIcon,
                            width: 12,
                            height: 12,
                            // ignore: deprecated_member_use
                            color: MyColors.primary,
                          ),
                          label: Text(
                            "Edit",
                            style: MyTexts.regular14.copyWith(
                              color: MyColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Price & Rating
                    Row(
                      children: [
                        Text(
                          "${controller.product.value.price ?? 0}/Unit",
                          style: MyTexts.medium24.copyWith(color: MyColors.primary),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          '(${controller.product.value.ratingCount}/${controller.product.value.totalRatings})',
                          style: MyTexts.extraBold20.copyWith(
                            color: MyColors.darkCharcoal,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),

                    /// Category + Sub Category
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.brightGray),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Category: ",
                                  style: MyTexts.extraBold14.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                          controller.product.value.mainCategoryName ?? '',
                                      style: MyTexts.extraBold14.copyWith(
                                        color: MyColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.brightGray),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Sub-Category: ",
                                  style: MyTexts.extraBold14.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                          controller.product.value.subCategoryName ?? '',
                                      style: MyTexts.extraBold14.copyWith(
                                        color: MyColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    /// Company Details
                    Text(
                      "Company Details:",
                      style: MyTexts.light14.copyWith(color: MyColors.fontBlack),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Text(
                          'M N Manufacturers',
                          style: MyTexts.extraBold20.copyWith(color: MyColors.primary),
                        ),
                        SizedBox(width: 0.5.w),
                        Image.asset(Asset.virify, height: 4.h, width: 4.w),
                      ],
                    ),
                    Text(
                      "GSTIN: 12097310983",
                      style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                    ),

                    SizedBox(height: 2.h),

                    /// Specifications
                    Text(
                      "Specifications:",
                      style: MyTexts.extraBold16.copyWith(color: MyColors.fontBlack),
                    ),
                    SizedBox(height: 1.h),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: keys.length ~/ 2, // 2-2 करके दिखाना है
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final leftKey = keys[index * 2];
                        final rightKey = (index * 2 + 1 < keys.length)
                            ? keys[index * 2 + 1]
                            : null;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              // Left column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leftKey.replaceAll("_", " "),
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      filterValues[leftKey].toString(),
                                      style: MyTexts.regular12.copyWith(
                                        color: MyColors.oldSilver,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Right column (if exists)
                              if (rightKey != null)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rightKey.replaceAll("_", " "),
                                        style: MyTexts.regular14.copyWith(
                                          color: MyColors.fontBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        filterValues[rightKey].toString(),
                                        style: MyTexts.regular12.copyWith(
                                          color: MyColors.oldSilver,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    Text(
                      controller.product.value.termsAndConditions ?? '',
                      style: MyTexts.extraBold14.copyWith(color: MyColors.green),
                    ),
                    SizedBox(height: 1.h),

                    /// Price Summary
                    Text(
                      "Amount & Tax Summary",
                      style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                    ),
                    SizedBox(height: 0.8.h),

                    Container(
                      width: 100.w,
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        color: MyColors.veryPaleOrange,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPriceRow(
                            "Product Rate:",
                            '${controller.product.value.price ?? 0}',
                          ),
                          SizedBox(height: 0.8.h),
                          _buildPriceRow(
                            "GST (${controller.product.value.gstPercentage ?? 0}%):",
                            '${controller.product.value.gstAmount}',
                          ),
                          const Divider(color: Colors.black38),
                          _buildPriceRow(
                            "Total Price:",
                            '${double.parse(controller.product.value.price ?? '0') + double.parse(controller.product.value.gstAmount ?? '0')}',
                            valueStyle: MyTexts.extraBold20.copyWith(
                              color: MyColors.fontBlack,
                            ),
                            labelStyle: MyTexts.medium20.copyWith(
                              color: MyColors.fontBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  /// ✅ Helper for price rows
  Widget _buildPriceRow(
    String label,
    String value, {
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ?? MyTexts.light14.copyWith(color: MyColors.fontBlack),
        ),
        Text(
          value,
          style: valueStyle ?? MyTexts.light14.copyWith(color: MyColors.fontBlack),
        ),
      ],
    );
  }
}
