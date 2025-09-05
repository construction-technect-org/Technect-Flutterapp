import 'package:construction_technect/app/core/utils/custom_switch.dart';
import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/stepper_widget_add_product.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddProduct/controller/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final bool isEdit = (Get.arguments?['isEdit'] ?? false) as bool;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove default back button
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 6.h, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(50),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isEdit ? "EDIT PRODUCT" : "ADD PRODUCT", // 👈 dynamic title
                    style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Enter Product Details",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(), // user swipe disable
          children: [
            // ------------------- PAGE 1 -------------------
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepperWidgetAddProduct(currentStep: 1),
                  SizedBox(height: 3.h),

                  // Product Image
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Product Image",
                      style: MyTexts.regular18.copyWith(color: MyColors.lightBlue),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DashedCircle(
                        size: 81,
                        color: MyColors.grey,
                        strokeWidth: 1.2,
                        assetImage: Asset.profil,
                      ),
                      const SizedBox(width: 12),

                      // File Picker
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 119,
                              height: 31,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: controller.pickFile,
                                child: Text(
                                  "Choose File",
                                  style: MyTexts.regular16.copyWith(
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.pickedFileName.value,
                              style: MyTexts.regular16.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Product Name',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.productNameController),
                  SizedBox(height: 2.h),

                  // Category
                  Row(
                    children: [
                      Text(
                        'Category',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // Category
                  CommonDropdown<String>(
                    hintText: "Select Category",
                    items: controller.categories,
                    selectedValue: controller.selectedCategory,
                    itemLabel: (item) => item,
                  ),
                  SizedBox(height: 2.h),

                  // Sub-category
                  Row(
                    children: [
                      Text(
                        'Sub-category',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // Sub-category (auto loads when category changes)
                  CommonDropdown<String>(
                    hintText: "Select Sub category",
                    items: controller.subCategories,
                    selectedValue: controller.selectedSubCategory,
                    itemLabel: (item) => item,
                  ),

                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'UOM',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // UOM
                  CommonDropdown<String>(
                    hintText: "Select UOM",
                    items: controller.uomList,
                    selectedValue: controller.selectedUom,
                    itemLabel: (item) => item,
                  ),
                  SizedBox(height: 2.h),
                  // Price
                  Row(
                    children: [
                      Text(
                        'Price',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: controller.priceController,
                    prefix: Image.asset(Asset.price, height: 20, width: 29),
                  ),
                  SizedBox(height: 2.h),

                  // GST
                  Row(
                    children: [
                      Text(
                        'GST%',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: controller.gstController,
                    prefix: Image.asset(Asset.gst, height: 16, width: 29),
                  ),
                  SizedBox(height: 2.h),

                  // GST Price
                  Row(
                    children: [
                      Text(
                        'GST Price',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: controller.gstPriceController,
                    prefix: Image.asset(Asset.price, height: 20, width: 29),
                  ),
                  SizedBox(height: 2.h),

                  // Terms
                  Row(
                    children: [
                      Text(
                        'Terms & Conditions',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.termsController, maxLines: 3),

                  SizedBox(height: 2.h), SizedBox(height: 2.h),
                  Center(
                    child: RoundedButton(
                      buttonName: 'NEXT',
                      onTap: () {
                        controller.showExtraFields.value = true;
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ------------------- PAGE 2 -------------------
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepperWidgetAddProduct(currentStep: 2),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        'Package Size',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                      Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.packageSizeController),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'Shape',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.shapeController),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'Texture',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.textureController),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'Color',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.colorController),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'Package Type',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.packageTypeController),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        'Grain Size',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.grainSizeController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Fineness Modulus',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.finenessModulusController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Silt Content',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.siltContentController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Clay & Dust Content',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.clayDustContentController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Moisture Content',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.moistureContentController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Specific Gravity',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.specificGravityController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Bulk Density',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.bulkDensityController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Water Absorption',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.waterAbsorptionController),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Text(
                        'Zone',
                        style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(controller: controller.zoneController),

                  SizedBox(height: 2.h),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.isEnabled.value
                              ? MyColors.green.withOpacity(0.6)
                              : MyColors.red.withOpacity(0.6),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.isEnabled.value ? "Active" : "Inactive",
                            style: MyTexts.medium16.copyWith(
                              color: controller.isEnabled.value
                                  ? MyColors.green
                                  : MyColors.red,
                            ),
                          ),
                          CustomSwitch(
                            value: controller.isEnabled.value,
                            onChanged: (val) async {
                              final result = await Get.bottomSheet<bool>(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        val ? Icons.check_circle : Icons.cancel,
                                        color: val ? MyColors.green : MyColors.red,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        val ? "Activate Product" : "Deactivate Product",
                                        style: MyTexts.medium18,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        val
                                            ? "Are you sure you want to mark this product as Active?"
                                            : "Are you sure you want to mark this product as Inactive?",
                                        style: MyTexts.regular14.copyWith(
                                          color: MyColors.shadeOfGray,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () => Get.back(result: false),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: MyColors.fontBlack,
                                                side: const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: const Text("Cancel"),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: MyColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () => Get.back(result: true),
                                              child: Text(
                                                "Yes, Confirm",
                                                style: MyTexts.light16.copyWith(
                                                  color: MyColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              if (result == true) {
                                controller.isEnabled.value = val;
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 2.h),

                  Center(
                    child: RoundedButton(
                      buttonName: 'SUBMIT',
                      onTap: controller.submitProduct,
                    ),
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
