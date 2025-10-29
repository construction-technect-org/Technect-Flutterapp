import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/SearchProduct/controller/search_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  SearchProductView({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          appBar: CommonAppBar(title: const Text("Search Products")),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.grayEA.withValues(alpha: 0.32),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: CommonTextField(
                    onChange: (value) {
                      controller.onSearchChanged(value ?? "");
                    },
                    borderRadius: 12,
                    hintText: 'Search for products...',
                    prefixIcon: SvgPicture.asset(
                      Asset.searchIcon,
                      height: 16,
                      width: 16,
                    ),
                    controller: controller.searchController,
                    suffixIcon: Obx(
                      () => controller.searchQuery.value.isNotEmpty
                          ? GestureDetector(
                              onTap: controller.clearSearch,
                              child: const Icon(
                                Icons.clear,
                                color: MyColors.gray54,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (!controller.hasSearched.value) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: const BoxDecoration(
                                color: MyColors.grayEA,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search,
                                size: 48,
                                color: MyColors.gray54,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Search products',
                              style: MyTexts.medium18.copyWith(
                                color: MyColors.gray2E,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Type a product name to see matching items',
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.gray54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final products =
                      controller.productListModel.value?.data?.products ?? [];
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return ProductCard(
                        isFromAdd: false,
                        isFromConnector: myPref.role.val == "connector",
                        product: item,
                        onApiCall: () async {
                          await controller.performSearch(
                            controller.searchQuery.value,
                            isLoad: false,
                          );
                        },
                        onWishlistTap: () async {
                          await homeController.wishListApi(
                            status: item.isInWishList == true
                                ? "remove"
                                : "add",
                            mID: item.id ?? 0,
                            onSuccess: () async {
                              await controller.performSearch(
                                controller.searchQuery.value,
                                isLoad: false,
                              );
                            },
                          );
                        },
                        onNotifyTap: () async {
                          await homeController.notifyMeApi(
                            mID: item.id ?? 0,
                            onSuccess: () async {
                              await controller.performSearch(
                                controller.searchQuery.value,
                                isLoad: false,
                              );
                            },
                          );
                        },
                        onConnectTap: () {
                          ConnectionDialogs.showSendConnectionDialog(
                            context,
                            item,
                            isFromIn: true,

                            onTap: () async {
                              Get.back();
                              await homeController.addToConnectApi(
                                mID: item.merchantProfileId ?? 0,
                                message: '',
                                pID: item.id ?? 0,
                                onSuccess: () async {
                                  await controller.performSearch(
                                    controller.searchQuery.value,
                                    isLoad: false,
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
