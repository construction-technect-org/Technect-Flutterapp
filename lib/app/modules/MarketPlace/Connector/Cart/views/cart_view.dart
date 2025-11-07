import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/core/widgets/common_service_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/controllers/cart_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class CartListView extends GetView<CartListController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Stack(
            children: [
              const CommonBgImage(),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Connect'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    action: [Obx(() => _buildStatusDropdown(controller))],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            // Tab Bar
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Obx(
                                () => Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: MyColors.grayF7,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onTabChanged(0);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  controller
                                                          .selectedTabIndex
                                                          .value ==
                                                      0
                                                  ? MyColors.primary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Product',
                                                style: MyTexts.medium15.copyWith(
                                                  color:
                                                      controller
                                                              .selectedTabIndex
                                                              .value ==
                                                          0
                                                      ? Colors.white
                                                      : MyColors.gray2E,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onTabChanged(1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  controller
                                                          .selectedTabIndex
                                                          .value ==
                                                      1
                                                  ? MyColors.primary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Service',
                                                style: MyTexts.medium15.copyWith(
                                                  color:
                                                      controller
                                                              .selectedTabIndex
                                                              .value ==
                                                          1
                                                      ? Colors.white
                                                      : MyColors.gray2E,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CommonTextField(
                              controller: controller.searchController,
                              onChange: (value) {
                                controller.searchItems(value);
                              },
                              borderRadius: 22,
                              hintText: 'Search',
                              prefixIcon: SvgPicture.asset(
                                Asset.searchIcon,
                                height: 16,
                                width: 16,
                              ),
                            ),
                            const Gap(10),
                            Obx(() {
                              // Product Tab
                              if (controller.selectedTabIndex.value == 0) {
                                if (controller.filteredProducts.isEmpty &&
                                    controller.searchQuery.value.isNotEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.of(context).size.height /
                                          3,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No products found',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.fontBlack,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            'Try searching with different keywords',
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (controller
                                    .filteredProducts
                                    .isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.of(context).size.height /
                                          3,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No products available',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.fontBlack,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            'Add your first product to get started',
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.grey,
                                            ),
                                          ),
                                          const Gap(20),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.6,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: controller.filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.filteredProducts[index];
                                    return ProductCard(
                                      isFromAdd: false,
                                      isFromConnector: true,
                                      product: item,
                                      onApiCall: () async {
                                        await controller.fetchCartList();
                                      },
                                      onWishlistTap: () async {
                                        controller.isLoading.value = true;
                                        await Get.find<HomeController>()
                                            .wishListApi(
                                              status: item.isInWishList == true
                                                  ? "remove"
                                                  : "add",
                                              mID: item.id ?? 0,
                                              onSuccess: () async {
                                                await controller
                                                    .fetchCartList();
                                              },
                                            );
                                        controller.isLoading.value = false;
                                      },
                                      onNotifyTap: () async {
                                        controller.isLoading.value = true;
                                        await Get.find<HomeController>()
                                            .notifyMeApi(
                                              mID: item.id ?? 0,
                                              onSuccess: () async {
                                                await controller
                                                    .fetchCartList();
                                              },
                                            );
                                        controller.isLoading.value = false;
                                      },
                                      onConnectTap: () {
                                        ConnectionDialogs.showSendConnectionDialog(
                                          context,
                                          item,
                                          isFromIn: true,
                                          onTap: () async {
                                            Get.back();
                                            controller.isLoading.value = true;
                                            await Get.find<HomeController>()
                                                .addToConnectApi(
                                                  mID:
                                                      item.merchantProfileId ??
                                                      0,
                                                  message: '',
                                                  pID: item.id ?? 0,
                                                  onSuccess: () async {
                                                    await controller
                                                        .fetchCartList();
                                                  },
                                                );
                                            controller.isLoading.value = false;
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                // Service Tab
                                if (controller.filteredServices.isEmpty &&
                                    controller.searchQuery.value.isNotEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.of(context).size.height /
                                          3,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No services found',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.fontBlack,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            'Try searching with different keywords',
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (controller
                                    .filteredServices
                                    .isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.of(context).size.height /
                                          3,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No services available',
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.fontBlack,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            'Add your first service to get started',
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.grey,
                                            ),
                                          ),
                                          const Gap(20),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.6,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: controller.filteredServices.length,
                                  itemBuilder: (context, index) {
                                    final service =
                                        controller.filteredServices[index];
                                    return ServiceCard(
                                      service: service,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.SERVICE_DETAILS,
                                          arguments: {'service': service},
                                        );
                                      },
                                      onConnectTap: () {
                                        ConnectionDialogs.showSendServiceConnectionDialog(
                                          context,
                                          service,
                                          isFromIn: true,
                                          onTap: (message) async {
                                            Get.back();
                                            controller.isLoading.value = true;
                                            await Get.find<HomeController>()
                                                .addServiceToConnectApi(
                                                  mID:
                                                      service
                                                          .merchantProfileId ??
                                                      0,
                                                  message: message,
                                                  sID: service.id ?? 0,
                                                  onSuccess: () async {
                                                    await controller
                                                        .fetchCartList();
                                                  },
                                                );
                                            controller.isLoading.value = false;
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown(CartListController controller) {
    final colorMap = {
      "All": MyColors.fontBlack,
      "pending": Colors.orange,
      "accepted": Colors.green,
      "rejected": Colors.red,
      "cancelled": Colors.red,
    };

    final selectedColor =
        colorMap[controller.selectedStatus.value] ?? MyColors.fontBlack;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      constraints: const BoxConstraints(maxWidth: 120),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedStatus.value,
          dropdownColor: Colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: selectedColor,
          ),
          style: MyTexts.medium14.copyWith(
            color: selectedColor,
            fontFamily: MyTexts.SpaceGrotesk,
          ),
          underline: const SizedBox(),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          items: [
            DropdownMenuItem(
              value: "All",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: 18,
                    color: MyColors.fontBlack,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "All",
                    style: MyTexts.medium15.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "pending",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.pending, size: 18, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    "Pending",
                    style: MyTexts.medium15.copyWith(
                      color: Colors.orange,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "accepted",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Accepted",
                    style: MyTexts.medium15.copyWith(
                      color: Colors.green,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "rejected",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    size: 18,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Rejected",
                    style: MyTexts.medium15.copyWith(
                      color: Colors.red,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "cancelled",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    size: 18,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Cancelled",
                    style: MyTexts.medium15.copyWith(
                      color: Colors.red,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ],
              ),
            ),
          ],
          selectedItemBuilder: (BuildContext context) {
            return [
              _buildSelectedItem(
                controller.selectedStatus.value,
                "All",
                Icons.filter_list,
                MyColors.fontBlack,
              ),
              _buildSelectedItem(
                controller.selectedStatus.value,
                "pending",
                Icons.pending,
                Colors.orange,
              ),
              _buildSelectedItem(
                controller.selectedStatus.value,
                "accepted",
                Icons.check_circle_outline,
                Colors.green,
              ),
              _buildSelectedItem(
                controller.selectedStatus.value,
                "rejected",
                Icons.cancel_outlined,
                Colors.red,
              ),
              _buildSelectedItem(
                controller.selectedStatus.value,
                "cancelled",
                Icons.cancel_outlined,
                Colors.red,
              ),
            ];
          },
          onChanged: (value) async {
            if (value != null) {
              controller.selectedStatus.value = value;
              await controller.fetchCartList(isLoad: true);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSelectedItem(
    String selectedValue,
    String value,
    IconData icon,
    Color color,
  ) {
    final isSelected = selectedValue == value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: isSelected ? color : color.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value == "All"
                ? "All"
                : value.substring(0, 1).toUpperCase() + value.substring(1),
            style: MyTexts.medium14.copyWith(
              color: isSelected ? color : color.withValues(alpha: 0.6),
              fontFamily: MyTexts.SpaceGrotesk,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
