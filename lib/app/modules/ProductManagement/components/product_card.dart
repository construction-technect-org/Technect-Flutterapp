import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.statusText,
    required this.statusColor,
    required this.productName,
    this.companyName,
    required this.brandName,
    required this.locationText,
    required this.pricePerUnit,
    required this.stockCount,
    this.imageAsset,
    this.imageUrl,
  });

  final String statusText;
  final Color statusColor;
  final String productName;
  final String? companyName;
  final String brandName;
  final String locationText;
  final double pricePerUnit;
  final int stockCount;
  final String? imageAsset;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.americanSilver),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: "${APIConstants.bucketUrl}$imageUrl",
                          width: 56,
                          height: 57,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 56,
                            height: 57,
                            decoration: const BoxDecoration(
                              color: MyColors.grey1,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(
                                color: MyColors.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            imageAsset ?? Asset.Product,
                            width: 56,
                            height: 57,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          imageAsset ?? Asset.Product,
                          width: 56,
                          height: 57,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: 1.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: MyTexts.bold18.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor == MyColors.green
                                  ? MyColors.paleGreen
                                  : MyColors.paleRed,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  statusText,
                                  style: MyTexts.regular14.copyWith(
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.2.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Brand: ',
                              style: MyTexts.regular16.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: brandName,
                              style: MyTexts.regular16.copyWith(
                                color: MyColors.primary,
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
            SizedBox(height: 1.h),
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    locationText,
                    style: MyTexts.regular14.copyWith(color: MyColors.graniteg),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.7.h),
            Text(
              '₹ ${pricePerUnit.toStringAsFixed(2)}/unit',
              style: MyTexts.extraBold20.copyWith(color: MyColors.primary),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'In Stock: ',
                    style: MyTexts.regular14.copyWith(color: MyColors.silver),
                  ),
                  TextSpan(
                    text: '45',
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.fontBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.8.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Specifications',
                  style: MyTexts.regular14.copyWith(color: MyColors.warning),
                ),
                SizedBox(width: 0.2.h),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 16.sp,
                  color: MyColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
