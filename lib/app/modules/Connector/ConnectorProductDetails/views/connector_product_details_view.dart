import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_button.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProductDetails/controllers/connector_product_details_controller.dart';

class ConnectorProductDetailsView extends GetView<ConnectorProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColors.veryPaleBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
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
                child: Image.asset(Asset.productDetails, fit: BoxFit.contain),
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
                        'hello',
                        style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Get.toNamed(
                          //   //Routes.EDIT_PRODUCT,

                          // );
                        },

                        label: Text(
                          "Review",
                          style: MyTexts.regular16.copyWith(
                            color: MyColors.primary,
                            decoration: TextDecoration.underline, // 👈 underline added
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "100.00/Unit",
                        style: MyTexts.medium24.copyWith(color: MyColors.primary),
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
                                  text: 'Construcation Material',
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
                                  text: 'Blocks',
                                  style: MyTexts.extraBold14.copyWith(
                                    color: MyColors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

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
                                  text: 'dads',
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
                        'Primary',
                        style: MyTexts.extraBold18.copyWith(color: MyColors.primary),
                      ),
                      SizedBox(width: 1.w),
                      Image.asset(Asset.virify, height: 4.h, width: 4.w),
                    ],
                  ),
                  Text(
                    "GSTIN: 12345678909876",
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
                  ConnectorProductDetailsView._buildFilterSpecificationsSection(
                    controller.filterValues,
                    _formatKeyName,
                    _buildSpecificationGrid,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'qsklnqm',
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
                        _buildPriceRow("Product Rate:", '2000.00'),
                        SizedBox(height: 0.8.h),
                        _buildPriceRow("GST(18%)", '360.00'),
                        const Divider(color: Colors.black38),
                        _buildPriceRow(
                          "Total Price:",
                          '2360.00',
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
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0), // add some margin from edges
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 247,
              height: 57,
              child: CommonButton(
                text: 'Connect',
                imageAsset: Asset.crmIcon,
                iconSize: 30,
                imageColor: MyColors.white,
                textStyle: MyTexts.extraBold22.copyWith(
                  color: MyColors.white,
                  fontFamily: MyTexts.Roboto,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // prevent dismiss on tap outside
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 120,
                                child: Image.asset(
                                  Asset.connectToCrm,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 2.h),

                              Text(
                                "Connect to CRM!",
                                style: MyTexts.extraBold20.copyWith(
                                  color: MyColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "To Proceed with your request, please connect to CRM.",
                                style: MyTexts.regular16.copyWith(
                                  color: MyColors.dopelyColors,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: RoundedButton(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  buttonName: '',
                                  borderRadius: 12,
                                  width: 40.w,
                                  height: 45,
                                  verticalPadding: 0,
                                  horizontalPadding: 0,
                                  color: MyColors.lightBlue,
                                  child: Center(
                                    child: Text(
                                      'Proceed',
                                      style: MyTexts.medium16.copyWith(
                                        color: MyColors.white,
                                        fontFamily: MyTexts.Roboto,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border, color: MyColors.primary, size: 31),
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
    final specifications = [
      {'label': 'Package Type', 'value': 'Small' ?? 'N/A'},
      {'label': 'Package Size', 'value': "big" ?? 'N/A'},
      {'label': 'Shape', 'value': "round " ?? 'N/A'},
      {'label': 'Texture', 'value': "productjh " ?? 'N/A'},
      {'label': 'Colour', 'value': "Black " ?? 'N/A'},
      {'label': 'Size', 'value': "20kg " ?? 'N/A'},
      {'label': 'Weight', 'value': "50kg" ?? 'N/A'},
      {'label': 'Stock Quantity', 'value': " 90" ?? 'N/A'},
    ];

    return _buildSpecificationGrid(specifications);
  }

  static Widget _buildFilterSpecificationsSection(
    Map<String, String> filterValues,
    String Function(String) formatKeyName,
    Widget Function(List<Map<String, String>>) buildSpecificationGrid,
  ) {
    if (filterValues.isEmpty) return const SizedBox.shrink();

    final specifications = filterValues.entries
        .map(
          (e) => {
            'label': formatKeyName(e.key),
            'value': e.value.isNotEmpty ? e.value : 'N/A',
          },
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
        buildSpecificationGrid(specifications),
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
}
