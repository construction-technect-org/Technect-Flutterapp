import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/core/widgets/common_service_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: const CommonAppBar(title: Text('Inventory'), isCenter: false),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: MyColors.grayF7,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Obx(() {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 🔸 Product toggle
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value !=
                                  "product") {
                                controller.selectedStatus.value = "product";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "product"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Product",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value !=
                                  "service") {
                                controller.selectedStatus.value = "service";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "service"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Service",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),

                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value != "design") {
                                controller.selectedStatus.value = "design";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "design"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Design",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value != "fleet") {
                                controller.selectedStatus.value = "fleet";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "fleet"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Fleet",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value != "tools") {
                                controller.selectedStatus.value = "tools";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "tools"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Tools",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value !=
                                  "equipment") {
                                controller.selectedStatus.value = "equipment";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "equipment"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "Equipment",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if (controller.selectedStatus.value != "ppe") {
                                controller.selectedStatus.value = "ppe";
                                controller.searchController.clear();
                                controller.searchQuery.value = "";
                                await controller.fetchProducts();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "ppe"
                                      ? 255
                                      : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "PPE",
                                    style: MyTexts.medium15.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              //
              // // 🔹 Search field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonTextField(
                  controller: controller.searchController,
                  onChange: (value) {
                    controller.searchProducts(value);
                  },
                  borderRadius: 22,
                  hintText: 'Search',
                  prefixIcon: SvgPicture.asset(
                    Asset.searchIcon,
                    height: 16,
                    width: 16,
                  ),
                ),
              ),

              // 🔹 The rest of your Obx grid section remains unchanged
              Obx(() {
                final isProduct = controller.selectedStatus.value == "product";
                final isEmptyList = isProduct
                    ? controller.filteredProducts.isEmpty
                    : controller.filteredService.isEmpty;

                if (isEmptyList && controller.searchQuery.value.isNotEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No ${isProduct ? "inventory" : "service"} found',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.dustyGray,
                        ),
                      ),
                    ),
                  );
                } else if (isEmptyList) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No ${isProduct ? "inventory" : "service"} available',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.dustyGray,
                        ),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: Obx(() {
                    if (controller.selectedStatus.value == "product") {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.78,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: controller.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final item = controller.filteredProducts[index];
                          return ProductCard(
                            product: item,
                            onApiCall: controller.fetchProducts,
                          );
                        },
                      );
                    } else {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.78,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: controller.filteredService.length,
                        itemBuilder: (context, index) {
                          final service = controller.filteredService[index];
                          return ServiceCard(
                            service: service,
                            onTap: () {
                              Get.toNamed(
                                Routes.SERVICE_DETAILS,
                                arguments: {
                                  "service": service,
                                  "isEdit": true,
                                  "onApiCall": () async {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    controller.selectedStatus.value = "service";
                                    controller.searchController.clear();
                                    controller.searchQuery.value = "";
                                    await controller.fetchProducts();
                                  },
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  }),
                );
              }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyColors.oldLacelight,
            onPressed: () {
              controller.selectedStatus.value == "product"
                  ? Get.toNamed(Routes.ADD_PRODUCT)
                  : Get.toNamed(Routes.ADD_SERVICES);
            },
            child: const Icon(Icons.add, color: Colors.black, size: 32),
          ),
        ),
      ),
    );
  }
}
