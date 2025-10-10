import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:gap/gap.dart';

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
            Obx(() {
              return controller.selectedMainCategoryIndex.value != (-1)
                  ? Align(
                      alignment: AlignmentGeometry.topRight,
                      child: RoundedButton(
                        height: 40,
                        width: 120,
                        onTap: () {
                          controller.resetSelections();
                          // await controller.getAllProducts();
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
            const Gap(20),
            // IconButton(
            //   icon: SvgPicture.asset(Asset.filterIcon, width: 20, height: 20),
            //   onPressed: () => _openFilterSheet(context),
            // ),
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
            // onTap: () async {
            //   final mainSelected =
            //       controller.selectedMainCategoryIndex.value != -1;
            //   final subSelected =
            //       controller.selectedSubCategoryIndex.value != -1;
            //   final productSelected =
            //       controller.selectedProductIndex.value != -1;
            //
            //   if (!mainSelected) {
            //     SnackBars.errorSnackBar(
            //       content: "Please select a main category first.",
            //     );
            //     return;
            //   }
            //
            //   if (!subSelected) {
            //     SnackBars.errorSnackBar(
            //       content: "Please select a sub category.",
            //     );
            //     return;
            //   }
            //
            //   if (!productSelected) {
            //     SnackBars.errorSnackBar(
            //       content: "Please select a product before continuing.",
            //     );
            //     return;
            //   }
            //   await controller.getAllProducts();
            //   Get.put<ConnectorFilterController>(ConnectorFilterController());
            //   Get.to(() => const AllProduct());
            //   // Get.toNamed('/nextScreen');
            // },
            onTap: (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => const SelectLocationBottomSheet(),
              );

            },
          ),
        ),
      ),
    );
  }
}


class SelectLocationBottomSheet extends StatefulWidget {
  const SelectLocationBottomSheet({super.key});

  @override
  State<SelectLocationBottomSheet> createState() => _SelectLocationBottomSheetState();
}

class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {
  double selectedRadius = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(12),
             Text(
              "Select a Location",
              style: MyTexts.medium16.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("Within Radius",
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.primary,
                      fontFamily: MyTexts.Roboto,
                    ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${selectedRadius.toInt()} KM",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedRadius += 1;
                              });
                            },
                            child: const Icon(Icons.arrow_drop_up, size: 18),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedRadius > 1) selectedRadius -= 1;
                              });
                            },
                            child: const Icon(Icons.arrow_drop_down, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Gap(16),
            const Divider(),
            const Gap(16),

            // --- Add location manually ---
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.add, color: Colors.blue),
                    title: const Text("Add Location Manually"),
                    onTap: () {
                      // TODO: Navigate to manual address picker
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.my_location_outlined, color: Colors.blue),
                    title: const Text("Use your Current Location"),
                    onTap: () async {
                      Get.back();
                      // Example: await controller.getCurrentLocation();
                    },
                  ),
                ],
              ),
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }
}

