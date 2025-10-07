import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final bool isActive = product.isActive ?? false;

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
                  child:
                      ((product.images??[]).isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl:
                              "${APIConstants.bucketUrl}${product.images?.first.s3Key}",
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
                            Asset.Product,
                            width: 56,
                            height: 57,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            Asset.Product,
                            width: 56,
                            height: 57,
                            fit: BoxFit.cover,
                          ),
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
                              product.productName ?? "",
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? MyColors.paleGreen
                                  : MyColors.paleRed,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              isActive ? "Active" : "Inactive",
                              style: MyTexts.regular14.copyWith(
                                fontFamily: MyTexts.Roboto,
                                color: isActive ? MyColors.green : MyColors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(2),
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
                              text: product.brand ?? "-",
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

            const Gap(12),
            Text(
              '₹ ${double.tryParse(product.price ?? "0")?.toStringAsFixed(2) ?? "0.00"}/${product.filterValues?["uom"]["value"] ?? ""}',
              style: MyTexts.bold18.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.Roboto,
              ),
            ),

            const Gap(4),
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
                    text: (product.stockQty ?? 0).toString(),
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.Roboto,
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
                  style: MyTexts.medium13.copyWith(
                    fontSize: 13,
                    color: MyColors.warning,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                SizedBox(width: 0.2.h),
                Icon(
                  Icons.keyboard_arrow_down,
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
