import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/product_card.dart';
import 'package:gap/gap.dart';

class AllProduct extends GetView<ConnectorSelectedProductController> {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: WillPopScope(
        onWillPop: () async {
          Get.delete<ConnectorFilterController>();
          Get.back(); // if needed
          return true; // Allow the pop
        },
        child: Scaffold(
          appBar: CommonAppBar(
            leading: GestureDetector(
              onTap: () {
                Get.delete<ConnectorFilterController>();
                Get.back();
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(Icons.arrow_back_ios, color: MyColors.black),
              ),
            ),
            title: const Text("Products"),
            action: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CONNECTOR_FILTER);
                },
                icon: const Icon(Icons.filter_list_alt),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: controller.filteredProducts.isEmpty
                  ? Stack(
                      alignment: AlignmentGeometry.topRight,
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(20),
                              Icon(
                                controller.searchQuery.value.isNotEmpty
                                    ? Icons.search_off
                                    : Icons.inventory_2_outlined,
                                size: 64,
                                color: MyColors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller.searchQuery.value.isNotEmpty
                                    ? 'No products found'
                                    : 'No products available',
                                style: MyTexts.medium18.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                controller.searchQuery.value.isNotEmpty
                                    ? 'Try searching with different keywords'
                                    : 'Try searching with different category',
                                style: MyTexts.regular14.copyWith(
                                  color: MyColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return controller.isFilterApply.value
                              ? Align(
                                  alignment: AlignmentGeometry.topRight,
                                  child: RoundedButton(
                                    height: 40,
                                    width: 120,
                                    onTap: () async {
                                      await controller.getAllProducts();
                                      Get.delete<ConnectorFilterController>();
                                      Get.put<ConnectorFilterController>(
                                        ConnectorFilterController(),
                                      );
                                    },
                                    fontSize: 20,
                                    verticalPadding: 0,
                                    style: MyTexts.medium14.copyWith(
                                      color: Colors.white,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                    buttonName: "Remove Filter",
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    )
                  : Column(
                      children: [
                        Obx(() {
                          return controller.isFilterApply.value
                              ? Align(
                                  alignment: AlignmentGeometry.topRight,
                                  child: RoundedButton(
                                    height: 40,
                                    width: 120,
                                    onTap: () async {
                                      await controller.getAllProducts();
                                      Get.delete<ConnectorFilterController>();
                                      Get.put<ConnectorFilterController>(
                                        ConnectorFilterController(),
                                      );
                                    },
                                    fontSize: 20,
                                    verticalPadding: 0,
                                    style: MyTexts.medium14.copyWith(
                                      color: Colors.white,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                    buttonName: "Remove Filter",
                                  ),
                                )
                              : const SizedBox();
                        }),
                        const Gap(10),

                        const Gap(10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: controller.filteredProducts.map((
                                  product,
                                ) {
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
                                    child: SizedBox(
                                      width: Get.width / 2 - 24,
                                      child: ProductCard(
                                        product: product,
                                        isPartner: false,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
