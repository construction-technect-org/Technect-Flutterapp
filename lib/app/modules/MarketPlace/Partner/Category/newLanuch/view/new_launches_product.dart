import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/controller/new_launch_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class NewLaunchesProduct extends StatelessWidget {
  NewLaunchesProduct({super.key});

  final controller = Get.put<NewLaunchController>(NewLaunchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: const Text(""),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        return Expanded(
          child:
              controller.isLoading.value?
              const Center(child: CircularProgressIndicator()):
          (controller
              .productListModel
              .value
              ?.data
              ?.products
              .isEmpty ??
              true)
              ? const Center(
            child: Text(
              'No products available',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
              : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount:
            controller
                .productListModel
                .value
                ?.data
                ?.products
                .length ??
                0,
            itemBuilder: (context, index) {
              final product =
                  controller
                      .productListModel
                      .value
                      ?.data
                      ?.products[index] ??
                      Product();
              return _buildProductCard(product, context);
            },
          ),
        );
      }),
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            "product": product,
            "isFromAdd": false,
            "isFromConnector": true,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                        child: Center(
                          child: _getFirstImageUrl(product) != null
                              ? CachedNetworkImage(
                            imageUrl: _getFirstImageUrl(product)!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.inventory_2,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                          )
                              : Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.inventory_2,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      if (product.outOfStock == true ||
                          (product.stockQty ?? 0) <= 0)
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Center(
                            child: Text(
                              "Out of stock",
                              style: MyTexts.medium13.copyWith(
                                color: Colors.white,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 10,
                      //     vertical: 6,
                      //   ),
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.only(
                      //       bottomRight: Radius.circular(4),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     "${double.parse(product.distanceKm ?? '0').toStringAsFixed(1)} km",
                      //     style: MyTexts.light14,
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.wishListApi(
                              status: product.isInWishList == true
                                  ? "remove"
                                  : "add",
                              mID: product.id ?? 0,
                            );
                          },
                          child: Icon(
                            (product.isInWishList ?? false)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 24,
                            color: (product.isInWishList ?? false)
                                ? MyColors.custom('E53D26')
                                : MyColors.gray54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                product.categoryProductName ?? 'Unknown Product',
                style: MyTexts.medium14.copyWith(
                  color: MyColors.custom('2E2E2E'),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                product.brand ?? 'Unknown Product',
                style: MyTexts.medium12.copyWith(
                  color: MyColors.custom('545454'),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      product.address ?? 'Unknown Product',
                      style: MyTexts.regular12.copyWith(
                        color: MyColors.custom('545454'),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColors.custom('FFF9BD'),
                      MyColors.custom('FFF9BD').withOpacity(0.1),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          '₹ ',
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.custom('0B1429'),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  product.price ?? 'N/A',
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.custom('0B1429'),
                                  ),
                                ),
                                Text(
                                  '/ unit',
                                  style: MyTexts.medium12.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Ex factory price',
                              style: MyTexts.medium12.copyWith(
                                color: MyColors.custom('545454'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: _buildActionButton(product, context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _getFirstImageUrl(Product product) {
    // Check if product has images array (List<ProductImage>)
    if (product.images != null && (product.images?.isNotEmpty ?? false)) {
      final firstImage = product.images!.first;
      if (firstImage.s3Url != null && firstImage.s3Url
          .toString()
          .isNotEmpty) {
        return firstImage.s3Url;
      }
      if (firstImage.s3Key != null && firstImage.s3Key
          .toString()
          .isNotEmpty) {
        return APIConstants.bucketUrl + firstImage.s3Key.toString();
      }
    }

    // Fallback to single productImage field
    if (product.productImage != null &&
        (product.productImage?.isNotEmpty ?? false)) {
      return APIConstants.bucketUrl + (product.productImage ?? '');
    }

    return null;
  }

  Widget _buildActionButton(Product product, BuildContext context) {
    if (product.outOfStock == true || (product.stockQty ?? 0) <= 0) {
      if (product.isNotify == true) {
        return RoundedButton(
          buttonName: 'Notified',
          color: Colors.grey[400],
          fontColor: Colors.white,
          height: 32,
          borderRadius: 8,
          fontSize: 16.sp,
          style: MyTexts.medium14.copyWith(color: Colors.white),
        );
      } else {
        return RoundedButton(
          buttonName: 'Notify Me',
          color: MyColors.primary,
          fontColor: Colors.white,
          onTap: () {
            controller.notifyMeApi(mID: product.id ?? 0);
          },
          height: 32,
          fontSize: 16.sp,
          borderRadius: 8,
          style: MyTexts.medium14.copyWith(color: Colors.white),
        );
      }
    }

    final String? connectionStatus = product.status;

    if (connectionStatus == 'pending') {
      return RoundedButton(
        buttonName: 'Pending',
        color: MyColors.pendingBtn,
        borderRadius: 8,
        fontSize: 16.sp,
        height: 32,
        style: MyTexts.medium14.copyWith(color: MyColors.gray54),
      );
    } else if (connectionStatus == 'accepted') {
      return RoundedButton(
        buttonName: 'Connected',
        color: MyColors.grayEA,
        borderRadius: 8,
        fontSize: 16.sp,
        height: 32,
        style: MyTexts.medium14.copyWith(color: MyColors.gray54),
      );
    } else if (connectionStatus == 'rejected') {
      return RoundedButton(
        buttonName: 'Rejected',
        color: MyColors.rejectBtn,
        borderRadius: 8,
        fontSize: 16.sp,
        height: 32,
        style: MyTexts.medium14.copyWith(color: MyColors.gray54),
      );
    } else {
      return RoundedButton(
        buttonName: 'Connect',
        color: MyColors.primary,
        fontColor: Colors.white,
        onTap: () {
          ConnectionDialogs.showSendConnectionDialog(
            context,
            product,
            isFromIn: true,
            onTap: () {
              Get.back();
              controller.addToConnectApi(
                mID: product.merchantProfileId ?? 0,
                message: '',
                pID: product.id ?? 0,
              );
            },
          );
        },
        height: 32,
        borderRadius: 8,
        verticalPadding: 0,
        style: MyTexts.medium14.copyWith(color: Colors.white),
      );
    }
  }

}
