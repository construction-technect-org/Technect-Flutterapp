import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/product_card.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/ProductManagement/controllers/product_management_controller.dart';
import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';

class ProductManagementView extends StatelessWidget {
  final ProductManagementController controller = Get.put(ProductManagementController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          title: WelcomeName(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(22.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        controller.searchProduct(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 8),
                          child: SvgPicture.asset(
                            Asset.searchIcon,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        hintText: 'Search',
                        hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                        filled: true,
                        fillColor: MyColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.5),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            Asset.filterIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Product Management",
                    style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Total Products',
                                value:
                                    '${controller.productModel.value.data?.statistics?.totalProducts ?? 0}',
                                icon: SvgPicture.asset(Asset.TotalProducts),
                                iconBackground: MyColors.yellowundertones,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Featured',
                                value:
                                    '${controller.productModel.value.data?.statistics?.featured ?? 0}',
                                icon: SvgPicture.asset(Asset.Featured),
                                iconBackground: MyColors.verypaleBlue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Low Stock',
                                value:
                                    '${controller.productModel.value.data?.statistics?.lowStock ?? 0}',
                                icon: SvgPicture.asset(Asset.LowStock),
                                iconBackground: MyColors.paleRed,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Total Interests',
                                value:
                                    '${controller.productModel.value.data?.statistics?.totalInterests ?? 0}',
                                icon: SvgPicture.asset(Asset.TotalInterests),
                                iconBackground: MyColors.warmOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                        controller.filteredProducts.isEmpty &&
                            controller.searchQuery.value.isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: MyColors.grey,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'No products found',
                                    style: MyTexts.medium18.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    'Try searching with different keywords',
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredProducts.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final Product product = controller.filteredProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.PRODUCT_DETAILS,
                                    arguments: {"product": product},
                                  );
                                },
                                child: ProductCard(
                                  statusText: (product.isActive ?? false)
                                      ? 'Active'
                                      : 'InActive',
                                  statusColor: (product.isActive ?? false)
                                      ? MyColors.green
                                      : MyColors.red,
                                  productName: product.productName ?? '',
                                  brandName: product.brand ?? '',
                                  locationText: 'Vasai Virar, Mahab Chowpatty',
                                  pricePerUnit: double.parse(product.price ?? '0'),
                                  stockCount: product.stockQuantity ?? 0,
                                  imageUrl: product.productImage,
                                ),
                              );
                            },
                          ),
                  ),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: RoundedButton(
                    onTap: () {
                      Get.toNamed(Routes.ADD_PRODUCT);
                    },
                    buttonName: '',
                    borderRadius: 12,
                    width: 50.w,
                    height: 45,
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    child: Center(
                      child: Text(
                        '+ Add New Product',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.white,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
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
