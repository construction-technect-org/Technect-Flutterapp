import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductDetail/controllers/product_detail_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  List<String> specifications = [
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
        child: Column(
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
                child: Image.asset(Asset.productDetails, fit: BoxFit.contain),
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
                        'Premium Manufacturing Sand',
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
                        "125.00/Unit",
                        style: MyTexts.medium24.copyWith(color: MyColors.primary),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        '(4.9/5)',
                        style: MyTexts.extraBold20.copyWith(color: MyColors.darkCharcoal),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  /// Category + Sub Category
                  Row(
                    children: [
                      Text(
                        "Category: ",
                        style: MyTexts.extraBold14.copyWith(color: MyColors.fontBlack),
                      ),
                      Text(
                        'Construction',
                        style: MyTexts.extraBold14.copyWith(color: MyColors.green),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Sub-Category: ",
                        style: MyTexts.extraBold14.copyWith(color: MyColors.fontBlack),
                      ),
                      Text(
                        'Sand',
                        style: MyTexts.extraBold14.copyWith(color: MyColors.green),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: specifications
                        .map(
                          (spec) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: MyColors.philippineGray,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    spec,
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
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
                        _buildPriceRow("Product Rate:", '123.00'),
                        SizedBox(height: 0.8.h),
                        _buildPriceRow("GST (5%):", '13.00'),
                        const Divider(color: Colors.black38),
                        _buildPriceRow(
                          "Total Price:",
                          '136.00',
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
}
