import 'dart:convert';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductDetail/controllers/product_detail_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    (controller.product.productImage != null &&
                        controller.product.productImage!.isNotEmpty)
                    ? Image.network(
                        "${APIConstants.bucketUrl}${controller.product.productImage!}",
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
                        controller.product.productName ?? '',
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
                  Row(
                    children: [
                      Text(
                        "${controller.product.price ?? 0}/Unit",
                        style: MyTexts.medium24.copyWith(color: MyColors.primary),
                      ),
                      const Spacer(),
                      if (controller.product.ratingCount != 0)
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                      if (controller.product.ratingCount != 0)
                        Text(
                          '(${controller.product.ratingCount}/${controller.product.totalRatings})',
                          style: MyTexts.extraBold20.copyWith(
                            color: MyColors.darkCharcoal,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Column(
                    children: [
                      Container(
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
                                  text: controller.product.mainCategoryName ?? '',
                                  style: MyTexts.extraBold14.copyWith(
                                    color: MyColors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Container(
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
                                  text: controller.product.subCategoryName ?? '',
                                  style: MyTexts.extraBold14.copyWith(
                                    color: MyColors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ((controller.product.productName ?? '') != '')
                        SizedBox(height: 2.w),
                      if ((controller.product.productName ?? '') != '')
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.brightGray),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Product Name: ",
                                style: MyTexts.extraBold14.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: controller.product.productName ?? '',
                                    style: MyTexts.extraBold14.copyWith(
                                      color: MyColors.green,
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
                    style: MyTexts.light16.copyWith(color: MyColors.fontBlack),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Text(
                        controller.product.brand ?? '',
                        style: MyTexts.extraBold18.copyWith(color: MyColors.primary),
                      ),
                      SizedBox(width: 1.w),
                      Image.asset(Asset.virify, height: 4.h, width: 4.w),
                    ],
                  ),
                  Text(
                    "GSTIN: ${controller.profileData.data?.merchantProfile?.gstinNumber ?? ''}",
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Product Specifications:",
                    style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                  ),
                  const SizedBox(height: 10),
                  _buildSpecificationsSection(),
                  SizedBox(height: 2.h),
                  _buildFilterSpecificationsSection(),
                  SizedBox(height: 2.h),
                  if ((controller.product.termsAndConditions ?? '') != '')
                    Text(
                      controller.product.termsAndConditions ?? '',
                      style: MyTexts.extraBold16.copyWith(color: MyColors.green),
                    ).paddingOnly(bottom: 1.h),
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
                          '${controller.product.price ?? 0}',
                        ),
                        SizedBox(height: 0.8.h),
                        _buildPriceRow(
                          "GST (${controller.product.gstPercentage ?? 0}%):",
                          '${controller.product.gstAmount}',
                        ),
                        const Divider(color: Colors.black38),
                        _buildPriceRow(
                          "Total Price:",
                          '${double.parse(controller.product.price ?? '0') + double.parse(controller.product.gstAmount ?? '0')}',
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
        ),
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

  /// ✅ Helper to format key names
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

  Widget _buildSpecificationsSection() {
    final product = controller.product;
    final specifications = [
      {'label': 'Package Type', 'value': product.packageType ?? 'N/A'},
      {'label': 'Package Size', 'value': product.packageSize ?? 'N/A'},
      {'label': 'Shape', 'value': product.shape ?? 'N/A'},
      {'label': 'Texture', 'value': product.texture ?? 'N/A'},
      {'label': 'Colour', 'value': product.colour ?? 'N/A'},
      {'label': 'Size', 'value': product.size ?? 'N/A'},
      {'label': 'Weight', 'value': product.weight ?? 'N/A'},
      {'label': 'Stock Quantity', 'value': product.stockQuantity?.toString() ?? 'N/A'},
    ];

    return _buildSpecificationGrid(specifications);
  }

  Widget _buildFilterSpecificationsSection() {
    final Map<String, dynamic> filterValues = jsonDecode(
      controller.product.filterValues ?? '{}',
    );

    if (filterValues.isEmpty) return const SizedBox.shrink();

    final keys = filterValues.keys.toList();
    final specifications = keys
        .map(
          (key) => {'label': _formatKeyName(key), 'value': filterValues[key].toString()},
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Technical Specifications:",
          style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
        ),
        const SizedBox(height: 10),
        _buildSpecificationGrid(specifications),
      ],
    );
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
              padding: EdgeInsets.only(bottom: i + 2 < specifications.length ? 12 : 0),
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
        border: Border.all(color: MyColors.brightGray.withOpacity(0.5)),
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
}
