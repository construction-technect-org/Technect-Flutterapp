import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/inventory_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/inventory_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/marketplace_category_models.dart';

class InventoryView extends GetView<InventoryController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: const CommonAppBar(title: Text('Inventory'), isCenter: false),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Filter Section ────────────────────────────────────
              _buildFilterSection(context),

              // ─── Inventory Type Tabs ──────────────────────────────
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: MyColors.grayF7,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Obx(() {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 🔸 Product toggle
                          GestureDetector(
                            onTap: () => controller.setInventoryType("product"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "product" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Product",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => controller.setInventoryType("service"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "service" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Service",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),

                          GestureDetector(
                            onTap: () => controller.setInventoryType("design"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "design" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Design",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => controller.setInventoryType("fleet"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "fleet" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Fleet",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => controller.setInventoryType("tools"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "tools" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Tools",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => controller.setInventoryType("equipment"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "equipment" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Equipment",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () => controller.setInventoryType("ppe"),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(
                                  controller.selectedStatus.value == "ppe" ? 255 : 0,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "PPE",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              //
              // // 🔹 Search field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonTextField(
                  controller: controller.searchController,
                  onChange: (value) {
                    controller.searchProducts(value);
                  },
                  borderRadius: 22,
                  hintText: 'Search',
                  prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                ),
              ),

              // ─── Unified Inventory List ──────────────────────────
              Obx(() {
                final isEmptyList = controller.filteredItems.isEmpty;

                if (isEmptyList && controller.searchQuery.value.isNotEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No items found matching "${controller.searchQuery.value}"',
                        style: MyTexts.medium14.copyWith(color: MyColors.dustyGray),
                      ),
                    ),
                  );
                } else if (isEmptyList) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No inventory items available',
                        style: MyTexts.medium14.copyWith(color: MyColors.dustyGray),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.filteredItems.length,
                    separatorBuilder: (_, __) => const Gap(12),
                    itemBuilder: (context, index) {
                      final item = controller.filteredItems[index];
                      // Since we are unified now, we will render a list tile style card
                      // replacing the complex dual-card system temporarily
                      return _buildInventoryCard(item);
                    },
                  ),
                );
              }),
            ],
          ),
          floatingActionButton: myPref.role.val == "connector"
              ? null
              : FloatingActionButton(
                  backgroundColor: MyColors.oldLacelight,
                  onPressed: () {
                    controller.selectedStatus.value == "product"
                        ? Get.toNamed(Routes.ADD_PRODUCT)
                        : Get.toNamed(Routes.ADD_GENERIC);
                  },
                  child: const Icon(Icons.add, color: Colors.black, size: 32),
                ),
        ),
      ),
    );
  }

  // ─── Filter Section Components ─────────────────────────────────

  Widget _buildFilterSection(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text("Filter Categories", style: MyTexts.bold14),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Obx(
            () => Column(
              children: [
                _buildDropdown<MarketplaceModule>(
                  label: "Module",
                  value: controller.modules.firstWhereOrNull(
                    (e) => e.id == controller.selectedModuleId.value,
                  ),
                  items: controller.modules,
                  onChanged: (v) => controller.onModuleSelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(8),
                _buildDropdown<MarketplaceMainCategory>(
                  label: "Main Category",
                  value: controller.mainCategories.firstWhereOrNull(
                    (e) => e.id == controller.selectedMainCategoryId.value,
                  ),
                  items: controller.mainCategories,
                  onChanged: (v) => controller.onMainCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(8),
                _buildDropdown<MarketplaceCategory>(
                  label: "Category",
                  value: controller.categories.firstWhereOrNull(
                    (e) => e.id == controller.selectedCategoryId.value,
                  ),
                  items: controller.categories,
                  onChanged: (v) => controller.onCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(8),
                _buildDropdown<MarketplaceSubCategory>(
                  label: "Sub Category",
                  value: controller.subCategories.firstWhereOrNull(
                    (e) => e.id == controller.selectedSubCategoryId.value,
                  ),
                  items: controller.subCategories,
                  onChanged: (v) => controller.onSubCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(8),
                _buildDropdown<MarketplaceCategoryProduct>(
                  label: "Category Product",
                  value: controller.categoryProducts.firstWhereOrNull(
                    (e) => e.id == controller.selectedCategoryProductId.value,
                  ),
                  items: controller.categoryProducts,
                  onChanged: (v) => controller.onCategoryProductSelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) itemLabel,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: items.isEmpty ? MyColors.grayF7 : null,
        border: Border.all(color: MyColors.grayEA),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 44,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(
            "All $label",
            style: MyTexts.medium13.copyWith(
              color: items.isEmpty ? MyColors.dustyGray : MyColors.primary.withValues(alpha: 0.5),
            ),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(itemLabel(e), style: MyTexts.medium14),
                ),
              )
              .toList(),
          onChanged: items.isEmpty ? null : onChanged,
        ),
      ),
    );
  }

  Widget _buildInventoryCard(InventoryItem item) {
    return GestureDetector(
      onTap: () {
        final type = controller.selectedStatus.value;
        if (type == 'product') {
          Get.toNamed(
            Routes.PRODUCT_DETAILS,
            arguments: {"product": item.toProduct(), "isEdit": true},
          );
        } else {
          Get.toNamed(
            Routes.SERVICE_DETAILS,
            arguments: {
              "service": item,
              "isEdit": true,
              "onApiCall": controller.fetchInventoryList,
            },
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.grayEA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 80,
                width: 80,
                color: MyColors.grayF7,
                child: item.images != null && item.images!.isNotEmpty
                    ? Image.network(
                        item.images!.first.s3Url ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image, color: MyColors.grey),
                      )
                    : const Icon(Icons.image, color: MyColors.grey),
              ),
            ),
            const Gap(12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? 'Unnamed',
                          style: MyTexts.bold14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (myPref.role.val == "connector")
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              final commonController = Get.find<CommonController>();
                              final itemId = item.id ?? "";
                              final isWishlisted = commonController.wishlistedProductIds.contains(
                                itemId,
                              );
                              commonController.wishListApi(
                                mID: itemId,
                                status: isWishlisted ? "remove" : "add",
                                moduleType: item.inventoryType ?? controller.selectedStatus.value,
                              );
                            },
                            child: Obx(() {
                              final itemId = item.id ?? "";
                              final isWishlisted = Get.find<CommonController>().wishlistedProductIds
                                  .contains(itemId);
                              return Icon(
                                isWishlisted ? Icons.favorite : Icons.favorite_border,
                                color: isWishlisted ? MyColors.custom('E53D26') : MyColors.grey,
                                size: 20,
                              );
                            }),
                          ),
                        ),
                      Text(
                        item.formattedPrice,
                        style: MyTexts.bold14.copyWith(color: MyColors.primary),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    "Type: ${item.inventoryType?.toUpperCase()}",
                    style: MyTexts.medium12.copyWith(color: MyColors.dustyGray),
                  ),
                  const Gap(4),
                  // Status Pills
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: item.isApproved
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.approvalStatus?.toUpperCase() ?? 'PENDING',
                          style: MyTexts.medium10.copyWith(
                            color: item.isApproved ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                      const Gap(8),
                      if (item.stock != null)
                        Text(
                          "${item.stock} in stock",
                          style: MyTexts.medium12.copyWith(color: MyColors.grey),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
