import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_product_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/controllers/cart_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
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
          body: Stack(
            children: [
              const CommonBgImage(),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Connect'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    action: [
                      Obx(() {
                        final colorMap = {
                          "All": MyColors.fontBlack,
                          "pending": Colors.orange,
                          "accepted": Colors.green,
                          "rejected": Colors.red,
                          "cancelled": Colors.red,
                        };

                        final selectedColor =
                            colorMap[controller.selectedStatus.value] ??
                            MyColors.fontBlack;

                        return Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: MyColors.grayF7,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedStatus.value,
                              dropdownColor: Colors.white,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 22,
                                color: Colors.black,
                              ),
                              style: MyTexts.medium16.copyWith(
                                color: selectedColor,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "All",
                                  child: Text(
                                    "All",
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "pending",
                                  child: Text(
                                    "Pending",
                                    style: MyTexts.medium16.copyWith(
                                      color: Colors.orange,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "accepted",
                                  child: Text(
                                    "Accepted",
                                    style: MyTexts.medium16.copyWith(
                                      color: Colors.green,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "rejected",
                                  child: Text(
                                    "Rejected",
                                    style: MyTexts.medium16.copyWith(
                                      color: Colors.red,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "cancelled",
                                  child: Text(
                                    "Cancelled",
                                    style: MyTexts.medium16.copyWith(
                                      color: Colors.red,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) async {
                                if (value != null) {
                                  controller.selectedStatus.value = value;
                                  await controller.fetchCartList(isLoad: true);
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.primary,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 6),
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: MyColors.grayF7,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        child: Obx(() {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // 🔸 Product toggle
                                              GestureDetector(
                                                onTap: () async {
                                                  if (controller
                                                          .selectedMainStatus
                                                          .value !=
                                                      "product") {
                                                    controller
                                                            .selectedMainStatus
                                                            .value =
                                                        "product";
                                                    controller.searchController
                                                        .clear();
                                                    controller
                                                            .searchQuery
                                                            .value =
                                                        "";
                                                    await controller
                                                        .fetchCartList();
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        controller
                                                                .selectedMainStatus
                                                                .value ==
                                                            "product"
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                          horizontal: 20,
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        "Product",
                                                        style: MyTexts.medium15
                                                            .copyWith(
                                                              color: MyColors
                                                                  .gray2E,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Gap(10),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (controller
                                                          .selectedMainStatus
                                                          .value !=
                                                      "service") {
                                                    controller
                                                            .selectedMainStatus
                                                            .value =
                                                        "service";
                                                    controller.searchController
                                                        .clear();
                                                    controller
                                                            .searchQuery
                                                            .value =
                                                        "";
                                                    // await controller.fetchProducts();
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        controller
                                                                .selectedMainStatus
                                                                .value ==
                                                            "service"
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                          horizontal: 20,
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        "Service",
                                                        style: MyTexts.medium15
                                                            .copyWith(
                                                              color: MyColors
                                                                  .gray2E,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
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
                                    const Gap(10),
                                    Obx(() {
                                      if (controller.filteredProducts.isEmpty &&
                                          controller
                                              .searchQuery
                                              .value
                                              .isNotEmpty) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height /
                                                3,
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'No products found',
                                                  style: MyTexts.medium16
                                                      .copyWith(
                                                        color:
                                                            MyColors.fontBlack,
                                                      ),
                                                ),
                                                SizedBox(height: 0.5.h),
                                                Text(
                                                  'Try searching with different keywords',
                                                  style: MyTexts.regular14
                                                      .copyWith(
                                                        color: MyColors.grey,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (controller
                                          .filteredProducts
                                          .isEmpty) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height /
                                                3,
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'No products available',
                                                  style: MyTexts.medium16
                                                      .copyWith(
                                                        color:
                                                            MyColors.fontBlack,
                                                      ),
                                                ),
                                                SizedBox(height: 0.5.h),
                                                Text(
                                                  'Add your first product to get started',
                                                  style: MyTexts.regular14
                                                      .copyWith(
                                                        color: MyColors.grey,
                                                      ),
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
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.6,
                                              crossAxisSpacing: 12,
                                              mainAxisSpacing: 12,
                                            ),
                                        itemCount:
                                            controller.filteredProducts.length,
                                        itemBuilder: (context, index) {
                                          final item = controller
                                              .filteredProducts[index];
                                          return ProductCard(
                                            isFromAdd: false,
                                            isFromConnector: true,
                                            product: item,
                                            onApiCall: () async {
                                              await controller.fetchCartList();
                                            },
                                            onWishlistTap: () async {
                                              controller.isLoaderWrapper.value =
                                                  true;
                                              await Get.find<HomeController>()
                                                  .wishListApi(
                                                    status:
                                                        item.isInWishList ==
                                                            true
                                                        ? "remove"
                                                        : "add",
                                                    mID: item.id ?? 0,
                                                    onSuccess: () async {
                                                      await controller
                                                          .fetchCartList();
                                                    },
                                                  );
                                              controller.isLoaderWrapper.value =
                                                  false;
                                            },
                                            onNotifyTap: () async {
                                              controller.isLoaderWrapper.value =
                                                  true;
                                              await Get.find<HomeController>()
                                                  .notifyMeApi(
                                                    mID: item.id ?? 0,
                                                    onSuccess: () async {
                                                      await controller
                                                          .fetchCartList();
                                                    },
                                                  );
                                              controller.isLoaderWrapper.value =
                                                  false;
                                            },
                                            onConnectTap: () {
                                              ConnectionDialogs.showSendConnectionDialog(
                                                context,
                                                item,
                                                isFromIn: true,
                                                onTap: () async {
                                                  Get.back();
                                                  controller
                                                          .isLoaderWrapper
                                                          .value =
                                                      true;
                                                  await Get.find<
                                                        HomeController
                                                      >()
                                                      .addToConnectApi(
                                                        mID:
                                                            item.merchantProfileId ??
                                                            0,
                                                        message: '',
                                                        pID: item.id ?? 0,
                                                        onSuccess: () async {
                                                          await controller
                                                              .fetchCartList();
                                                        },
                                                      );
                                                  controller
                                                          .isLoaderWrapper
                                                          .value =
                                                      false;
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              );
                      }),
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
