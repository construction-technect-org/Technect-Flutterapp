

import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/controllers/wish_list_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class WishListView extends GetView<WishListController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoaderWrapper,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Stack(
            children: [
              const CommonBgImage(),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('WishList'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CommonTextField(
                              onChange: (value) {
                                controller.searchProducts(value);
                              },
                              borderRadius: 22,
                              hintText: 'Search',
                              prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                            ),
                            Obx(() {
                              if (controller.filteredProducts.isEmpty &&
                                  controller.searchQuery.value.isNotEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 3,
                                  ),
                                  child: Center(
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
                                          style: MyTexts.regular14.copyWith(color: MyColors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (controller.filteredProducts.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 3,
                                  ),
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
                                          style: MyTexts.regular14.copyWith(color: MyColors.grey),
                                        ),
                                        const Gap(20),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: controller.filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final item = controller.filteredProducts[index];
                                  return ProductCard(
                                    isFromAdd: false,
                                    isFromConnector: true,
                                    product: item,
                                    onApiCall: () async {
                                      await controller.fetchWishList();
                                    },
                                    onWishlistTap: () async {
                                      controller.isLoaderWrapper.value = true;

                                      await Get.find<CommonController>().wishListApi(
                                        status: item.isInWishList == true ? "remove" : "add",
                                        mID: item.id ?? 0,
                                        onSuccess: () async {
                                          await controller.fetchWishList();
                                        },
                                      );
                                      controller.isLoaderWrapper.value = false;
                                    },
                                    onNotifyTap: () async {
                                      controller.isLoaderWrapper.value = true;

                                      await Get.find<CommonController>().notifyMeApi(
                                        mID: item.id ?? 0,
                                        onSuccess: () async {
                                          await controller.fetchWishList();
                                        },
                                      );
                                      controller.isLoaderWrapper.value = false;
                                    },
                                    onConnectTap: () {
                                      final bool isConnect =
                                          item.leadCreated == true && item.status != null;

                                      ConnectionDialogs.showSendConnectionDialog(
                                        context,
                                        item,
                                        isFromIn: true,
                                        isConnect: isConnect,
                                        onTap: (message, date, radius) async {
                                          Get.back();
                                          controller.isLoaderWrapper.value = true;
                                          await Get.find<CommonController>().addToConnectApi(
                                            uom: item.filterValues?["uom"]["value"] ?? "",
                                            quantity: item.stockQty.toString(),
                                            mID: item.merchantProfileId ?? 0,
                                            message: message,
                                            radius: radius,
                                            date: date,
                                            pID: item.id ?? 0,
                                            onSuccess: () async {
                                              await controller.fetchWishList();
                                            },
                                          );
                                          controller.isLoaderWrapper.value = false;
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
