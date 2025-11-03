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
          appBar: CommonAppBar(
            title: const Text('Inventory'),
            isCenter: false,
            action: [
              Obx(() {
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.grayF7,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedStatus.value,
                      dropdownColor: Colors.white,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 22,
                        color: Colors.black,
                      ),
                      style: MyTexts.medium16.copyWith(
                        color: Colors.black,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "product",
                          child: Text(
                            "Product",
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "service",
                          child: Text(
                            "Service",
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) async {
                        if (value != null) {
                          if (value != controller.selectedStatus.value) {
                            controller.searchQuery.value="";
                            controller.searchController.clear();
                            controller.selectedStatus.value = value;
                            await controller.fetchProducts();
                          }
                        }
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
          body: Column(
            children: [
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

                // ✅ Now show the grid view based on selectedStatus
                return Expanded(
                  child: Obx(() {
                    if (controller.selectedStatus.value == "product") {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
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
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: controller.filteredService.length,
                        itemBuilder: (context, index) {
                          final service = controller.filteredService[index];
                          return ServiceCard(
                            service: service,
                            onTap: () {
                              Get.toNamed(Routes.SERVICE_DETAILS, arguments: {
                                "service":service
                              });
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
        ),
      ),
    );
  }
}
