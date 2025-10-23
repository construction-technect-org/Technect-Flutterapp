import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/controller/new_launch_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class NewLaunchesProduct extends StatelessWidget {
  NewLaunchesProduct({super.key});

  final controller = Get.put<NewLaunchController>(NewLaunchController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoadingWrapper,
      child: Scaffold(
        appBar: CommonAppBar(title: const Text("")),
        backgroundColor: Colors.white,
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (controller.productListModel.value?.data?.products.isEmpty ??
                    true)
              ? const Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount:
                      controller
                          .productListModel
                          .value
                          ?.data
                          ?.products
                          .length ??
                      0,
                  itemBuilder: (context, index) {
                    final item =
                        controller
                            .productListModel
                            .value
                            ?.data
                            ?.products[index] ??
                        Product();
                    return ProductCard(
                      isFromAdd: false,
                      isFromConnector: true,
                      product: item,
                      onApiCall: () async {
                        await controller.fetchProductsFromApi();
                      },
                      onWishlistTap: () async {
                        controller.isLoadingWrapper.value = true;
                        await Get.find<HomeController>().wishListApi(
                          status: item.isInWishList == true ? "remove" : "add",
                          mID: item.id ?? 0,
                          onSuccess: () async {
                            await controller.fetchProductsFromApi();
                          },
                        );
                        controller.isLoadingWrapper.value = false;
                      },
                      onNotifyTap: () async {
                        controller.isLoadingWrapper.value = true;
                        await Get.find<HomeController>().notifyMeApi(
                          mID: item.id ?? 0,
                          onSuccess: () async {
                            await controller.fetchProductsFromApi();
                          },
                        );
                        controller.isLoadingWrapper.value = false;
                      },
                      onConnectTap: () {
                        ConnectionDialogs.showSendConnectionDialog(
                          context,
                          item,
                          isFromIn: true,

                          onTap: () async {
                            Get.back();
                            controller.isLoadingWrapper.value = true;
                            await Get.find<HomeController>().addToConnectApi(
                              mID: item.merchantProfileId ?? 0,
                              message: '',
                              pID: item.id ?? 0,
                              onSuccess: () async {
                                await controller.fetchProductsFromApi();
                              },
                            );
                            controller.isLoadingWrapper.value = false;
                          },
                        );
                      },
                    );
                  },
                );
        }),
      ),
    );
  }
}
