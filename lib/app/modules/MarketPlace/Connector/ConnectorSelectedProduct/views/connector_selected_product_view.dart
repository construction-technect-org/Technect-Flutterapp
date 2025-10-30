import 'dart:developer';

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
    log('controller.navigationIndex.value ${controller.navigationIndex.value}');

    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: Obx(() {
            final isProducts = controller.navigationIndex.value >= 3;
            return Text(
              isProducts ? 'Products' : (controller.mainCategoryName ?? ''),
              style: MyTexts.regular18,
            );
          }),
          backgroundColor: MyColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MyColors.fontBlack,
              size: 20,
            ),
            onPressed: () {
              controller.goBackToCategoryView();
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {

                print(Get.find<HomeController>().profileData.value.data?.siteLocations);
              },
              child: SvgPicture.asset(
                Asset.location,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SEARCH_PRODUCT);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SvgPicture.asset(
                  Asset.searchIcon,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Obx(() {
          return buildLeftRightView(context);
        }),
      ),
    );
  }

  Widget buildLeftRightView(BuildContext context) {
    log('controller.navigationIndex.value ${controller.navigationIndex.value}');
    return Obx(
      () => Row(
        children: controller.navigationIndex.value == 0
            ? [
                // Left Side - Sub Categories
                index0LeftView(context),
                // Right Side - Products Categories
                index0RightView(context),
              ]
            : controller.navigationIndex.value == 1
            ? [
                // Left Side - Products Categories
                index1LeftView(context),
                // Right Side - Products
                index1RightView(context),
              ]
            : controller.navigationIndex.value == 2
            ? [
                // Left Side - Products Sub Categories
                index2LeftView(context),
                // Right Side - Products
                index2RightView(context),
              ]
            : [
                // Left Side - Products Sub Categories
                index3LeftView(context),
                // Right Side - Products
                index1RightView(context),
              ],
      ),
    );
  }

  Widget index0LeftView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final subCategories = controller.subCategories;

    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
      ),
      child: ListView.separated(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final item = subCategories[index];
          final isSelected = controller.selectedSubCategoryId.value == item.id;
          return GestureDetector(
            onTap: () => controller.lestSide0LeftView(index),
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
                                    (item.image != null &&
                                        item.image!.isNotEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            APIConstants.bucketUrl +
                                            (item.image ?? ''),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
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
                    item.name ?? '',
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: 10, left: 10),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFEAEAEA), thickness: 1),
      ),
    );
  }

  Widget index0RightView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final products = controller.products;
    return Expanded(
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
              controller.selectedSubCategory.value?.name ?? 'Select a category',
              style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
    );
  }

  Widget index1LeftView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final products = controller.productCategories.value.products ?? [];
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
      ),
      child: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

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
                                controller.selectedProductCategoryIndex.value ==
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
                                    ((controller
                                                .selectedSubCategory
                                                .value
                                                ?.image ??
                                            '')
                                        .isNotEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            APIConstants.bucketUrl +
                                            (controller
                                                    .selectedSubCategory
                                                    .value
                                                    ?.image ??
                                                ''),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
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
                    item.name ?? '',
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: 10, left: 10),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFEAEAEA), thickness: 1),
      ),
    );
  }

  Widget index1RightView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hide top controls if showing product subcategories
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
          Obx(
            () => controller.navigationIndex.value == 2
                ? const SizedBox.shrink()
                : (controller.selectedSort.value == "Relevance"
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
                        )),
          ),
          const SizedBox(height: 10),
          // Single Expanded for content area
          Expanded(
            child: Obx(() {
              if (controller.navigationIndex.value == 2) {
                final items = controller.productSubCategories;
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No sub categories available',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () => controller.selectProductSubCategory(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFEAEAEA),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image:
                                        (controller
                                                    .selectedSubCategory
                                                    .value
                                                    ?.image !=
                                                null &&
                                            (controller
                                                    .selectedSubCategory
                                                    .value
                                                    ?.image
                                                    ?.isNotEmpty ??
                                                false))
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              APIConstants.bucketUrl +
                                                  (controller
                                                          .selectedSubCategory
                                                          .value
                                                          ?.image ??
                                                      ''),
                                            ),
                                            fit: BoxFit.fill,
                                          )
                                        : null,
                                  ),
                                  child:
                                      (controller
                                                  .selectedSubCategory
                                                  .value
                                                  ?.image ==
                                              null ||
                                          (controller
                                                  .selectedSubCategory
                                                  .value
                                                  ?.image
                                                  ?.isEmpty ??
                                              true))
                                      ? const Icon(
                                          Icons.category,
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
                              item.name ?? '',
                              style: MyTexts.medium14,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (controller.isLoadingProducts.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final hasProducts =
                  !(controller.productListModel.value?.data?.products.isEmpty ??
                      true);
              if (!hasProducts) {
                return const Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount:
                    controller.productListModel.value?.data?.products.length ??
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
                          await controller.fetchProductsFromApi(
                            isLoading: false,
                          );
                        },
                      );
                    },
                    onNotifyTap: () async {
                      await Get.find<HomeController>().notifyMeApi(
                        mID: item.id ?? 0,
                        onSuccess: () async {
                          await controller.fetchProductsFromApi(
                            isLoading: false,
                          );
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
                              await controller.fetchProductsFromApi(
                                isLoading: false,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget index2LeftView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final products = controller.productCategories.value.products ?? [];
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
      ),
      child: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return GestureDetector(
            onTap: () => controller.leftSide2LeftView(index),
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
                                controller.selectedProductCategoryIndex.value ==
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
                                    (controller
                                                .selectedSubCategory
                                                .value
                                                ?.image ??
                                            '')
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            APIConstants.bucketUrl +
                                            (controller
                                                    .selectedSubCategory
                                                    .value
                                                    ?.image ??
                                                ''),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
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
                    item.name ?? '',
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: 10, left: 10),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFEAEAEA), thickness: 1),
      ),
    );
  }

  Widget index2RightView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final products = controller.productSubCategories;
    return Expanded(
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
              controller.selectedProduct.value?.name ?? 'Select a category',
              style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: (products.length / 3).ceil(),
              itemBuilder: (context, rowIndex) {
                final startIndex = rowIndex * 3;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: _subProductTile(
                          products[startIndex],
                          startIndex,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: startIndex + 1 < products.length
                            ? _subProductTile(
                                products[startIndex + 1],
                                startIndex + 1,
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: startIndex + 2 < products.length
                            ? _subProductTile(
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
    );
  }

  Widget _buildProductCategory(ProductCategory product, int index) {
    final controller = Get.find<SelectedProductController>();

    return GestureDetector(
      onTap: () => controller.rightSide0RightView(index),
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
                      image:
                          (controller.selectedSubCategory.value?.image ?? '')
                              .isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                APIConstants.bucketUrl +
                                    (controller
                                            .selectedSubCategory
                                            .value
                                            ?.image ??
                                        ''),
                              ),
                              fit: BoxFit.fill,
                              onError: (exception, stackTrace) {},
                            )
                          : null,
                    ),
                    child:
                        (controller.selectedSubCategory.value?.image ?? '')
                            .isEmpty
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

  Widget _subProductTile(ProductSubCategory product, int index) {
    final controller = Get.find<SelectedProductController>();

    return GestureDetector(
      onTap: () {
        controller.selectProductSubCategory(index);
        controller.navigationIndex.value = 3;
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
                      image: controller.selectedSubCategory.value?.image != null
                          ? DecorationImage(
                              image: NetworkImage(
                                APIConstants.bucketUrl +
                                    (controller
                                            .selectedSubCategory
                                            .value
                                            ?.image ??
                                        ''),
                              ),
                              fit: BoxFit.fill,
                              onError: (exception, stackTrace) {},
                            )
                          : null,
                    ),
                    child:
                        controller.selectedSubCategory.value?.image == null ||
                            (controller
                                    .selectedSubCategory
                                    .value
                                    ?.image
                                    ?.isEmpty ??
                                true)
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

  Widget index3LeftView(BuildContext context) {
    final controller = Get.find<SelectedProductController>();
    final products = controller.productSubCategories;

    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(right: BorderSide(color: Color(0xFFE9ECEF))),
      ),
      child: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return GestureDetector(
            onTap: () => controller.selectProductSubCategory(index),
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
                                        .selectedSubProductCategoryIndex
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
                                    (controller
                                                .selectedSubCategory
                                                .value
                                                ?.image ??
                                            '')
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            APIConstants.bucketUrl +
                                            (controller
                                                    .selectedSubCategory
                                                    .value
                                                    ?.image ??
                                                ''),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
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
                    item.name ?? '',
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: 10, left: 10),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFEAEAEA), thickness: 1),
      ),
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
