import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

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
                            child: Text(
                              statusText,
                              style: MyTexts.regular14.copyWith(color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Company: ',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            TextSpan(
                              text: companyName ?? "-",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Brand: ',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            TextSpan(
                              text: brandName,
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                                fontFamily: MyTexts.Roboto,
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
            const Gap(11),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: MyColors.graniteg),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    locationText,
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.graniteg,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '₹ ${pricePerUnit.toStringAsFixed(2)}/unit',
              style: MyTexts.extraBold20.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            SizedBox(height: 0.9.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'In Stock: ',
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.silver,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      TextSpan(
                        text: stockCount.toString(),
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.black,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 102,
                      height: 24,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.CONNECTOR_PRODUCT_DETAILS);
                        },
                        child: Text(
                          "Add to Connect",
                          style: MyTexts.medium12.copyWith(
                            color: MyColors.white,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    WishlistToggleButton(
                      onWishlistChanged: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              value ? "Added to wishlist" : "Removed from wishlist",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Specifications',
                      style: MyTexts.medium13.copyWith(
                        fontSize: 13,
                        color: MyColors.warning,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    SizedBox(width: 0.2.h),
                    Icon(Icons.keyboard_arrow_down, size: 16.sp, color: MyColors.warning),
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

class WishlistToggleButton extends StatefulWidget {
  final bool initialIsInWishlist;
  final ValueChanged<bool>? onWishlistChanged;
  const WishlistToggleButton({
    super.key,
    this.initialIsInWishlist = false,
    this.onWishlistChanged,
  });

  @override
  State<WishlistToggleButton> createState() => _WishlistToggleButtonState();
}

class _WishlistToggleButtonState extends State<WishlistToggleButton> {
  late bool isInWishlist;

  @override
  void initState() {
    super.initState();
    isInWishlist = widget.initialIsInWishlist;
  }

  void _toggle() {
    setState(() => isInWishlist = !isInWishlist);
    widget.onWishlistChanged?.call(isInWishlist);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(22),
      child: Icon(
        isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: isInWishlist ? Colors.red : Colors.grey,
      ),
    );
  }
}
