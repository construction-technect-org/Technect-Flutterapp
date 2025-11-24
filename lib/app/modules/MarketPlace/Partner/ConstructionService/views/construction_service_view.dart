import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/controllers/construction_service_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';

class ConstructionServiceView extends GetView<ConstructionServiceController> {
  static const double _leftPanelWidth = 0.27;
  static const double _itemHeight = 170.0;
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
          isProducts ? 'Services' : (controller.mainCategoryName ?? ''),
          style: MyTexts.regular18,
        );
      }),
      backgroundColor: MyColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: MyColors.fontBlack, size: 20),
        onPressed: () => controller.goBackToCategoryView(),
      ),
      actions: [
        if (myPref.role.val == "connector")
          GestureDetector(
            onTap: () => controller.openSelectAddressBottomSheet(
              onAddressChanged: () async {
                await controller.fetchServicesFromApi(isLoading: true);
              },
            ),
            child: SvgPicture.asset(
              Asset.location,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.SEARCH_SERVICE),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              Asset.searchIcon,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
      default:
        return [_index1LeftView(context), _index1RightView(context)];
    }
  }

  Widget _index0LeftView(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return _buildLeftSidebar(
      context: context,
      items: controller.subCategories,
      isSelected: (index) =>
          controller.selectedSubCategoryId.value == controller.subCategories[index].id,
      onTap: (index) => controller.lestSide0LeftView(index),
      getImageUrl: (item) =>
          item.image ??
          'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg',
      getName: (item) => item.name ?? '',
    );
  }

  Widget _index1LeftView(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    final services = controller.serviceCategories.value.serviceCategories ?? [];
    return _buildLeftSidebar(
      context: context,
      items: services,
      isSelected: (index) => controller.selectedServiceCategory.value?.id == services[index].id,
      onTap: (index) => controller.selectServiceCategoryFromGrid(index),
      getImageUrl: (_) =>
          controller.selectedSubCategory.value?.image ??
          'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg',
      getName: (item) => item.name ?? '',
      useObxForSelection: true,
    );
  }

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
                          Expanded(child: _buildCategoryImageContainer(getImageUrl(items[index]))),
                        ],
                      ).paddingOnly(right: _horizontalPadding),
                      const SizedBox(height: _itemSpacing),
                      Text(
                        getName(items[index]),
                        style: MyTexts.medium14,
                        textAlign: TextAlign.center,
                      ).paddingOnly(right: _horizontalPadding, left: _horizontalPadding),
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
                      Expanded(child: _buildCategoryImageContainer(getImageUrl(items[index]))),
                    ],
                  ).paddingOnly(right: _horizontalPadding),
                  const SizedBox(height: _itemSpacing),
                  Text(
                    getName(items[index]),
                    style: MyTexts.medium14,
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: _horizontalPadding, left: _horizontalPadding),
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
          colors: [MyColors.custom('EAEAEA').withValues(alpha: 0), MyColors.custom('EAEAEA')],
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
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.category, color: MyColors.primary, size: 24),
                  )
                : const Icon(Icons.category, color: MyColors.primary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _index0RightView(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(title: controller.selectedSubCategory.value?.name ?? 'Select a category'),
          Expanded(child: _buildProductCategoriesGrid(controller.serviceCategoryList)),
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

  Widget _buildHeader({required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Text(title, style: MyTexts.bold18.copyWith(color: MyColors.fontBlack)),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return Row(
      children: [
        const Gap(4),
        _buildFilterButton(
          label: 'Sort',
          iconPath: Asset.sort,
          onTap: () => controller.showSortBottomSheet(context),
        ),
        const Gap(4),
        _buildFilterButton(
          label: 'Location',
          iconPath: Asset.location,
          onTap: () => controller.showLocationBottomSheet(context),
        ),
        const Spacer(),
        const Gap(4),
        Obx(
          () => GestureDetector(
            onTap: () => controller.isGridView.value = !controller.isGridView.value,
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
    final controller = Get.find<ConstructionServiceController>();
    return Obx(
      () => (controller.selectedSort.value == "Relevance"
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFF),
                borderRadius: BorderRadius.circular(53),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.selectedSort.value,
                    style: MyTexts.medium13.copyWith(color: MyColors.gray2E),
                  ),
                  const Gap(8),
                  GestureDetector(
                    onTap: () {
                      controller.selectedSort.value = "Relevance";
                      controller.applySorting("Relevance");
                    },
                    child: const Icon(Icons.close, color: Colors.black, size: 13),
                  ),
                ],
              ),
            )),
    );
  }

  Widget _buildProductContent(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return Obx(() {
      if (controller.isLoadingServices.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Check if we have services data
      final hasServices = !(controller.serviceListModel.value.data?.services?.isEmpty ?? true);
      if (!hasServices) {
        return const Center(
          child: Text('No services available', style: TextStyle(color: Colors.grey, fontSize: 16)),
        );
      }

      // Always show services in grid or list view
      return Obx(
        () =>
            controller.isGridView.value ? _buildServicesGrid(context) : _buildServicesList(context),
      );
    });
  }

  Widget _buildProductCategoriesGrid(List<ServiceCategories> products) {
    final controller = Get.find<ConstructionServiceController>();
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
                  padding: EdgeInsets.only(right: colIndex < _itemsPerRow - 1 ? _itemSpacing : 0),
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

  // Circular Category Tiles
  Widget _buildCircularCategoryTile({
    required ServiceCategories product,
    required int index,
    required VoidCallback onTap,
  }) {
    final controller = Get.find<ConstructionServiceController>();
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildCircularImageContainer(
                controller.selectedSubCategory.value?.image ??
                    'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg',
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: _textHeight,
              child: Text(
                product.name ?? '',
                style: MyTexts.medium13,
                textAlign: TextAlign.center,
                maxLines: 2,
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
    final controller = Get.find<ConstructionServiceController>();
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: _itemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildCircularImageContainer(
                controller.selectedSubCategory.value?.image ??
                    'profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg',
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
    final controller = Get.find<ConstructionServiceController>();
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
                      APIConstants.bucketUrl + (controller.selectedSubCategory.value?.image ?? ''),
                    ),
                    fit: BoxFit.fill,
                    onError: (exception, stackTrace) {},
                  )
                : DecorationImage(
                    image: const NetworkImage(
                      '${APIConstants.bucketUrl}profile-images/1762584125856-184688724-WhatsApp Image 2025-11-08 at 12.07.08 PM.jpg',
                    ),
                    fit: BoxFit.fill,
                    onError: (exception, stackTrace) {},
                  ),
          ),
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
            Text(label, style: MyTexts.medium14.copyWith(color: MyColors.custom('2E2E2E'))),
            const SizedBox(width: 4),
            SvgPicture.asset(iconPath, width: 16, height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: myPref.role.val == "connector" ? 0.44 : 0.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: controller.serviceListModel.value.data?.services?.length ?? 0,
      itemBuilder: (context, index) {
        final services = controller.serviceListModel.value.data?.services;
        if (services == null || index >= services.length) {
          return const SizedBox.shrink();
        }
        final service = services[index];
        String imageUrl = "";
        if ((service.images ?? []).isNotEmpty) {
          imageUrl = APIConstants.bucketUrl + (service.images?.first.mediaS3Key ?? "");
        }

        return GestureDetector(
          onTap: () => Get.toNamed(
            Routes.SERVICE_DETAILS,
            arguments: {
              'service': service,
              "onConnectTap": () {
                ConnectionDialogs.showSendServiceConnectionDialog(
                  context,
                  service,
                  isFromIn: true,
                  onTap: (message, date, radius) async {
                    await Get.find<CommonController>().addServiceToConnectApi(
                      mID: service.merchantProfileId ?? 0,
                      message: message,
                      radius: radius,
                      date: date,
                      sID: service.id ?? 0,
                      onSuccess: () async {
                        Get.back();
                        await controller.fetchServicesFromApi(isLoading: false);
                      },
                    );
                  },
                );
              },
            },
          ),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        child: imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.build, size: 40),
                                ),
                              )
                            : Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.build, size: 40),
                              ),
                      ),
                      if (myPref.role.val == "connector")
                        if ((service.distanceKm ?? 0) > 0)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(3)),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: Text(
                                "${service.distanceKm?.toStringAsFixed(1)} km",
                                style: MyTexts.light12,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.serviceCategoryName ?? 'Service',
                          style: MyTexts.medium13,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                        const Gap(4),
                        Text(
                          service.merchantName ?? '',
                          style: MyTexts.regular12.copyWith(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        const Spacer(),
                        Text(
                          '₹${service.price ?? '0'}/${service.units ?? ''}',
                          style: MyTexts.bold13.copyWith(color: MyColors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        if (myPref.role.val == "connector") const SizedBox(height: 4),
                        if (myPref.role.val == "connector")
                          () {
                            final connectionStatus = service.connectionRequestStatus ?? '';
                            if (connectionStatus.isEmpty) {
                              return RoundedButton(
                                buttonName: 'Connect',
                                color: MyColors.primary,
                                fontColor: Colors.white,
                                onTap: () {
                                  ConnectionDialogs.showSendServiceConnectionDialog(
                                    context,
                                    service,
                                    isFromIn: true,
                                    onTap: (message, date, radius) async {
                                      await controller.addServiceToConnect(
                                        merchantProfileId: service.merchantProfileId ?? 0,
                                        serviceId: service.id ?? 0,
                                        message: message,
                                        radius: radius,
                                        date: date,
                                        onSuccess: () async {
                                          await controller.fetchServicesFromApi(isLoading: false);
                                        },
                                      );
                                    },
                                  );
                                },
                                height: 28,
                                borderRadius: 6,
                                verticalPadding: 0,
                                style: MyTexts.medium14.copyWith(color: Colors.white),
                              );
                            } else if (connectionStatus == 'pending') {
                              return RoundedButton(
                                color: MyColors.pendingBtn,
                                buttonName: 'Pending',
                                height: 28,
                                horizontalPadding: 20,
                                borderRadius: 6,
                                verticalPadding: 0,
                                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                              );
                            } else if (connectionStatus == 'accepted') {
                              return RoundedButton(
                                color: MyColors.grayEA,
                                buttonName: 'Connected',
                                height: 28,
                                borderRadius: 6,
                                verticalPadding: 0,
                                horizontalPadding: 20,
                                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                              );
                            } else if (connectionStatus == 'rejected') {
                              return RoundedButton(
                                color: MyColors.rejectBtn,
                                buttonName: 'Rejected',
                                height: 28,
                                borderRadius: 6,
                                verticalPadding: 0,
                                horizontalPadding: 20,
                                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                              );
                            }
                            return const SizedBox.shrink();
                          }(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildServicesList(BuildContext context) {
    final controller = Get.find<ConstructionServiceController>();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.serviceListModel.value.data?.services?.length ?? 0,
      itemBuilder: (context, index) {
        final services = controller.serviceListModel.value.data?.services;
        if (services == null || index >= services.length) {
          return const SizedBox.shrink();
        }
        final service = services[index];

        final imageUrl = APIConstants.bucketUrl + (service.images?.first.mediaS3Key ?? '');
        return GestureDetector(
          onTap: () => Get.toNamed(
            Routes.SERVICE_DETAILS,
            arguments: {
              'service': service,

              "onConnectTap": () {
                ConnectionDialogs.showSendServiceConnectionDialog(
                  context,
                  service,
                  isFromIn: true,
                  onTap: (message, date, radius) async {
                    await Get.find<CommonController>().addServiceToConnectApi(
                      mID: service.merchantProfileId ?? 0,
                      message: message,
                      radius: radius,
                      date: date,
                      sID: service.id ?? 0,
                      onSuccess: () async {
                        Get.back();
                        await controller.fetchServicesFromApi(isLoading: false);
                      },
                    );
                  },
                );
              },
            },
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(child: CircularProgressIndicator()),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.build, size: 40),
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Icon(Icons.build, size: 40),
                              ),
                      ),
                      if (myPref.role.val == "connector")
                        if ((service.distanceKm ?? 0) > 0)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              color: Colors.white,
                              child: Text(
                                "${service.distanceKm?.toStringAsFixed(1)} km",
                                style: MyTexts.light12,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceCategoryName ?? 'Service',
                        style: MyTexts.medium14.copyWith(color: MyColors.custom('2E2E2E')),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.merchantName ?? '',
                        style: MyTexts.regular12.copyWith(color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (service.description != null)
                        Text(
                          service.description!,
                          style: MyTexts.regular12.copyWith(color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${service.price ?? '0'}/${service.units ?? ''}',
                        style: MyTexts.bold14.copyWith(color: MyColors.primary),
                      ),
                      if (myPref.role.val == "connector") const SizedBox(height: 8),

                      if (myPref.role.val == "connector")
                        () {
                          final connectionStatus = service.connectionRequestStatus ?? '';
                          if (connectionStatus.isEmpty) {
                            return RoundedButton(
                              buttonName: 'Connect',
                              color: MyColors.primary,
                              fontColor: Colors.white,
                              onTap: () {
                                ConnectionDialogs.showSendServiceConnectionDialog(
                                  context,
                                  service,
                                  isFromIn: true,
                                  onTap: (message, date, radius) async {
                                    await controller.addServiceToConnect(
                                      merchantProfileId: service.merchantProfileId ?? 0,
                                      serviceId: service.id ?? 0,
                                      message: message,
                                      radius: radius,
                                      date: date,
                                      onSuccess: () async {
                                        await controller.fetchServicesFromApi(isLoading: false);
                                      },
                                    );
                                  },
                                );
                              },
                              height: 28,
                              borderRadius: 6,
                              verticalPadding: 0,
                              style: MyTexts.medium14.copyWith(color: Colors.white),
                            );
                          } else if (connectionStatus == 'pending') {
                            return RoundedButton(
                              color: MyColors.pendingBtn,
                              buttonName: 'Pending',
                              height: 28,
                              horizontalPadding: 20,
                              borderRadius: 6,
                              verticalPadding: 0,
                              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                            );
                          } else if (connectionStatus == 'accepted') {
                            return RoundedButton(
                              color: MyColors.grayEA,
                              buttonName: 'Connected',
                              height: 28,
                              borderRadius: 6,
                              verticalPadding: 0,
                              horizontalPadding: 20,
                              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                            );
                          } else if (connectionStatus == 'rejected') {
                            return RoundedButton(
                              color: MyColors.rejectBtn,
                              buttonName: 'Rejected',
                              height: 28,
                              borderRadius: 6,
                              verticalPadding: 0,
                              horizontalPadding: 20,
                              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                            );
                          }
                          return const SizedBox.shrink();
                        }(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
