import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/add_inventory_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/marketplace_category_models.dart';

class AddInventoryProductView extends GetView<AddInventoryController> {
  const AddInventoryProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Material Product", style: MyTexts.medium18),
          centerTitle: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Category Hierarchy ───────────────────────────
                _sectionTitle("Category"),
                const Gap(12),
                // Inventory Type (required enum by API)
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Inventory Type",
                        style: MyTexts.medium14.copyWith(color: MyColors.grey),
                      ),
                      const Gap(6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grayEA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedInventoryType.value,
                            items: AddInventoryController.inventoryTypeOptions
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(t, style: MyTexts.medium14),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null) controller.selectedInventoryType.value = v;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                _buildDropdown<MarketplaceModule>(
                  label: "Module",
                  value: controller.modules.firstWhereOrNull(
                    (e) => e.id == controller.selectedModuleId.value,
                  ),
                  items: controller.modules,
                  onChanged: (v) => controller.onModuleSelected(v?.id, v?.name),
                  itemLabel: (e) => e.name,
                ),
                const Gap(12),
                _buildDropdown<MarketplaceMainCategory>(
                  label: "Main Category",
                  value: controller.mainCategories.firstWhereOrNull(
                    (e) => e.id == controller.selectedMainCategoryId.value,
                  ),
                  items: controller.mainCategories,
                  onChanged: (v) => controller.onMainCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(12),
                _buildDropdown<MarketplaceCategory>(
                  label: "Category",
                  value: controller.categories.firstWhereOrNull(
                    (e) => e.id == controller.selectedCategoryId.value,
                  ),
                  items: controller.categories,
                  onChanged: (v) => controller.onCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(12),
                _buildDropdown<MarketplaceSubCategory>(
                  label: "Sub Category",
                  value: controller.subCategories.firstWhereOrNull(
                    (e) => e.id == controller.selectedSubCategoryId.value,
                  ),
                  items: controller.subCategories,
                  onChanged: (v) => controller.onSubCategorySelected(v?.id),
                  itemLabel: (e) => e.name,
                ),
                const Gap(12),
                _buildDropdown<MarketplaceCategoryProduct>(
                  label: "Product Name",
                  value: controller.categoryProducts.firstWhereOrNull(
                    (e) => e.id == controller.selectedCategoryProductId.value,
                  ),
                  items: controller.categoryProducts,
                  onChanged: (v) => controller.selectedCategoryProductId.value = v?.id,
                  itemLabel: (e) => e.name,
                ),

                const Gap(24),
                // ─── Basic Details ─────────────────────────────────
                _sectionTitle("Basic Details"),
                const Gap(12),
                CommonTextField(controller: controller.nameController, hintText: "Display Name *"),
                const Gap(12),
                CommonTextField(controller: controller.brandController, hintText: "Brand"),
                const Gap(12),
                CommonTextField(
                  controller: controller.descriptionController,
                  hintText: "Description",
                  maxLine: 3,
                ),

                const Gap(24),
                // ─── Pricing ───────────────────────────────────────
                _sectionTitle("Pricing"),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.priceController,
                        hintText: "Price *",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.gstPercentageController,
                        hintText: "GST % *",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.gstAmountController,
                        hintText: "GST Amount *",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.finalPriceController,
                        hintText: "Final Price *",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const Gap(24),
                // ─── Stock & Availability ──────────────────────────
                _sectionTitle("Stock & Availability"),
                const Gap(12),
                CommonTextField(
                  controller: controller.stockController,
                  hintText: "Stock Quantity *",
                  keyboardType: TextInputType.number,
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Is Available", style: MyTexts.medium14),
                    Obx(
                      () => Switch(
                        value: controller.isAvailable.value,
                        activeThumbColor: MyColors.primary,
                        onChanged: (v) => controller.isAvailable.value = v,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                CommonTextField(
                  controller: controller.warehouseDetailsController,
                  hintText: "Warehouse Details *",
                  maxLine: 2,
                ),

                const Gap(24),
                // ─── Specifications ────────────────────────────────
                _sectionTitle("Specifications"),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.uomController,
                        hintText: "UOM (e.g. kg, m) *",
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.uocController,
                        hintText: "UOC (e.g. bag, ton) *",
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.packageTypeController,
                        hintText: "Package Type *",
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.shapeController,
                        hintText: "Shape *",
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.textureController,
                        hintText: "Texture *",
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.colourController,
                        hintText: "Colour *",
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                CommonTextField(controller: controller.sizeController, hintText: "Size *"),

                const Gap(24),
                // ─── Additional Properties (Optional) ─────────────
                _sectionTitle("Additional Properties (Optional)"),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.specificGravityController,
                        hintText: "Specific Gravity",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.bulkDensityController,
                        hintText: "Bulk Density",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.waterAbsorptionController,
                        hintText: "Water Absorption",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.moistureContentController,
                        hintText: "Moisture Content",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                CommonTextField(
                  controller: controller.finenessModulesController,
                  hintText: "Fineness Modules",
                ),
                const Gap(12),
                CommonTextField(
                  controller: controller.machineTypeController,
                  hintText: "Machine Type",
                ),

                const Gap(24),
                // ─── Notes ─────────────────────────────────────────
                _sectionTitle("Notes"),
                const Gap(12),
                CommonTextField(
                  controller: controller.noteController,
                  hintText: "Note",
                  maxLine: 3,
                ),
                const Gap(12),
                CommonTextField(
                  controller: controller.termsController,
                  hintText: "Terms and Conditions",
                  maxLine: 3,
                ),

                const Gap(24),
                // ─── Media ────────────────────────────────────────
                _sectionTitle("Images"),
                const Gap(12),
                _buildImagePicker(),

                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  child: RoundedButton(
                    buttonName: "Add to Inventory",
                    onTap: controller.createProduct,
                  ),
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: MyTexts.bold16),
      const Gap(4),
      Container(height: 2, width: 40, color: MyColors.primary),
    ],
  );

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) itemLabel,
  }) {
    final isEmpty = items.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: MyTexts.medium14.copyWith(color: MyColors.grey)),
        const Gap(6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isEmpty ? MyColors.grayF7 : null,
            border: Border.all(color: MyColors.grayEA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isEmpty
              ? SizedBox(
                  height: 48,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "No items available",
                      style: MyTexts.medium14.copyWith(color: MyColors.dustyGray),
                    ),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: true,
                    value: value,
                    hint: Text(
                      "Select $label",
                      style: MyTexts.medium13.copyWith(
                        color: MyColors.primary.withValues(alpha: 0.5),
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
                    onChanged: onChanged,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: controller.pickImages,
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.grayEA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_a_photo_outlined, color: MyColors.primary, size: 28),
                const Gap(8),
                Text("Tap to add images", style: MyTexts.regular14),
              ],
            ),
          ),
        ),
        const Gap(12),
        Obx(
          () => controller.pickedFilePathList.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.pickedFilePathList.length,
                    separatorBuilder: (_, __) => const Gap(10),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(controller.pickedFilePathList[index]),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: GestureDetector(
                              onTap: () => controller.removeImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
