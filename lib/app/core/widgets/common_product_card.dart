import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onNotifyTap;
  final VoidCallback? onConnectTap;
  final VoidCallback? onApiCall;
  bool? isFromAdd;
  bool? isFromConnector;
  final bool isListView;

  ProductCard({
    super.key,
    required this.product,
    this.onWishlistTap,
    this.onNotifyTap,
    this.onConnectTap,
    this.onApiCall,
    this.isFromAdd,
    this.isFromConnector,
    this.isListView = false,
  });

  @override
  Widget build(BuildContext context) {
    return isListView ? _buildListUI(context) : _buildGridUI(context);

  }
  Widget _buildGridUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            "product": product,
            "isFromAdd": isFromAdd,
            "isFromConnector": isFromConnector,
            "onApiCall": onApiCall,
          },
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ProductImage(
              product: product,
              onWishlistTap: onWishlistTap,
              isFromConnector: isFromConnector,
              isFromAdd: isFromAdd,
            ),
          ),
          const SizedBox(height: 10),
          _buildProductInfo(),
          const SizedBox(height: 6),
          _buildLocationRow(),
          const SizedBox(height: 6),
          _buildPriceSection(),
          if (myPref.role.val == "connector")
            if (isFromAdd == false && isFromConnector == true) ...[
              const SizedBox(height: 8),
              ProductActionButton(
                product: product,
                onNotifyTap: onNotifyTap,
                onConnectTap: onConnectTap,
              ),
            ],
        ],
      ),
    );
  }
  Widget _buildListUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            "product": product,
            "isFromAdd": isFromAdd,
            "isFromConnector": isFromConnector,
            "onApiCall": onApiCall,
          },
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 140,
              child: ProductImage(
                product: product,
                onWishlistTap: onWishlistTap,
                isFromConnector: isFromConnector,
                isFromAdd: isFromAdd,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(),
                  const SizedBox(height: 6),
                  _buildLocationRow(),
                  const SizedBox(height: 6),
                  _buildPriceSection(),
                  if (myPref.role.val == "connector") ...[
                    const SizedBox(height: 8),
                    ProductActionButton(
                      product: product,
                      onNotifyTap: onNotifyTap,
                      onConnectTap: onConnectTap,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        product.categoryProductName ?? 'Unknown Product',
        style: MyTexts.medium14.copyWith(color: MyColors.custom('2E2E2E')),
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(4),
            child: getImageView(
              finalUrl: APIConstants.bucketUrl + (product.merchantLogo ?? ""),
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          ),
          const Gap(4),
          Expanded(
            child: Text(
              product.brand ?? 'Unknown Brand',
              style: MyTexts.medium12.copyWith(
                color: MyColors.custom('545454'),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildLocationRow() => Row(
    children: [
      Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
      const SizedBox(width: 4),
      Expanded(
        child: Text(
          product.address ?? 'Unknown Address',
          style: MyTexts.regular12.copyWith(color: MyColors.custom('545454')),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  Widget _buildPriceSection() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          MyColors.custom('FFF9BD'),
          MyColors.custom('FFF9BD').withValues(alpha: 0.1),
        ],
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '₹ ',
          style: MyTexts.medium14.copyWith(color: MyColors.custom('0B1429')),
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: MyTexts.medium12.copyWith(color: Colors.grey[600]),
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
  );
}

class ProductImage extends StatelessWidget {
  final Product product;
  final VoidCallback? onWishlistTap;
  final bool? isFromAdd;
  final bool? isFromConnector;

  const ProductImage({
    super.key,
    required this.product,
    this.onWishlistTap,
    this.isFromAdd,
    this.isFromConnector,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = ProductUtils.getFirstImageUrl(product);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          child: imageUrl != null
              ? Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.inventory_2,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                )
              : const Icon(Icons.inventory_2, size: 40, color: Colors.grey),
        ),
        if (product.outOfStock == true || (product.stockQty ?? 0) <= 0)
          const ColoredBox(
            color: Colors.black38,
            child: Center(
              child: Text(
                "Out of stock",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        _buildTopRow(),
      ],
    );
  }

  Widget _buildTopRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (myPref.role.val == "connector")
        if ((product.distanceKm ?? "").isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.white,
            child: Text(
              "${double.parse(product.distanceKm ?? '0').toStringAsFixed(1)} km",
              style: MyTexts.light14,
            ),
          ),
      const Spacer(),
      if (myPref.role.val == "connector")
        if (isFromAdd == false && isFromConnector == true)
          GestureDetector(
            onTap: onWishlistTap,
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
    ],
  );
}

class ProductActionButton extends StatelessWidget {
  final Product product;
  final VoidCallback? onNotifyTap;
  final VoidCallback? onConnectTap;

  const ProductActionButton({
    super.key,
    required this.product,
    this.onNotifyTap,
    this.onConnectTap,
  });

  @override
  Widget build(BuildContext context) {
    if (product.outOfStock == true || (product.stockQty ?? 0) <= 0) {
      return _buildNotifyButton();
    }

    switch (product.status) {
      case 'pending':
        return _buildStaticButton('Pending', MyColors.pendingBtn);
      case 'accepted':
        return _buildStaticButton('Connected', MyColors.grayEA);
      case 'rejected':
        return _buildStaticButton('Rejected', MyColors.rejectBtn);
      default:
        return _buildConnectButton(context);
    }
  }

  Widget _buildNotifyButton() {
    if (product.isNotify == true) {
      return RoundedButton(
        buttonName: 'Notified',
        color: Colors.grey[400],
        fontColor: Colors.white,
        height: 32,
        borderRadius: 8,
      );
    }
    return RoundedButton(
      buttonName: 'Notify Me',
      color: MyColors.primary,
      fontColor: Colors.white,
      onTap: onNotifyTap,
      height: 32,
      borderRadius: 8,
    );
  }

  Widget _buildStaticButton(String text, Color color) {
    return RoundedButton(
      buttonName: text,
      color: color,
      borderRadius: 8,
      height: 32,
      style: MyTexts.medium14.copyWith(color: MyColors.gray54),
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return RoundedButton(
      buttonName: 'Connect',
      color: MyColors.primary,
      fontColor: Colors.white,
      onTap: onConnectTap,
      height: 32,
      borderRadius: 8,
      verticalPadding: 0,
      style: MyTexts.medium14.copyWith(color: Colors.white),
    );
  }
}

class ProductUtils {
  static String? getFirstImageUrl(Product product) {
    if (product.images != null && product.images!.isNotEmpty) {
      final img = product.images!.first;
      if (img.s3Key?.isNotEmpty ?? false) {
        return APIConstants.bucketUrl + img.s3Key!;
      }
    }
    if (product.productImage?.isNotEmpty ?? false) {
      return APIConstants.bucketUrl + product.productImage!;
    }
    return null;
  }
}
