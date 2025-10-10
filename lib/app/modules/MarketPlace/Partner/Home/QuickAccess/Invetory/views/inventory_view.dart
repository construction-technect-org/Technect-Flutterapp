import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/inventory_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/product_card.dart';

import 'package:gap/gap.dart';

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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Gap(16),
                CommonTextField(
                  onChange: (value) {
                    controller.searchProducts(value);
                  },
                  borderRadius: 22,
                  hintText: 'Search',
                  // suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                  prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                ),
                Obx(() {
                  if (controller.filteredProducts.isEmpty &&
                      controller.searchQuery.value.isNotEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(50),
                          const Icon(Icons.search_off, size: 64, color: MyColors.grey),
                          SizedBox(height: 2.h),
                          Text(
                            'No products found',
                            style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Try searching with different keywords',
                            style: MyTexts.regular14.copyWith(color: MyColors.grey),
                          ),
                        ],
                      ),
                    );
                  } 
                  else if (controller.filteredProducts.isEmpty) {
                    return Expanded(
                      child: Column(
                        children: [
                          const Gap(20),
                          const Icon(
                            Icons.inventory_2_outlined,
                            size: 64,
                            color: MyColors.grey,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'No products available',
                            style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Add your first product to get started',
                            style: MyTexts.regular14.copyWith(color: MyColors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child:
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: controller
                              .filteredProducts
                              .map((product) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes
                                      .PRODUCT_DETAILS,
                                  arguments: {
                                    "product":
                                    product,
                                    "isFromAdd":
                                    false,
                                    "isFromConnector":
                                    false,
                                  },
                                );
                              },
                              child: SizedBox(
                                width:
                                Get.width / 2 -
                                    24,
                                child: ProductCard(
                                  product: product,
                                ),
                              ),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductStatCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String value;
  final String subtitle;
  final String subValue;
  final Color subValueColor;

  const ProductStatCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subValue,
    this.subValueColor = MyColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayD4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(iconAsset),
            const Gap(10),
            Text(
              title,
              style: MyTexts.regular14.copyWith(color: MyColors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(value, style: MyTexts.bold16.copyWith(color: MyColors.fontBlack)),
            const Gap(10),
            Text(
              subtitle,
              style: MyTexts.regular14.copyWith(color: MyColors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(subValue, style: MyTexts.bold16.copyWith(color: subValueColor)),
          ],
        ),
      ),
    );
  }
}
