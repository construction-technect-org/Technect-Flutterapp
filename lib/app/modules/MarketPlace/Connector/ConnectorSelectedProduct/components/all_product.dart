import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';

class AllProduct extends GetView<ConnectorSelectedProductController> {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: const Text("Products"),

      ),
      backgroundColor: Colors.white,
      body:    Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: controller.filteredProducts.isEmpty
              ? Center( // 👈 Center vertically and horizontally
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 Keeps content centered
              children: [
                const Gap(20),
                Icon(
                  controller.searchQuery.value.isNotEmpty
                      ? Icons.search_off
                      : Icons.inventory_2_outlined,
                  size: 64,
                  color: MyColors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  controller.searchQuery.value.isNotEmpty
                      ? 'No products found'
                      : 'No products available',
                  style: MyTexts.medium18.copyWith(
                    color: MyColors.fontBlack,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  controller.searchQuery.value.isNotEmpty
                      ? 'Try searching with different keywords'
                      : 'Add your first product to get started',
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.grey,
                  ),
                ),
              ],
            ),
          )
              : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                      vertical: 20,
                                  ),
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                        .filteredProducts
                        .length,
                                  separatorBuilder: (_, _) =>
                                  const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                      final Product product = controller
                          .filteredProducts[index];
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
                        child: ProductCard(
                          product: product,
                        ),
                      );
                                  },
                                ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
