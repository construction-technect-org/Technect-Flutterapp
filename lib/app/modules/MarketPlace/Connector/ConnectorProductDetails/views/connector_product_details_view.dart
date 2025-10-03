import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProductDetails/controller/connector_product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class ConnectorProductDetailsView extends GetView<ConnectorProductDetailsController> {
  const ConnectorProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color(0x33D4D4D4),
        elevation: 0,
        leading: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
        actions: [
          const Icon(Icons.search, color: Colors.black),
          SizedBox(width: 3.w),
          SvgPicture.asset(Asset.userx, width: 24, height: 24),
          SizedBox(width: 3.w),
          SvgPicture.asset(Asset.externallink, width: 24, height: 24),
          SizedBox(width: 3.w),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.CONNECTOR_FILTER);
            },

            child: SvgPicture.asset(
              Asset.morevertical, // आपका svg path
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 370.w,
                height: 30.h,
                child: Stack(
                  children: [
                    // Background + Image
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color(0x33D4D4D4),
                      child: Center(
                        child: Image.asset(Asset.productDetails, fit: BoxFit.contain),
                      ),
                    ),

                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 0,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // In Stock + Green Dot
                              Row(
                                children: [
                                  Text(
                                    "In Stock",
                                    style: MyTexts.extraBold14.copyWith(
                                      color: MyColors.green,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                  SizedBox(width: 0.4.w),
                                  const Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: MyColors.green,
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.4.h),
                              // Rating stars
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 0.6.w),
                                  Text(
                                    "(4.9/5)",
                                    style: MyTexts.extraBold14.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Right Section: Page Dots
                          Row(
                            children: [
                              _buildDot(isActive: true),
                              _buildDot(isActive: false),
                              _buildDot(isActive: false),
                              _buildDot(isActive: false),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),

                  /// Title and Description
                  Text(
                    'Premium Manufacturing Sand',
                    style: MyTexts.medium18.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  Text(
                    'Premium Manufacturing Sand isd lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum',
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.darkCharcoal,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),

                  SizedBox(height: 0.8.h),

                  /// Company Details
                  Text(
                    'Company Details:',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.darkCharcoal,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  SizedBox(height: 0.6.h),
                  Row(
                    children: [
                      const Icon(Icons.verified, color: MyColors.green),
                      const SizedBox(width: 4),
                      Text(
                        'M N Manufacturers',
                        style: MyTexts.extraBold16.copyWith(
                          color: MyColors.darkCharcoal,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('GSTIN: 12097310983'),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Text('Category: ', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('Construction'),
                      SizedBox(width: 20),
                      Text(
                        'Sub-Category: ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text('Fine Aggregate', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'View Product details',
                    style: TextStyle(color: Colors.blue),
                  ),

                  const Divider(height: 30),

                  /// Price Summary
                  const Text(
                    'Amount & Tax Summary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        rowText('Product Rate:', '123.00'),
                        rowText('GST(5%):', '13.00'),
                        const Divider(),
                        rowText('Ex Factory Price:', '136.00', isBold: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Add to connect logic
                },
                child: const Text(
                  'ADD TO CONNECT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                // Bookmark logic
              },
              icon: const Icon(Icons.bookmark_border),
              color: Colors.indigo[800],
              iconSize: 28,
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
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

Widget _buildDot({required bool isActive}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    width: 8,
    height: 8,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isActive ? Colors.blue.shade900 : Colors.grey.shade400,
    ),
  );
}
