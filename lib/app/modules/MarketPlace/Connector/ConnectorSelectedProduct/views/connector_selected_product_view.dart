import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class SelectedProductView extends StatelessWidget {
  final controller = Get.put(ConnectorSelectedProductController());

  // Constants
  static const double _leftPanelWidth = 0.27;
  static const double _itemHeight = 120.0;
  static const double _imageHeight = 80.0;
  static const double _selectionBarWidth = 5.0;
  static const double _textHeight = 40.0;
  static const double _horizontalPadding = 10.0;
  static const double _itemSpacing = 8.0;
  static const Color _sidebarBgColor = Color(0xFFF8F9FA);
  static const Color _itemBgColor = Color(0xFFFAFBFF);
  static const Color _borderColor = Color(0xFFE9ECEF);
  static const Color _dividerColor = Color(0xFFEAEAEA);
  static const int _itemsPerRow = 3;

  @override
  Widget build(BuildContext context) {
    log('controller.navigationIndex.value ${controller.navigationIndex.value}');

    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: _buildAppBar(),
        body: Obx(() => _buildLeftRightView(context)),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
        onPressed: () => controller.goBackToCategoryView(),
      ),
      actions: [
        if (myPref.role.val == "connector")
          GestureDetector(
            onTap: () => controller.openSelectAddressBottomSheet(
              onAddressChanged: () async {
                await controller.fetchProductsFromApi(isLoading: true);
              },
            ),
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
          onTap: () => Get.toNamed(Routes.SEARCH_PRODUCT),
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
    );
  }

  Widget _buildLeftRightView(BuildContext context) {
    log('controller.navigationIndex.value ${controller.navigationIndex.value}');
    return Obx(() {
      final index = controller.navigationIndex.value;
      return Row(children: _getViewForIndex(context, index));
    });
  }

  List<Widget> _getViewForIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        return [_index0LeftView(context), _index0RightView(context)];
      case 1:
        return [_index1LeftView(context), _index1RightView(context)];
      case 2:
        return [_index2LeftView(context), _index2RightView(context)];
      default:
        return [_index3LeftView(context), _index1RightView(context)];
    }
  }

  // Left Panel Views
  Widget _index0LeftView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return _buildLeftSidebar(
      context: context,
      items: controller.subCategories,
      isSelected: (index) =>
          controller.selectedSubCategoryId.value ==
          controller.subCategories[index].id,
      onTap: (index) => controller.lestSide0LeftView(index),
      getImageUrl: (item) => item.image ?? '',
      getName: (item) => item.name ?? '',
    );
  }

  Widget _index1LeftView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    final products = controller.productCategories.value.products ?? [];
    return _buildLeftSidebar(
      context: context,
      items: products,
      isSelected: (index) =>
          controller.selectedProductCategoryIndex.value == index,
      onTap: (index) => controller.selectProductCategory(index),
      getImageUrl: (_) => controller.selectedSubCategory.value?.image ?? '',
      getName: (item) => item.name ?? '',
      useObxForSelection: true,
    );
  }

  Widget _index2LeftView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    final products = controller.productCategories.value.products ?? [];
    return _buildLeftSidebar(
      context: context,
      items: products,
      isSelected: (index) =>
          controller.selectedProductCategoryIndex.value == index,
      onTap: (index) => controller.leftSide2LeftView(index),
      getImageUrl: (_) => controller.selectedSubCategory.value?.image ?? '',
      getName: (item) => item.name ?? '',
      useObxForSelection: true,
    );
  }

  Widget _index3LeftView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    final products = controller.productSubCategories;
    return _buildLeftSidebar(
      context: context,
      items: products,
      isSelected: (index) =>
          controller.selectedSubProductCategoryIndex.value == index,
      onTap: (index) => controller.selectProductSubCategory(index),
      getImageUrl: (_) => controller.selectedSubCategory.value?.image ?? '',
      getName: (item) => item.name ?? '',
      useObxForSelection: true,
    );
  }

  // Reusable Left Sidebar Widget
  Widget _buildLeftSidebar<T>({
    required BuildContext context,
    required List<T> items,
    required bool Function(int) isSelected,
    required void Function(int) onTap,
    required String Function(T) getImageUrl,
    required String Function(T) getName,
    bool useObxForSelection = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * _leftPanelWidth,
      decoration: const BoxDecoration(
        color: _sidebarBgColor,
        border: Border(right: BorderSide(color: _borderColor)),
      ),
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (useObxForSelection) {
            return Obx(() {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  height: _itemHeight,
                  color: _itemBgColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _buildSelectionBarWidget(isSelected(index)),
                          const SizedBox(width: _selectionBarWidth),
                          Expanded(
                            child: _buildCategoryImageContainer(
                              getImageUrl(items[index]),
                            ),
                          ),
                        ],
                      ).paddingOnly(right: _horizontalPadding),
                      const SizedBox(height: _itemSpacing),
                      Text(
                        getName(items[index]),
                        style: MyTexts.medium13,
                        textAlign: TextAlign.center,
                      ).paddingOnly(
                        right: _horizontalPadding,
                        left: _horizontalPadding,
                      ),
                    ],
                  ),
                ),
              );
            });
          }
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              height: _itemHeight,
              color: _itemBgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buildSelectionBarWidget(isSelected(index)),
                      const SizedBox(width: _selectionBarWidth),
                      Expanded(
                        child: _buildCategoryImageContainer(
                          getImageUrl(items[index]),
                        ),
                      ),
                    ],
                  ).paddingOnly(right: _horizontalPadding),
                  const SizedBox(height: _itemSpacing),
                  Text(
                    getName(items[index]),
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(
                    right: _horizontalPadding,
                    left: _horizontalPadding,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: _dividerColor, thickness: 1),
      ),
    );
  }

  Widget _buildSelectionBarWidget(bool isSelected) {
    return Container(
      width: _selectionBarWidth,
      height: _imageHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
        color: isSelected ? MyColors.primary : Colors.transparent,
      ),
    );
  }

  Widget _buildCategoryImageContainer(String imageUrl) {
    final hasImage = imageUrl.isNotEmpty;
    final fullImageUrl = hasImage ? (APIConstants.bucketUrl + imageUrl) : '';

    return Container(
      width: double.infinity,
      height: _imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            MyColors.custom('EAEAEA').withValues(alpha: 0),
            MyColors.custom('EAEAEA'),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: hasImage
                ? CachedNetworkImage(
                    imageUrl: fullImageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.category,
                      color: MyColors.primary,
                      size: 24,
                    ),
                  )
                : const Icon(Icons.category, color: MyColors.primary, size: 24),
          ),
        ],
      ),
    );
  }

  // Right Panel Views
  Widget _index0RightView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title:
                controller.selectedSubCategory.value?.name ??
                'Select a category',
          ),
          Expanded(child: _buildProductCategoriesGrid(controller.products)),
        ],
      ),
    );
  }

  Widget _index1RightView(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterButtons(context),
          const SizedBox(height: 10),
          _buildSortChip(),
          const SizedBox(height: 10),
          Expanded(child: _buildProductContent(context)),
        ],
      ),
    );
  }

  Widget _index2RightView(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            title:
                controller.selectedProduct.value?.name ?? 'Select a category',
          ),
          Expanded(
            child: _buildSubProductCategoriesList(
              controller.productSubCategories,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Text(
        title,
        style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Gap(4),
        _buildFilterButton(
          label: 'Sort',
          iconPath: Asset.sort,
          onTap: () => controller.showSortBottomSheet(context),
        ),
        const Gap(2),
        _buildFilterButton(
          label: 'Location',
          iconPath: Asset.location,
          onTap: () => controller.showLocationBottomSheet(context),
        ),
        const Gap(2),
        _buildFilterButton(
          label: 'Filter',
          iconPath: Asset.filter,
          onTap: () => controller.showFilterBottomSheet(context),
        ),
        const Spacer(),
        const Gap(2),
        Obx(
          () => GestureDetector(
            onTap: () =>
                controller.isGridView.value = !controller.isGridView.value,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Icon(
                controller.isGridView.value ? Icons.list : Icons.grid_view,
                size: 20,
                color: MyColors.custom('2E2E2E'),
              ),
            ),
          ),
        ),
        const Gap(4),
      ],
    );
  }

  Widget _buildSortChip() {
    final controller = Get.find<ConnectorSelectedProductController>();
    return Obx(
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
    );
  }

  Widget _buildProductContent(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return Obx(() {
      if (controller.navigationIndex.value == 2) {
        return _buildSubProductCategoriesGrid(controller.productSubCategories);
      }
      if (controller.isLoadingProducts.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final hasProducts =
          !(controller.productListModel.value?.data?.products.isEmpty ?? true);
      if (!hasProducts) {
        return const Center(
          child: Text(
            'No products available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }
      return Obx(
        () => controller.isGridView.value
            ? _buildProductsGrid(context)
            : _buildProductsList(context),
      );
    });
  }

  Widget _buildProductCategoriesGrid(List<ProductCategory> products) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: (products.length / _itemsPerRow).ceil(),
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * _itemsPerRow;
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: List.generate(_itemsPerRow, (colIndex) {
              final index = startIndex + colIndex;
              if (index >= products.length) {
                return const Expanded(child: SizedBox());
              }
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: colIndex < _itemsPerRow - 1 ? _itemSpacing : 0,
                  ),
                  child: _buildCircularCategoryTile(
                    product: products[index],
                    index: index,
                    onTap: () => controller.rightSide0RightView(index),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildSubProductCategoriesList(List<ProductSubCategory> products) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: (products.length / _itemsPerRow).ceil(),
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * _itemsPerRow;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: List.generate(_itemsPerRow, (colIndex) {
              final index = startIndex + colIndex;
              if (index >= products.length) {
                return const Expanded(child: SizedBox());
              }
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: colIndex < _itemsPerRow - 1 ? _itemSpacing : 0,
                  ),
                  child: _buildCircularSubProductTile(
                    product: products[index],
                    index: index,
                    onTap: () {
                      controller.selectProductSubCategory(index);
                      controller.navigationIndex.value = 3;
                    },
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildSubProductCategoriesGrid(List<ProductSubCategory> items) {
    final controller = Get.find<ConnectorSelectedProductController>();
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
                child: _buildCircularImageContainer(
                  controller.selectedSubCategory.value?.image ?? '',
                ),
              ),
              const SizedBox(height: _itemSpacing),
              SizedBox(
                height: _textHeight,
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

  Widget _buildProductsGrid(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: controller.productListModel.value?.data?.products.length ?? 0,
      itemBuilder: (context, index) {
        final item =
            controller.productListModel.value?.data?.products[index] ??
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
              onTap: (message, date, radius) async {
                Get.back();
                await Get.find<HomeController>().addToConnectApi(
                  mID: item.merchantProfileId ?? 0,
                  uom: item.filterValues?["uom"]["value"] ?? "",
                  quantity: item.stockQty.toString(),
                  message: message,
                  radius: radius,
                  date: date,
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
    );
  }

  Widget _buildProductsList(BuildContext context) {
    final controller = Get.find<ConnectorSelectedProductController>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.productListModel.value?.data?.products.length ?? 0,
      itemBuilder: (context, index) {
        final item =
            controller.productListModel.value?.data?.products[index] ??
            Product();

        return ProductCard(
          product: item,
          isFromAdd: false,
          isFromConnector: true,
          isListView: true,
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
              onTap: (message, date, radius) async {
                Get.back();
                await Get.find<HomeController>().addToConnectApi(
                  mID: item.merchantProfileId ?? 0,
                  uom: item.filterValues?["uom"]["value"] ?? "",
                  quantity: item.stockQty.toString(),
                  message: message,
                  radius: radius,
                  date: date,
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
    );
  }

  Widget _buildCircularCategoryTile({
    required ProductCategory product,
    required int index,
    required VoidCallback onTap,
  }) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: _itemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildCircularImageContainer(
                controller.selectedSubCategory.value?.image ?? '',
              ),
            ),
            const SizedBox(height: _itemSpacing),
            SizedBox(
              height: _textHeight,
              child: Text(
                product.name ?? '',
                style: MyTexts.medium13,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularSubProductTile({
    required ProductSubCategory product,
    required int index,
    required VoidCallback onTap,
  }) {
    final controller = Get.find<ConnectorSelectedProductController>();
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: _itemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildCircularImageContainer(
                controller.selectedSubCategory.value?.image ?? '',
              ),
            ),
            const SizedBox(height: _itemSpacing),
            SizedBox(
              height: _textHeight,
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

  Widget _buildCircularImageContainer(String imageUrl) {
    final controller = Get.find<ConnectorSelectedProductController>();
    final hasImage =
        imageUrl.isNotEmpty &&
        controller.selectedSubCategory.value?.image != null &&
        (controller.selectedSubCategory.value?.image?.isNotEmpty ?? false);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _dividerColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: hasImage
                ? DecorationImage(
                    image: NetworkImage(
                      APIConstants.bucketUrl +
                          (controller.selectedSubCategory.value?.image ?? ''),
                    ),
                    fit: BoxFit.fill,
                    onError: (exception, stackTrace) {},
                  )
                : null,
          ),
          child: !hasImage
              ? const Icon(Icons.inventory_2, color: MyColors.primary, size: 24)
              : null,
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
            const SizedBox(width: 4),
            SvgPicture.asset(iconPath, width: 16, height: 16),
          ],
        ),
      ),
    );
  }
}
