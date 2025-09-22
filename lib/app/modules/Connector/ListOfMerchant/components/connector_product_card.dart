import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';

class ConnectorProductCard extends StatelessWidget {
  const ConnectorProductCard({
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
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(color: MyColors.primary),
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
                              style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
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
                                  style: MyTexts.regular14.copyWith(color: statusColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Brand: ',
                              style: MyTexts.regular14.copyWith(color: MyColors.primary),
                            ),
                            TextSpan(
                              text: brandName,
                              style: MyTexts.regular14.copyWith(color: MyColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.8.h),
            Row(
              children: [
                const Icon(Icons.place_outlined, size: 16, color: Color(0xFF6B7280)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    locationText,
                    style: MyTexts.regular14.copyWith(color: MyColors.graniteg),
                  ),
                ),
              ],
            ),
            Text(
              '₹ ${pricePerUnit.toStringAsFixed(2)}/unit',
              style: MyTexts.extraBold20.copyWith(color: MyColors.primary),
            ),
            SizedBox(height: 0.9.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side - Stock and Specifications
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "In Stock: ",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.silver,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        Text(
                          "45",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.9.h),
                    Row(
                      children: [
                        Text(
                          "Specifications",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.warning,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: MyColors.warning),
                      ],
                    ),
                  ],
                ),

                // Right side - Connect button and bookmark
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 30, // smaller height
                      child: CommonButton(
                        text: 'Connect',
                        imageAsset: Asset.crmIcon,
                        imageColor: MyColors.white,
                        textStyle:  MyTexts.medium14.copyWith(
                            color: MyColors.white,
                            fontFamily: MyTexts.Roboto,
                          ),
                        onPressed: () {
                          showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // prevent dismiss on tap outside
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
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: MyColors.primary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
