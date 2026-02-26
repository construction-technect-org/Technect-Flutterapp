import 'dart:io';

import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/main_home_controller.dart';
import 'package:flutter/cupertino.dart';

class AddGenericView extends GetView<MainHomeController> {
  final String type = Get.arguments?['type'] ?? 'Product';
  bool get isProduct => type.toLowerCase() == 'product';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final currentPage = controller.pageController.page?.toInt() ?? 0;
          if (currentPage == 0 || currentPage == 4) {
            Get.back();
          } else {
            hideKeyboard();
            controller.pageController.animateToPage(
              currentPage - 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
      },
      child: Obx(
        () => LoaderWrapper(
          isLoading: controller.isLoading,
          child: GestureDetector(
            onTap: hideKeyboard,
            child: Scaffold(
              backgroundColor: MyColors.white,
              appBar: CommonAppBar(
                leading: GestureDetector(
                  onTap: () {
                    final currentPage = controller.pageController.page?.toInt() ?? 0;
                    if (currentPage == 0 || currentPage == 4) {
                      Get.back();
                    } else {
                      hideKeyboard();
                      controller.pageController.animateToPage(
                        currentPage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                  ),
                ),
                title: Text(controller.isEdit ? "Edit $type" : "Add $type"),
                isCenter: false,
              ),
              body: Column(
                children: [
                  Obx(() => _buildProgressBar(controller.currentStep.value)),
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        controller.currentStep.value = index;
                      },
                      children: [
                        _buildStep1(context),
                        _buildStep2(context),
                        _buildStep4(context), // This is the Media/Additional Info step
                        _buildPreviewStep(context),
                        _buildSuccessPage(),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Obx(() {
                final step = controller.currentStep.value;
                if (step == 3 || step == 4) return const SizedBox.shrink();
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      children: [
                        if (step > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => controller.goBack(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                side: const BorderSide(color: MyColors.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Back',
                                style: MyTexts.medium16.copyWith(color: MyColors.primary),
                              ),
                            ),
                          ),
                        if (step > 0) const Gap(16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!isProduct && step == 2) {
                                controller.createProduct();
                              } else {
                                controller.goNext();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              step == 2 ? (isProduct ? 'Preview' : 'Add') : 'Next',
                              style: MyTexts.medium16.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(int currentStep) {
    if (currentStep >= 3) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: MyColors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Product", style: MyTexts.medium14.copyWith(color: MyColors.black)),
              Text(
                "${currentStep + 1}/3 Steps",
                style: MyTexts.medium14.copyWith(color: MyColors.black),
              ),
            ],
          ),
          const Gap(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / 3,
              backgroundColor: MyColors.grayEA,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(BuildContext context) {
    // Static mockup list of shipping locations (can be replaced with API data later)
    final List<String> shippingLocations = [
      'Warehouse A - 123 Main St, NY',
      'Warehouse B - 456 Elm St, CA',
      'Warehouse C - 789 Maple Ave, TX',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Form(
        key: controller.formKey2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              // Explicitly read .value to register GetX subscriptions
              controller.selectedMainCatName.value;
              controller.selectedCatName.value;
              controller.selectedSubCatName.value;
              controller.selectedCatProdName.value;
              controller.selectedShippingAddress.value; // Add this line

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Static Type Read-only
                  Text('Type', style: MyTexts.bold14),
                  const Gap(8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: MyColors.grayF7,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.grayEA),
                    ),
                    child: Text(
                      type, // Or service, tools, etc if passed via arguments
                      style: MyTexts.medium14.copyWith(color: MyColors.dustyGray),
                    ),
                  ),
                  const Gap(20),

                  // 2. Shipping Location (Static UI)
                  CommonDropdown<String>(
                    headerText: 'Shipping Location',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Please select shipping location' : null,
                    hintText: 'Select shipping location',
                    items: shippingLocations,
                    selectedValue: controller.selectedShippingAddress,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      controller.selectedShippingAddress.value = value;
                    },
                  ),
                  const Gap(20),

                  // 3. Main Category
                  CommonDropdown<String>(
                    headerText: 'Main Category',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Please select a main category' : null,
                    hintText: 'Select product main category',
                    items: controller.mainCatListNames,
                    selectedValue: controller.selectedMainCatName,
                    itemLabel: (item) => item,
                    onChanged: controller.isEdit
                        ? null
                        : (value) => controller.onMainCategorySelected(value),
                    enabled: !controller.isEdit,
                  ),
                  const Gap(20),
                  CommonDropdown<String>(
                    headerText: 'Category',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Please select a category' : null,
                    hintText: 'Select product category',
                    items: controller.catListNames,
                    selectedValue: controller.selectedCatName,
                    itemLabel: (item) => item,
                    onChanged: controller.isEdit
                        ? null
                        : (value) => controller.onCategorySelected(value),
                    enabled: !controller.isEdit,
                  ),
                  const Gap(20),
                  CommonDropdown<String>(
                    headerText: 'Sub-category',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Please select a sub category' : null,
                    hintText: 'Select product sub-category',
                    items: controller.subCatListNames,
                    selectedValue: controller.selectedSubCatName,
                    itemLabel: (item) => item,
                    onChanged: controller.isEdit
                        ? null
                        : (value) => controller.onSubCategorySelected(value),
                    enabled: !controller.isEdit,
                  ),
                  const Gap(20),
                  CommonDropdown<String>(
                    headerText: 'Product Category',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Please select a product category' : null,
                    hintText: 'Select product category',
                    items: controller.catProdListNames,
                    selectedValue: controller.selectedCatProdName,
                    itemLabel: (item) => item,
                    onChanged: controller.isEdit
                        ? null
                        : (value) => controller.onProductCategorySelected(value),
                    enabled: !controller.isEdit,
                  ),
                ],
              );
            }),
            const Gap(20),
            CommonTextField(
              headerText: 'Brand Name',
              hintText: 'Enter product brand name',
              controller: controller.brandNameController,
              bgColor: MyColors.grayF7,
              borderRadius: 12,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Please enter brand name' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pricing Information
            Text("Pricing Information", style: MyTexts.medium16.copyWith(color: MyColors.black)),
            const Gap(12),
            // Unit of Mesurement
            // Text("Unit of Mesurement", style: MyTexts.medium16.copyWith(color: MyColors.black)),
            // const Gap(12),
            // Obx(
            //   () => Wrap(
            //     spacing: 12,
            //     runSpacing: 12,
            //     children: controller.unitOfMesurementListNames.map((unit) {
            //       final isSelected = controller.selectedUnitOfMesurements.contains(unit);
            //       return FilterChip(
            //         label: Text(unit),
            //         selected: isSelected,
            //         onSelected: controller.isEdit
            //             ? null
            //             : (selected) => controller.toggleUnitOfMesurement(unit),
            //         selectedColor: MyColors.lightBlueSecond.withOpacity(0.2),
            //         checkmarkColor: MyColors.lightBlueSecond,
            //         backgroundColor: MyColors.grayF7,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           side: BorderSide(
            //             color: isSelected ? MyColors.lightBlueSecond : Colors.transparent,
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
            CommonDropdown<String>(
              headerText: 'Unit of Mesurement',
              hintText: 'Select unit of mesurement',
              items: controller.unitOfMesurementListNames,
              selectedValue: controller.selectedUnitOfMesurementName,
              itemLabel: (item) => item,
              onChanged: controller.isEdit
                  ? null
                  : (value) => controller.onUnitOfMesurementSelected(value),
              enabled: !controller.isEdit,
            ),
            const Gap(20),
            // Ex Factory Price & With Tax
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CommonTextField(
                    headerText: 'Ex Factory Price',
                    hintText: "ENTER PRICE",
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    bgColor: MyColors.grayF7,
                    borderRadius: 12,
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Please enter price";
                      if (double.tryParse(val) == null) return "Enter valid number";
                      if (double.tryParse(val) == 0) return "Rate cannot be zero";
                      return null;
                    },
                    onChange: (val) {
                      if (controller.selectedGST.value != null) controller.gstCalculate();
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "₹",
                        style: MyTexts.regular20.copyWith(color: MyColors.lightBlueSecond),
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                // with tax dropdown
                Expanded(
                  child: CommonDropdown<String>(
                    headerText: 'With Tax',
                    hintText: 'Select',
                    items: controller.withTaxListNames,
                    selectedValue: controller.selectedWithTaxName,
                    itemLabel: (item) => item,
                    onChanged: controller.isEdit
                        ? null
                        : (value) => controller.onWithTaxSelected(value),
                    enabled: !controller.isEdit,
                  ),
                ),
              ],
            ),
            const Gap(20),
            // GST
            CommonDropdown<String>(
              headerText: 'GST',
              validator: (val) => (val == null || val.isEmpty) ? "Please select gst" : null,
              onChanged: (val) {
                if ((val ?? "").isNotEmpty && controller.priceController.text.isNotEmpty) {
                  controller.gstCalculate();
                }
              },
              hintText: "SELECT GST %",
              items: controller.gstList,
              selectedValue: controller.selectedGST,
              itemLabel: (item) => item,
            ),

            const Gap(12),
            // GST Price
            // Text("GST Price", style: MyTexts.medium16.copyWith(color: MyColors.black)),
            // const Gap(12),
            // feild for gst price
            CommonTextField(
              readOnly: true,
              headerText: 'GST Price',
              hintText: "GST PRICE",
              controller: controller.gstPriceController,
              keyboardType: TextInputType.number,
              bgColor: MyColors.grayF7,
              borderRadius: 12,
            ),
            const Gap(12),

            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    readOnly: true,
                    headerText: 'Ex Factory Rate',
                    hintText: "ENTER AMOUNT",
                    controller: controller.amountController,
                    keyboardType: TextInputType.number,
                    bgColor: MyColors.grayF7,
                    borderRadius: 12,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "₹",
                        style: MyTexts.regular20.copyWith(color: MyColors.lightBlueSecond),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),

            // Select the Units
            Text("Select the Units", style: MyTexts.medium16.copyWith(color: MyColors.black)),
            const Gap(12),
            // chips for selecting units like checkbox
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: controller.unitOfMesurementListNames.map((unit) {
                  final isSelected = controller.selectedUnitOfMesurements.contains(unit);
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? null : Icons.check_box_outline_blank_outlined,
                          color: MyColors.lightBlueSecond,
                        ),
                        if (isSelected) const Gap(4),
                        Text(unit),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: controller.isEdit
                        ? null
                        : (selected) => controller.toggleUnitOfMesurement(unit),
                    selectedColor: MyColors.lightBlueSecond.withOpacity(0.2),
                    checkmarkColor: MyColors.lightBlueSecond,
                    backgroundColor: MyColors.grayF7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected ? MyColors.lightBlueSecond : Colors.transparent,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Additional Information", style: MyTexts.medium16.copyWith(color: MyColors.black)),
            const Gap(16),

            // Horizontal Image Scroller
            SizedBox(
              height: 120,
              child: Obx(() {
                // Determine how many images are picked to show the correct number of slots + 1 for Add
                int addedImagesCount = controller.imageSlots.where((img) => img != null).length;
                int displayCount = addedImagesCount < 10 ? addedImagesCount + 1 : 10;

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: displayCount,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    // The first item should be the "Add" button if we haven't reached 10 images
                    // To accurately place the Add button, we can just say index == addedImagesCount implies it's the empty slot at the end
                    if (index == addedImagesCount) {
                      return GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: MyColors.grayEA),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 32, color: MyColors.black),
                                Text(
                                  "+ Add New",
                                  style: MyTexts.medium12.copyWith(color: MyColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    // Otherwise, show the actual uploaded image
                    // We need to find the non-null paths
                    List<String> validPaths = controller.imageSlots.whereType<String>().toList();
                    final path = validPaths[index];

                    // We also need the original index to remove the exact slot
                    final originalIndex = controller.imageSlots.indexOf(path);

                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: controller.isEdit
                              ? controller.pickImageEdit
                              : controller.pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: MyColors.grayF7,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: MyColors.grayEA),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: path.startsWith('http')
                                  ? getImageView(finalUrl: path, fit: BoxFit.cover)
                                  : Image.file(File(path), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        // Remove Button
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => controller.removeImageAt(originalIndex),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                              ),
                              child: const Icon(Icons.close, color: Colors.red, size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            const Gap(12),
            Text(
              "Upload up to 10 PNG/JPEG images. (max 3MB each)\nRecommended: 1024×1024 pixels.",
              style: MyTexts.regular13.copyWith(color: MyColors.gray54, height: 1.5),
            ),

            const Gap(30),
            CommonTextField(
              headerText: 'Terms & Conditions',
              hintText: "Enter terms & conditions",
              maxLine: 3,
              controller: controller.termsController,
              bgColor: MyColors.grayF7,
              borderRadius: 12,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? "Please enter terms & conditions" : null,
            ),
            const Gap(20),
            CommonTextField(
              headerText: 'Note',
              hintText: "Write a note",
              maxLine: 3,
              controller: controller.noteController,
              bgColor: MyColors.grayF7,
              borderRadius: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Column(
              children: [
                Text(
                  controller.brandNameController.text.toUpperCase(),
                  style: MyTexts.bold20.copyWith(color: MyColors.black),
                ),
                Text(
                  "Product ID - #54351316546",
                  style: MyTexts.regular12.copyWith(color: MyColors.primary, height: 1.5),
                ),
              ],
            ),
          ),
          const Gap(20),

          // Horizontal Image Gallery
          SizedBox(
            height: 180,
            child: Obx(() {
              final validImages = controller.imageSlots
                  .where((p) => p != null && p.isNotEmpty)
                  .toList();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: validImages.length,
                separatorBuilder: (context, index) => const Gap(12),
                itemBuilder: (context, index) {
                  final path = validImages[index]!;
                  return Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: MyColors.grayEA),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: path.startsWith('http')
                          ? getImageView(finalUrl: path, fit: BoxFit.cover)
                          : Image.file(File(path), fit: BoxFit.cover),
                    ),
                  );
                },
              );
            }),
          ),
          const Gap(24),

          // Stat Cards Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  image: Asset.material,
                  title: "Brand",
                  subtitle: controller.brandNameController.text.isEmpty
                      ? "Name"
                      : controller.brandNameController.text,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard(
                  title: "Ex-factory Price",
                  subtitle: "₹${controller.priceController.text}",
                  bottomText: "${controller.selectedGST.value} GST",
                ),
              ),
              const Gap(12),
              Expanded(child: _buildInStockCard()),
            ],
          ),
          const Gap(24),

          // Detailed Specifications List
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MyColors.grayF7),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  Asset.Locationon,
                  "Shipping Addr...",
                  controller.selectedSiteAddressName.value,
                ),
                _buildDetailRow(
                  Asset.category,
                  "Main Category",
                  controller.selectedMainCatName.value,
                ),
                _buildDetailRow(Asset.category1, "Category", controller.selectedCatName.value),
                _buildDetailRow(
                  Asset.category,
                  "Sub Category",
                  controller.selectedSubCatName.value,
                ),
                _buildDetailRow(
                  Asset.construction,
                  "Product",
                  controller.selectedCatProdName.value,
                ),
                _buildDetailRow(Asset.check, "Brand", controller.brandNameController.text),
                _buildDetailRow(
                  Asset.analysis,
                  "Ex Factory Price",
                  "₹${controller.priceController.text}",
                ),
                _buildDetailRow(Asset.cs, "GST", "${controller.selectedGST.value}"),
                _buildDetailRow(
                  Asset.report,
                  "GST Price",
                  "₹${controller.gstPriceController.text}",
                ),
                _buildDetailRow(
                  Asset.todo,
                  "Ex Factory Rate",
                  "₹${controller.amountController.text}",
                ),
                _buildDetailRow(
                  Asset.analysis,
                  "UOM",
                  controller.selectedUnitOfMesurementName.value,
                ),
                _buildDetailRow(
                  Asset.inventory,
                  "UOC",
                  controller.selectedUnitOfMesurements.join(", "),
                ),
                _buildDetailRow(Asset.todo, "HSN/SAC code", "68768767"),

                _buildDetailRow(Asset.report, "Description", ""),
                _buildDetailRow(Asset.todo, "Note", controller.noteController.text),

                // Barcode Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code_scanner, color: MyColors.gray54, size: 20),
                      const Gap(12),
                      Text("Bar-code", style: MyTexts.medium13.copyWith(color: MyColors.gray54)),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(Asset.inprog),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("463-789-1234", style: MyTexts.regular14.copyWith(letterSpacing: 2)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Gap(40),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  buttonName: "Edit",
                  onTap: () => controller.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  color: Colors.white,
                  fontColor: MyColors.primary,
                  borderColor: MyColors.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.edit_outlined, color: MyColors.primary, size: 18),
                      const Gap(4),
                      Text("Edit", style: MyTexts.medium15.copyWith(color: MyColors.primary)),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: RoundedButton(
                  buttonName: "Post in Marketplace",
                  onTap: () => controller.createProduct(),
                  color: MyColors.primary,
                  fontColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Post in Marketplace",
                        style: MyTexts.medium13.copyWith(color: Colors.white),
                      ),
                      const Gap(4),
                      const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    String? image,
    required String title,
    required String subtitle,
    String? bottomText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (image != null) ...[SvgPicture.asset(image, height: 24, width: 24), const Gap(8)],
              Expanded(
                child: Text(title, style: MyTexts.regular12.copyWith(color: MyColors.gray54)),
              ),
            ],
          ),
          const Gap(4),
          Text(subtitle, style: MyTexts.bold14.copyWith(color: MyColors.black)),
          if (bottomText != null)
            Text(bottomText, style: MyTexts.regular12.copyWith(color: MyColors.primary)),
        ],
      ),
    );
  }

  Widget _buildInStockCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("In stock", style: MyTexts.regular12.copyWith(color: MyColors.gray54)),
          const Gap(8),
          Obx(
            () => CupertinoSwitch(
              value: !controller.isOutStock.value,
              onChanged: (val) => controller.isOutStock.value = !val,
              activeColor: MyColors.primary.withOpacity(0.3),
              thumbColor: !controller.isOutStock.value ? MyColors.primary : MyColors.grayEA,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 18, width: 18, color: MyColors.gray54),
          const Gap(12),
          Text(label, style: MyTexts.medium13.copyWith(color: MyColors.gray54)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: MyColors.grayF7,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              (value == null || value.isEmpty) ? "Name" : value,
              style: MyTexts.medium13.copyWith(color: MyColors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPage() {
    return SuccessScreen(header: "Product added successfully", onTap: () => Get.back());
  }
}
