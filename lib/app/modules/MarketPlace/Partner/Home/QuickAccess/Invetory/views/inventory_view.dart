import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/inventory_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class InventoryView extends GetView<InventoryController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(title: const Text('Inventory'), isCenter: false),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonTextField(
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
                if (controller.filteredProducts.isEmpty &&
                    controller.searchQuery.value.isNotEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No inventory found',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.dustyGray,
                        ),
                      ),
                    ),
                  );
                } else if (controller.filteredProducts.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No inventory available',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.dustyGray,
                        ),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount:
                        controller
                            .productListModel
                            .value
                            .data
                            ?.products
                            ?.length ??
                        0,
                    itemBuilder: (context, index) {
                      final item =
                          controller
                              .productListModel
                              .value
                              .data
                              ?.products?[index] ??
                          Product();
                      return ProductCard(
                        isFromAdd: false,
                        isFromConnector: false,
                        product: item,
                        onWishlistTap: () {},
                        onNotifyTap: () {},

                        onConnectTap: () {},
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
