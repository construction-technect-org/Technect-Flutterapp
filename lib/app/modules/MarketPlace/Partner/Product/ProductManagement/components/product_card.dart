import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.isPartner = true});

  final Product product;
  final bool? isPartner;

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
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentGeometry.topLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: ((product.images ?? []).isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl:
                              "${APIConstants.bucketUrl}${product.images?.first.s3Key}",
                          height: 176,
                          width: Get.width / 2 - 24,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 176,
                            width: Get.width / 2 - 24,
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
                            height: 176,
                            width: Get.width / 2 - 24,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          child: Image.asset(
                            Asset.Product,
                            height: 176,
                            width: Get.width / 2 - 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                if (product.outOfStock == true || product.stockQty == 0)
                  Container(
                    height: 176,
                    width: Get.width / 2 - 24,
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Out of stock",
                        style: MyTexts.medium16.copyWith(
                          color: Colors.white,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                      ),
                    ),
                  ),
                if (isPartner == false)
                  SizedBox(
                    height: 176,
                    width: Get.width / 2 - 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: AlignmentGeometry.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<ConnectorSelectedProductController>()
                                  .wishListApi(
                                    status: product.isInWishList == true
                                        ? "remove"
                                        : "add",
                                    mID: product.id ?? 0,
                                  );
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12, top: 12),
                              height: 32,
                              width: 32,
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  product.isInWishList == true
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: product.isInWishList == true
                                      ? MyColors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (DateTime.parse(
                          product.createdAt ?? DateTime.now().toString(),
                        ).isAfter(
                          DateTime.now().subtract(const Duration(days: 7)),
                        ))
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: MyColors.primary.withValues(alpha: 0.9),
                            ),
                            child: Text(
                              "New Arrival",
                              style: MyTexts.medium14.copyWith(
                                color: Colors.white,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.categoryProductName ?? "",
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                  const Gap(2),
                  Row(
                    children: [
                      SvgPicture.asset(Asset.brand),
                      const Gap(4),
                      Text(
                        product.brand ?? "",
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.fontBlack,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                      ),
                    ],
                  ),
                  const Gap(2),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Asset.location,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(4),

                      Expanded(
                        child: Text(
                          product.address ??
                              "Vasai Virar, Mahab Chowpatty, Surat, Gujarat",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ),
                      if (isPartner == false) Gap(4),
                      if (isPartner == false)
                        Text(
                          "- ${double.parse(product.distanceKm ?? "0.0").toStringAsFixed(2)} KM",
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.black,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '₹ ${double.tryParse(product.price ?? "0")?.toStringAsFixed(2) ?? "0.00"}/${product.filterValues?["uom"]["value"] ?? ""}',
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const Gap(2),
                      if (isPartner == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? MyColors.paleGreen
                                : MyColors.paleRed,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isActive ? "Active" : "Inactive",
                            style: MyTexts.regular14.copyWith(
                              fontFamily: MyTexts.SpaceGrotesk,
                              color: isActive ? MyColors.green : MyColors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (isPartner == false) const Gap(8),
                  if (isPartner == false) ...[
                    if ((product.status == null) && (product.stockQty != 0))
                      RoundedButton(
                        onTap: () {
                          ConnectionDialogs.showSendConnectionDialog(
                            context,
                            product,
                          );
                        },
                        fontSize: 10,
                        buttonName: "Add to Connect",
                        borderRadius: 9,
                        height: 40,
                        verticalPadding: 0,
                        width: Get.width / 2 - 24,
                      )
                    else if (product.status != null)
                      RoundedButton(
                        fontSize: 10,
                        buttonName: (product.status ?? "") == "pending"
                            ? "Request Sent"
                            : product.status ?? "",
                        borderRadius: 9,
                        height: 40,
                        verticalPadding: 0,
                        width: Get.width / 2 - 24,
                        color: MyColors.grey,
                      )
                    else if (product.isNotify == false &&
                        (product.outOfStock == true || product.stockQty == 0))
                      RoundedButton(
                        onTap: () {
                          Get.find<ConnectorSelectedProductController>()
                              .notifyMeApi(mID: product.id);
                        },
                        fontSize: 10,
                        buttonName: "Notify Me",
                        borderRadius: 9,
                        height: 40,
                        verticalPadding: 0,
                        width: Get.width / 2 - 24,
                      )
                    else if (product.isNotify == true)
                      RoundedButton(
                        onTap: null,
                        fontSize: 10,
                        buttonName: "Notified",
                        borderRadius: 9,
                        height: 40,
                        verticalPadding: 0,
                        width: Get.width / 2 - 24,
                        color: MyColors.grey,
                      ),
                  ],
                  const Gap(4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 12.99661349, longitude: 77.59205818,
