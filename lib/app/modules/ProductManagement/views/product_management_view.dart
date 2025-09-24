import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/product_card.dart';
import 'package:construction_technect/app/modules/ProductManagement/controllers/product_management_controller.dart';
import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';

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
        appBar: CommonAppBar(
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text("PRODUCT MANAGEMENT"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  CommonTextField(
                    onChange: (value) {
                      controller.searchProduct(value ?? "");
                    },
                    borderRadius: 22,
                    hintText: 'Search',
                    suffixIcon: SvgPicture.asset(
                      Asset.filterIcon,
                      height: 20,
                      width: 20,
                    ),
                    prefixIcon: SvgPicture.asset(
                      Asset.searchIcon,
                      height: 16,
                      width: 16,
                    ),
                  ),
                  const SizedBox(height: 16),

                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.black),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(Asset.noOfConectors),
                                    const Gap(10),
                                    Text(
                                      "Total Products",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "123",
                                      style: MyTexts.bold16.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      "Active Products",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "122.4K",
                                      style: MyTexts.bold16.copyWith(
                                        color: MyColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.americanSilver),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(10),
                                    SvgPicture.asset(Asset.warning),
                                    const Gap(10),
                                    Text(
                                      "Low Stock",
                                      style: MyTexts.regular16.copyWith(
                                        color: MyColors.gray53,
                                        fontFamily: MyTexts.Roboto,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "04",
                                      style: MyTexts.bold20.copyWith(
                                        color: MyColors.redgray,
                                        fontFamily: MyTexts.Roboto,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.americanSilver),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: Column(
                                  children: [
                                    const Gap(10),
                                    Text(
                                      "Interest Products",
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.black,
                                        fontFamily: MyTexts.Roboto,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                    const Gap(15),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 55,
                                          height: 55,
                                          child: CircularProgressIndicator(
                                            value: 0.56,
                                            strokeWidth: 8,
                                            backgroundColor: MyColors.profileRemaining,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              MyColors.redgray,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '56%',
                                          style: MyTexts.medium16.copyWith(
                                            color: MyColors.black,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child:
                            (controller.filteredProducts.isEmpty &&
                                controller.searchQuery.value.isNotEmpty)
                            ? Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Column(
                                children: [
                                  const Gap(20),
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
                            )
                            : ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 20),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 120,right: 120, bottom: 20),
          child: RoundedButton(
            onTap: () {
              Get.toNamed(Routes.ADD_PRODUCT);
            },
            buttonName: '',
            borderRadius: 12,
            width: 50,
            height: 45,
            verticalPadding: 0,
            horizontalPadding: 0,
            child: Center(
              child: Text(
                '+ Add Product',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.white,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
