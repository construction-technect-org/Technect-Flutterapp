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
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: CommonAppBar(
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
              () =>
              Padding(
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
                                style: MyTexts.regular14.copyWith(color: MyColors.grey),
                              ),
                            ],
                          ),
                        ),
                        Obx(()  {
                          return controller.isFilterApply.value? Align(
                              alignment: AlignmentGeometry.topRight,
                              child: RoundedButton(
                                  height: 40,
                                  width: 120,
                                  onTap: () async {
                                    await controller.getAllProducts();
                                  },
                                  fontSize: 20,
                                  verticalPadding: 0,
                                  style: MyTexts.medium14.copyWith(color: Colors
                                      .white, fontFamily: MyTexts.Roboto),
                                  buttonName: "Remove Filter")):const SizedBox();
                        }),
                      ],
                    )
                    : Column(
                  children: [
                    Obx(()  {
                      return controller.isFilterApply.value? Align(
                          alignment: AlignmentGeometry.topRight,
                          child: RoundedButton(
                              height: 40,
                              width: 120,
                              onTap: () async {
                                await controller.getAllProducts();
                              },
                              fontSize: 20,
                              verticalPadding: 0,
                              style: MyTexts.medium14.copyWith(color: Colors
                                  .white, fontFamily: MyTexts.Roboto),
                              buttonName: "Remove Filter")):const SizedBox();
                    }),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.filteredProducts.length,
                          separatorBuilder: (_, _) =>
                          const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final Product product =
                            controller.filteredProducts[index];
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
                              child: ProductCard(product: product),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
