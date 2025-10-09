import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/all_product.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';

class ConnectorSelectedProductView extends StatelessWidget {
  ConnectorSelectedProductView({super.key});

  final controller = Get.put(ConnectorSelectedProductController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: const Text("Product"),
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          action: [
            IconButton(
              icon: SvgPicture.asset(Asset.filterIcon, width: 20, height: 20),
              onPressed: () => _openFilterSheet(context),
            ),
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.mainCategories.isNotEmpty) ...[
                  Text("Main Categories", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.mainCategories.length, (
                      index,
                    ) {
                      final item = controller.mainCategories[index];
                      final isSelected =
                          controller.selectedMainCategoryIndex.value == index;
                      return GestureDetector(
                        onTap: () async {
                          controller.selectedMainCategoryIndex.value = index;
                          controller.selectedMainCategoryId.value =
                              (item.id ?? 0).toString();

                          controller.selectedSubCategoryIndex.value = -1;
                          controller.selectedSubCategoryId.value = null;
                          controller.selectedProductIndex.value = -1;
                          controller.selectedProductId.value = null;

                          controller.productsList.clear();

                          await controller.fetchSubCategories(item.id ?? 0);
                        },

                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],

                if (controller.subCategories.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text("Sub Categories", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.subCategories.length, (
                      index,
                    ) {
                      final item = controller.subCategories[index];
                      final isSelected =
                          controller.selectedSubCategoryIndex.value == index;
                      return GestureDetector(
                        onTap: () async {
                          controller.selectedSubCategoryIndex.value = index;
                          controller.selectedSubCategoryId.value =
                              (item.id ?? 0).toString();

                          controller.selectedProductIndex.value = -1;
                          controller.selectedProductId.value = null;
                          controller.productsList.clear();

                          try {
                            await controller.fetchProducts(item.id ?? 0);
                          } catch (e) {
                            Get.snackbar("Error", "Failed to load products");
                          }
                        },
                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],
                if (controller.productsList.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text("Products", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.productsList.length, (
                      index,
                    ) {
                      final item = controller.productsList[index];
                      final isSelected =
                          controller.selectedProductIndex.value == index;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedProductIndex.value = index;
                          controller.selectedProductId.value = (item.id ?? 0)
                              .toString();
                        },

                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],
              ],
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          child: RoundedButton(
            buttonName: "Next",
            onTap: () async {
              final mainSelected =
                  controller.selectedMainCategoryIndex.value != -1;
              final subSelected =
                  controller.selectedSubCategoryIndex.value != -1;
              final productSelected =
                  controller.selectedProductIndex.value != -1;

              if (!mainSelected) {
                SnackBars.errorSnackBar(
                  content: "Please select a main category first.",
                );
                return;
              }

              if (!subSelected) {
                SnackBars.errorSnackBar(
                  content: "Please select a sub category.",
                );
                return;
              }

              if (!productSelected) {
                SnackBars.errorSnackBar(
                  content: "Please select a product before continuing.",
                );
                return;
              }
              await controller.getAllProducts();
              Get.put<ConnectorFilterController>(ConnectorFilterController());
              Get.to(() => const AllProduct());
              // Get.toNamed('/nextScreen');
            },
          ),
        ),
      ),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Delivery Radius", style: MyTexts.medium16),
                Slider(
                  min: 1,
                  max: 50,
                  divisions: 10,
                  value: controller.mapZoom.value,
                  label: "${controller.mapZoom.value.toInt()} KM",
                  onChanged: (val) => controller.mapZoom.value = val,
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Apply"),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
