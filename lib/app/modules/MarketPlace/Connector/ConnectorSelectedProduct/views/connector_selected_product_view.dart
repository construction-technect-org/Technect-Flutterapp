import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';

class SelectedProductView extends StatelessWidget {
  final controller = Get.put(SelectedProductController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.isProductView.value
                  ? 'Products'
                  : controller.mainCategoryName ?? '',
              style: MyTexts.regular18,
            ),
          ),
          backgroundColor: MyColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MyColors.fontBlack,
              size: 20,
            ),
            onPressed: () {
              if (controller.isProductView.value) {
                controller.goBackToCategoryView();
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Obx(() {
          if (controller.isProductView.value) {
            return _buildProductView(context);
          } else {
            return _buildCategoryView(context);
          }
        }),
      ),
    );
  }

  Widget _buildCategoryView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final subCategories = controller.subCategories;
    final products = controller.products;

    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.27,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
          ),
          child: ListView.separated(
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = subCategories[index];
              final isSelected =
                  controller.selectedSubCategoryId.value == subCategory.id;

              return GestureDetector(
                onTap: () => controller.selectSubCategory(index),
                child: Container(
                  height: 140,
                  color: const Color(0xFFFAFBFF),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                              ),
                              color: isSelected
                                  ? MyColors.primary
                                  : Colors.transparent,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [
                                    MyColors.custom('EAEAEA').withOpacity(0),
                                    MyColors.custom('EAEAEA'),
                                  ],
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child:
                                        subCategory.image != null &&
                                            (subCategory.image!.isNotEmpty)
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                APIConstants.bucketUrl +
                                                (subCategory.image ?? ''),
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.category,
                                                      color: MyColors.primary,
                                                      size: 24,
                                                    ),
                                          )
                                        : const Icon(
                                            Icons.category,
                                            color: MyColors.primary,
                                            size: 24,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(right: 10),
                      const SizedBox(height: 8),
                      Text(
                        subCategory.name ?? '',
                        style: MyTexts.medium14,
                        textAlign: TextAlign.center,
                      ).paddingOnly(right: 10, left: 10),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Color(0xFFEAEAEA),
              thickness: 1,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF))),
                ),
                child: Text(
                  controller.selectedSubCategory.value?.name ??
                      'Select a category',
                  style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text(
                          'No products available',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: (products.length / 3).ceil(),
                        itemBuilder: (context, rowIndex) {
                          final startIndex = rowIndex * 3;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildProductCategory(
                                    products[startIndex],
                                    startIndex,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: startIndex + 1 < products.length
                                      ? _buildProductCategory(
                                          products[startIndex + 1],
                                          startIndex + 1,
                                        )
                                      : const SizedBox(),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: startIndex + 2 < products.length
                                      ? _buildProductCategory(
                                          products[startIndex + 2],
                                          startIndex + 2,
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductCategory(ProductCategory product, int index) {
    final controller = Get.find<SelectedProductController>();

    return GestureDetector(
      onTap: () {
        controller.selectProduct(index);
        controller.productCategories.value =
            controller.mainCategory.value?.subCategories?.firstWhere((element) {
              return element.id == product.subCategoryId;
            }) ??
            SubCategory();
        controller.fetchProductsFromApi();
      },
      child: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: product.image != null && product.image!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                APIConstants.bucketUrl + product.image!,
                              ),
                              fit: BoxFit.fill,
                              onError: (exception, stackTrace) {},
                            )
                          : null,
                    ),
                    child: product.image == null || product.image!.isEmpty
                        ? const Icon(
                            Icons.inventory_2,
                            color: MyColors.primary,
                            size: 24,
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: Text(
                product.name ?? '',
                style: MyTexts.medium14,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();

    return Row(
      children: [
        // Left Side - Product Categories
        Container(
          width: MediaQuery.of(context).size.width * 0.27,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
          ),
          child: ListView.separated(
            itemCount: controller.productCategories.value.products?.length ?? 0,
            itemBuilder: (context, index) {
              final category =
                  controller.productCategories.value.products?[index];

              return GestureDetector(
                onTap: () => controller.selectProductCategory(index),
                child: Container(
                  height: 140,
                  color: const Color(0xFFFAFBFF),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              width: 5,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(10),
                                ),
                                color:
                                    controller
                                            .selectedProductCategoryIndex
                                            .value ==
                                        index
                                    ? MyColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [
                                    MyColors.custom('EAEAEA').withOpacity(0),
                                    MyColors.custom('EAEAEA'),
                                  ],
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child:
                                        category?.image != null &&
                                            (category?.image!.isNotEmpty ??
                                                false)
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                APIConstants.bucketUrl +
                                                (category?.image ?? ''),
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.category,
                                                      color: MyColors.primary,
                                                      size: 24,
                                                    ),
                                          )
                                        : const Icon(
                                            Icons.category,
                                            color: MyColors.primary,
                                            size: 24,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(right: 10),
                      const SizedBox(height: 8),
                      Text(
                        category?.name ?? '',
                        style: MyTexts.medium14,
                        textAlign: TextAlign.center,
                      ).paddingOnly(right: 10, left: 10),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Color(0xFFEAEAEA),
              thickness: 1,
            ),
          ),
        ),
        // Right Side - Products
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterButton(
                    label: 'Sort',
                    iconPath: Asset.sort,
                    onTap: () => controller.showSortBottomSheet(context),
                  ),
                  _buildFilterButton(
                    label: 'Location',
                    iconPath: Asset.location,
                    onTap: () => controller.showLocationBottomSheet(context),
                  ),

                  _buildFilterButton(
                    label: 'Filter',
                    iconPath: Asset.filter,
                    onTap: () => controller.showFilterBottomSheet(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                return controller.selectedSort.value == "Relevance"
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFBFF),
                          borderRadius: BorderRadius.circular(53),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.selectedSort.value,
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gray2E,
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              onTap: () {
                                controller.selectedSort.value = "Relevance";
                                controller.applySorting("Relevance");
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 13,
                              ),
                            ),
                          ],
                        ),
                      );
              }),
              const SizedBox(height: 10),
              if (controller.isLoadingProducts.value)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child:
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
                            final item =
                                controller
                                    .productListModel
                                    .value
                                    ?.data
                                    ?.products[index] ??
                                Product();
                            return ProductCard(
                              isFromAdd: false,
                              isFromConnector: true,
                              product: item,
                              onApiCall: () async {
                                await controller.fetchProductsFromApi(isLoading: false);
                              },
                              onWishlistTap: () async {
                                await Get.find<HomeController>().wishListApi(
                                  status: item.isInWishList == true ? "remove" : "add",
                                  mID: item.id ?? 0,
                                  onSuccess: () async {
                                    await controller.fetchProductsFromApi(isLoading: false);
                                  },
                                );

                              },
                              onNotifyTap: () async {
                                await Get.find<HomeController>().notifyMeApi(
                                  mID: item.id ?? 0,
                                  onSuccess: () async {
                                    await controller.fetchProductsFromApi(isLoading: false);
                                  },
                                );
                              },
                              onConnectTap: () {
                                ConnectionDialogs.showSendConnectionDialog(
                                  context,
                                  item,
                                  isFromIn: true,

                                  onTap: () async {
                                    Get.back();
                                    await Get.find<HomeController>().addToConnectApi(
                                      mID: item.merchantProfileId ?? 0,
                                      message: '',
                                      pID: item.id ?? 0,
                                      onSuccess: () async {
                                        await controller.fetchProductsFromApi(isLoading: false);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton({
    required String label,
    required String iconPath,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: MyTexts.medium14.copyWith(
                color: MyColors.custom('2E2E2E'),
              ),
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(iconPath, width: 16, height: 16),
          ],
        ),
      ),
    );
  }
}
