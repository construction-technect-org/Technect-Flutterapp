import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/views/connector_selected_product_view.dart';
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
          Get.back();
          return true;
        },
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            appBar: CommonAppBar(
              isCenter: false,
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
                  Obx(() {
                    return controller.isFilterApply.value? Align(
                      alignment: Alignment.topRight,
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
                    ):const SizedBox();
                  }),
                const Gap(20),
              ],
            ),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              backgroundColor: MyColors.primary,
              color: Colors.white,
              onRefresh: () async {
                await controller.getAllProducts();
              },
              child: Obx(
                    () =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          CommonTextField(
                            onChange: (value) {
                              controller.searchProduct(value ?? "");
                            },
                            borderRadius: 22,
                            hintText: 'Search',
                            prefixIcon: SvgPicture.asset(
                              Asset.searchIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildFilterButton(
                                    icon: Asset.sort,
                                    label: "Sort",
                                    onTap: () {
                                      // TODO: Open Sort Bottom Sheet
                                      // controller.openSortBottomSheet();
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  _buildFilterButton(
                                    icon: Asset.sort,
                                    label: "Category",
                                    onTap: () {
                                      // TODO: Navigate to Category selection
                                      // controller.openCategorySheet();
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  _buildFilterButton(
                                    icon: Asset.sort,
                                    label: "Location",
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.white,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) =>
                                            SelectLocationBottomSheet(),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  _buildFilterButton(
                                    icon: Asset.filter,
                                    label: "Filter",
                                    onTap: () {
                                      // Navigate to existing filter screen
                                      Get.toNamed(Routes.CONNECTOR_FILTER);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (controller.filteredProducts.isEmpty)
                            Expanded(
                              child: Stack(
                                alignment: Alignment.topRight,
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
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional
                                              .centerStart,
                                          child: Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: controller.filteredProducts
                                                .map(
                                                  (product) {
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
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.grayD4 ?? Colors.grey.shade300),
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 6),
            Text(
              label,
              style: MyTexts.medium14.copyWith(
                color: MyColors.black,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
