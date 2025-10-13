import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/all_product.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/models/site_location_model.dart';
import 'package:gap/gap.dart';

class ConnectorSelectedProductView extends StatelessWidget {
  ConnectorSelectedProductView({super.key});

  final controller = Get.put(ConnectorSelectedProductController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: const Text("Product"),
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          action: [
            Obx(() {
              return controller.selectedMainCategoryIndex.value != (-1)
                  ? Align(
                      alignment: AlignmentGeometry.topRight,
                      child: RoundedButton(
                        height: 40,
                        width: 120,
                        onTap: () {
                          controller.resetSelections();
                          // await controller.getAllProducts();
                        },
                        fontSize: 20,
                        verticalPadding: 0,
                        style: MyTexts.medium14.copyWith(
                          color: Colors.white,
                          fontFamily: MyTexts.Roboto,
                        ),
                        buttonName: "Remove Filter",
                      ),
                    )
                  : const SizedBox();
            }),
            const Gap(20),
            // IconButton(
            //   icon: SvgPicture.asset(Asset.filterIcon, width: 20, height: 20),
            //   onPressed: () => _openFilterSheet(context),
            // ),
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.mainCategories.isNotEmpty) ...[
                  Text("Main Categories", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.mainCategories.length, (
                      index,
                    ) {
                      final item = controller.mainCategories[index];
                      final isSelected =
                          controller.selectedMainCategoryIndex.value == index;
                      return GestureDetector(
                        onTap: () async {
                          controller.selectedMainCategoryIndex.value = index;
                          controller.selectedMainCategoryId.value =
                              (item.id ?? 0).toString();

                          controller.selectedSubCategoryIndex.value = -1;
                          controller.selectedSubCategoryId.value = null;
                          controller.selectedProductIndex.value = -1;
                          controller.selectedProductId.value = null;

                          controller.productsList.clear();

                          await controller.fetchSubCategories(item.id ?? 0);
                        },

                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],

                if (controller.subCategories.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text("Sub Categories", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.subCategories.length, (
                      index,
                    ) {
                      final item = controller.subCategories[index];
                      final isSelected =
                          controller.selectedSubCategoryIndex.value == index;
                      return GestureDetector(
                        onTap: () async {
                          controller.selectedSubCategoryIndex.value = index;
                          controller.selectedSubCategoryId.value =
                              (item.id ?? 0).toString();

                          controller.selectedProductIndex.value = -1;
                          controller.selectedProductId.value = null;
                          controller.productsList.clear();

                          try {
                            await controller.fetchProducts(item.id ?? 0);
                          } catch (e) {
                            Get.snackbar("Error", "Failed to load products");
                          }
                        },
                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],
                if (controller.productsList.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text("Products", style: MyTexts.medium16),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(controller.productsList.length, (
                      index,
                    ) {
                      final item = controller.productsList[index];
                      final isSelected =
                          controller.selectedProductIndex.value == index;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedProductIndex.value = index;
                          controller.selectedProductId.value = (item.id ?? 0)
                              .toString();
                        },

                        child: ConnectorCategoryCard(
                          category: CategoryItem(
                            item.name ?? "",
                            Asset.Product,
                          ),
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],
              ],
            ),
          );
        }),
        bottomNavigationBar: Obx(
          () => (controller.selectedProductId.value ?? '').isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24,
                  ),
                  child: RoundedButton(
                    buttonName: "Next",
                    onTap: () async {
                      final mainSelected =
                          controller.selectedMainCategoryIndex.value != -1;
                      final subSelected =
                          controller.selectedSubCategoryIndex.value != -1;
                      final productSelected =
                          controller.selectedProductIndex.value != -1;

                      if (!mainSelected) {
                        SnackBars.errorSnackBar(
                          content: "Please select a main category first.",
                        );
                        return;
                      }

                      if (!subSelected) {
                        SnackBars.errorSnackBar(
                          content: "Please select a sub category.",
                        );
                        return;
                      }

                      if (!productSelected) {
                        SnackBars.errorSnackBar(
                          content: "Please select a product before continuing.",
                        );
                        return;
                      }

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => SelectLocationBottomSheet(),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class SelectLocationBottomSheet extends StatelessWidget {
  final ConnectorSelectedProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: hideKeyboard,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(12),
              Text(
                "Select a Location",
                style: MyTexts.medium16.copyWith(
                  color: MyColors.primary,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              const Gap(16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CommonTextField(
                      controller: controller.radiusController.value,
                      keyboardType: TextInputType.number,
                      suffixIcon: SizedBox(
                        width: 35,
                        height: 48,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.selectedRadius.value += 1;
                                controller.radiusController.value.text =
                                    controller.selectedRadius.value.toString();
                              },
                              child: const Icon(Icons.arrow_drop_up, size: 20),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.selectedRadius.value > 1) {
                                  controller.selectedRadius.value -= 1;
                                  controller.radiusController.value.text =
                                      controller.selectedRadius.value
                                          .toString();
                                }
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onChange: (val) {
                        final int? value = int.tryParse(val ?? "");
                        if (value != null && value >= 0) {
                          controller.selectedRadius.value = value;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(" KM"),
                  const Gap(20),
                ],
              ),
              const Gap(16),
              const Divider(),
              const Gap(16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add, color: Colors.blue),
                      title: const Text("Add Location Manually"),
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.CONNECTOR_SITE_LOCATION)?.then((
                          value,
                        ) {
                          controller.getSiteAddresses();
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Site address list
              const Gap(24),
              if (controller.siteAddressList.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Site Address List",
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
                const Gap(12),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.siteAddressList.length,
                    itemBuilder: (context, index) {
                      final address = controller.siteAddressList[index];
                      return GestureDetector(
                        onTap: () {
                          controller.selectedAddress.value = address;
                        },
                        child: Obx(
                          () => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    controller.selectedAddress.value.id ==
                                        address.id
                                    ? MyColors.primary
                                    : MyColors.primary.withValues(alpha: 0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Location Icon
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: MyColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: MyColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const Gap(12),
                                // Address Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.siteName?.capitalizeFirst ?? '',
                                        style: MyTexts.medium16.copyWith(
                                          color: MyColors.fontBlack,
                                          fontFamily: MyTexts.Roboto,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        address.fullAddress ?? '',
                                        style: MyTexts.regular14.copyWith(
                                          color: MyColors.gray5D,
                                          fontFamily: MyTexts.Roboto,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (address.landmark != null &&
                                          address.landmark!.isNotEmpty) ...[
                                        const Gap(2),
                                        Text(
                                          'Landmark: ${address.landmark}',
                                          style: MyTexts.regular14.copyWith(
                                            color: MyColors.gray5D,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                      ],
                                      if (address.isDefault == true) ...[
                                        const Gap(4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: MyColors.primary.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            'Default',
                                            style: MyTexts.regular12.copyWith(
                                              color: MyColors.primary,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                // Action Buttons
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => _navigateToEditSite(address),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    // Delete Button
                                    InkWell(
                                      onTap: () => _showDeleteDialog(address),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 16,
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
                    },
                  ),
                ),
                const Gap(24),
                RoundedButton(
                  buttonName: 'Continue',
                  onTap: () async {
                    if ((controller.selectedAddress.value.id ?? 0) != 0) {
                      await controller.getAllProducts();
                      Get.put<ConnectorFilterController>(
                        ConnectorFilterController(),
                      );
                      Get.back();
                      Get.to(() => const AllProduct());
                      return;
                    } else {
                      SnackBars.errorSnackBar(content: "Please select site");
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEditSite(Datum address) {
    Get.toNamed(
      Routes.CONNECTOR_SITE_LOCATION,
      arguments: {
        'isEdit': true,
        'siteId': address.id,
        'siteName': address.siteName ?? '',
        'landmark': address.landmark ?? '',
        'fullAddress': address.fullAddress ?? '',
        'latitude': address.latitude ?? '',
        'longitude': address.longitude ?? '',
        'isDefault': address.isDefault ?? false,
      },
    );
  }

  void _showDeleteDialog(Datum address) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Delete Site Address',
          style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
        ),
        content: Text(
          'Are you sure you want to delete "${address.siteName}"?',
          style: MyTexts.regular14.copyWith(color: MyColors.darkGray),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.deleteSiteAddress(address.id!);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: MyTexts.regular14),
          ),
        ],
      ),
    );
  }
}
