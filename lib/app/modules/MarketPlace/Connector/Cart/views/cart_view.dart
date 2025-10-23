import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/controllers/cart_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';

class CartListView extends GetView<CartListController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoaderWrapper,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(title: const Text('Cart'), isCenter: false),
          body: Obx(() {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator(color: MyColors.primary,))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CommonTextField(
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
                        Obx(() {
                          if (controller.filteredProducts.isEmpty &&
                              controller.searchQuery.value.isNotEmpty) {
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No products found',
                                    style: MyTexts.medium16.copyWith(
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
                            );
                          } else if (controller.filteredProducts.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No products available',
                                      style: MyTexts.medium16.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      'Add your first product to get started',
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.grey,
                                      ),
                                    ),
                                    const Gap(20),
                                  ],
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
                                    childAspectRatio: 0.6,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemCount:
                                  controller
                                      .cartModel
                                      .value
                                      .data
                                      ?.products
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final item =
                                    controller
                                        .cartModel
                                        .value
                                        .data
                                        ?.products?[index] ??
                                    Product();
                                return ProductCard(
                                  isFromAdd: false,
                                  isFromConnector: true,
                                  product: item,
                                  onApiCall: () async {
                                    await controller.fetchCartList();
                                  },
                                  onWishlistTap: () async {
                                    controller.isLoaderWrapper.value = true;

                                    await Get.find<HomeController>()
                                        .wishListApi(
                                          status: item.isInWishList == true
                                              ? "remove"
                                              : "add",
                                          mID: item.id ?? 0,
                                          onSuccess: () async {
                                            await controller.fetchCartList();
                                          },
                                        );
                                    controller.isLoaderWrapper.value = false;
                                  },
                                  onNotifyTap: () async {
                                    controller.isLoaderWrapper.value = true;

                                    await Get.find<HomeController>()
                                        .notifyMeApi(
                                          mID: item.id ?? 0,
                                          onSuccess: () async {
                                            await controller.fetchCartList();
                                          },
                                        );
                                    controller.isLoaderWrapper.value = false;
                                  },
                                  onConnectTap: () {
                                    ConnectionDialogs.showSendConnectionDialog(
                                      context,
                                      item,
                                      isFromIn: true,

                                      onTap: () async {
                                        Get.back();
                                        controller.isLoaderWrapper.value = true;
                                        await Get.find<HomeController>()
                                            .addToConnectApi(
                                              mID: item.merchantProfileId ?? 0,
                                              message: '',
                                              pID: item.id ?? 0,
                                              onSuccess: () async {
                                                await controller
                                                    .fetchCartList();
                                              },
                                            );
                                        controller.isLoaderWrapper.value =
                                            false;
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
