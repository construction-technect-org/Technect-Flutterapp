import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/stepper_widget_add_product.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/AddProduct/controller/add_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (controller.pageController.page == 0) {
            Get.back();
          } else {
            controller.pageController.jumpToPage(0);
          }
        }
      },
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            backgroundColor: MyColors.white,
            appBar: CommonAppBar(
              leading: GestureDetector(
                onTap: (){
                  if (controller.pageController.page == 0) {
                    Get.back();
                  } else {
                    controller.pageController.jumpToPage(0);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                ),
              ),
              title:    Text(
                controller.isEdit ? "EDIT PRODUCT" : "ADD PRODUCT",

              ),
              isCenter: false,
            ),

            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StepperWidgetAddProduct(currentStep: 1),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Product Image",
                          style: MyTexts.regular18.copyWith(
                            color: MyColors.lightBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                                () =>
                                DashedCircle(
                                  size: 81,
                                  color: MyColors.grey,
                                  strokeWidth: 1.2,
                                  assetImage: Asset.profil,
                                  file: controller.pickedFilePath.value,
                                ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Obx(
                                  () =>
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                8,
                                              ),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: controller.pickImage,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              "Choose Image",
                                              style: MyTexts.regular16.copyWith(
                                                color: MyColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        controller.pickedFileName.value == ''
                                            ? "Upload Product Image"
                                            : controller.pickedFileName.value,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyTexts.regular16.copyWith(
                                          color: MyColors.fontBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      CommonTextField(
                        headerText: 'Product Name',
                        hintText: "ENTER YOUR PRODUCT NAME",
                        controller: controller.productNameController,
                      ),
                      SizedBox(height: 2.h),
                      if(controller.isEdit)
                      CommonTextField(
                        headerText: 'Product Code',
                        readOnly: true,
                        hintText: "CTPC01",
                        bgColor: Colors.grey.shade100 ,
                        controller: controller.productCodeController,
                      ),
                      if(controller.isEdit)
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Main Category',
                            style: MyTexts.light16.copyWith(
                              color: MyColors.lightBlue,
                            ),
                          ),
                          Text(
                            '*',
                            style: MyTexts.light16.copyWith(
                              color: MyColors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        hintText: "SELECT PRODUCT MAIN CATEGORY",
                        items: controller.mainCategoryNames,
                        selectedValue: controller.selectedMainCategory,
                        itemLabel: (item) => item,
                        onChanged: controller.isEdit
                            ? null
                            : (value) {
                          controller.onMainCategorySelected(value);
                        },
                        enabled: !controller.isEdit,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Sub-category',
                            style: MyTexts.light16.copyWith(
                              color: MyColors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        hintText: "SELECT PRODUCT SUB- CATEGORY",
                        items: controller.subCategoryNames,
                        selectedValue: controller.selectedSubCategory,
                        itemLabel: (item) => item,
                        onChanged: controller.isEdit
                            ? null
                            : (value) {
                          controller.onSubCategorySelected(value);
                        },
                        enabled: !controller.isEdit,
                      ),
                      SizedBox(height: 2.h),
                      // if(controller.isEdit)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'In Stock',
                                style: MyTexts.light16.copyWith(
                                  color: MyColors.lightBlue,
                                ),
                              ),
                              const Spacer(),
                              Obx(() {
                                return CupertinoSwitch(
                                  value: controller.isOutStock.value,
                                  onChanged: (val) {
                                    controller.isOutStock.value = val;
                                  },
                                );
                              }),
                            ],
                          ),
                          Obx(() {
                            return controller.isOutStock.value ? Column(
                              children: [
                                SizedBox(height: 1.h),
                                CommonTextField(
                                  hintText: "Add  Stock",
                                  controller: controller.stockController,
                                 keyboardType: TextInputType.number,

                                ),
                              ],
                            ) : const SizedBox();
                          }),
                          SizedBox(height: 2.h),

                        ],
                      ),


                      Obx(() {
                        if (controller.productNames.isNotEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Product',
                                    style: MyTexts.light16.copyWith(
                                      color: MyColors.lightBlue,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: MyTexts.light16.copyWith(
                                      color: MyColors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              CommonDropdown<String>(
                                hintText: "Select Product",
                                items: controller.productNames,
                                selectedValue: controller.selectedProduct,
                                itemLabel: (item) => item,
                                onChanged: controller.isEdit
                                    ? null
                                    : (val) {
                                  controller.onProductSelected(val);
                                },
                                enabled: !controller.isEdit,
                              ),
                              SizedBox(height: 2.h),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                      Row(
                        children: [
                          Text(
                            'Unit of Measure',
                            style: MyTexts.light16.copyWith(
                              color: MyColors.lightBlue,
                            ),
                          ),
                          Text(
                            '*',
                            style: MyTexts.light16.copyWith(
                              color: MyColors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        hintText: "SELECT PRODUCT UOM",
                        items: controller.uomList,
                        selectedValue: controller.selectedUom,
                        itemLabel: (item) => item,
                      ),
                      SizedBox(height: 2.h),
                      // Price
                      CommonTextField(
                        keyboardType: TextInputType.number,

                        headerText: 'Unit of conversation',
                        hintText: "ENTER YOUR UOC",
                        controller: controller.uocController,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              headerText: 'Rate',
                              hintText: "ENTER RATE",
                              controller: controller.priceController,
                              keyboardType: TextInputType.number,
                              onChange: (p0) {
                                if(controller.selectedGST.value!=null){
                                  controller.gstCalculate();

                                }
                              },
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("₹",
                                  style: MyTexts.regular20.copyWith(
                                      color: MyColors.lightBlueSecond),),
                              ),
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'GST',
                                      style: MyTexts.light16.copyWith(
                                        color: MyColors.lightBlue,
                                      ),
                                    ),
                                    Text(
                                      '*',
                                      style: MyTexts.light16.copyWith(
                                        color: MyColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                // spacing instead of Expanded
                                CommonDropdown<String>(
                                  onChanged: (val){
                                    if((val??"").isNotEmpty){
                                      if(controller.priceController.text.isNotEmpty){
                                        controller.gstCalculate();

                                      }

                                    }
                                  },
                                  hintText: "SELECT GST PERCENTAGE",
                                  items: controller.gstList,
                                  selectedValue: controller.selectedGST,
                                  itemLabel: (item) => item,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              readOnly: true,
                              headerText: 'Amount',
                              hintText: "ENTER AMOUNT",
                              controller: controller.amountController,
                              keyboardType: TextInputType.number,
                              onChange: (p0) {
                                // controller.gstCalculate();
                              },
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("₹",
                                  style: MyTexts.regular20.copyWith(
                                      color: MyColors.lightBlueSecond),),
                              ),
                            ),
                          ),

                          const Gap(20),
                          Expanded(
                            child: CommonTextField(
                              headerText: 'GST amount',
                              hintText: "GST AMOUNT",
                              readOnly: true,
                              controller: controller.gstPriceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Note',
                        hintText: "ADD  NOTE",
                        maxLine: 3,
                        isRed: false,
                        controller: controller.noteController,
                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Terms & Conditions',
                        hintText: "ADD  CONDITIONS",
                        maxLine: 3,
                        isRed: false,
                        controller: controller.termsController,
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: RoundedButton(
                          buttonName: 'PROCEED',
                          onTap: () async {
                            if (await controller.firstPartValidation()) {
                              controller.showExtraFields.value = true;
                              controller.pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
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
                      CommonTextField(
                        headerText: 'Brand Name',
                        hintText: "ENTER PRODUCT BRAND NAME",
                        controller: controller.brandNameController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Package Type',
                        hintText: "ENTER PRODUCT PACKAGE TYPE",
                        controller: controller.packageTypeController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Package Size',
                        hintText: "ENTER PRODUCT PACKAGE SIZE",
                        controller: controller.packageSizeController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Shape',
                        hintText: "ENTER PRODUCT SHAPE",
                        controller: controller.shapeController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Texture',
                        hintText: "ENTER PRODUCT TEXTURE",
                        controller: controller.textureController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Color',
                        hintText: "ENTER PRODUCT COLOR",
                        controller: controller.colorController,

                      ),
                      SizedBox(height: 2.h),
                      CommonTextField(
                        headerText: 'Grain Size',
                        hintText: "ENTER PRODUCT GRAIN SIZE",
                        controller: controller.sizeController,
                        keyboardType: TextInputType.number,


                      ),
                      SizedBox(height: 2.h),
                      Obx(
                            () =>
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.filters.length,
                              itemBuilder: (context, index) {
                                final filter = controller.filters[index];
                                return

                                  Padding(
                                    padding:  EdgeInsets.only(bottom: 2.h),
                                    child: CommonTextField(
                                      headerText:  filter.filterLabel ?? '',
                                      isRed: false,
                                      hintText: "Enter ${ filter.filterLabel ?? ''}",
                                      controller: controller
                                          .dynamicControllers[filter
                                          .filterName],
                                      validator: (value) {
                                        if (filter.isRequired == true &&
                                            (value == null || value.isEmpty)) {
                                          return "${filter
                                              .filterLabel} is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                              },
                            ),
                      ),
                      // if (controller.isEdit)
                      //   Obx(() {
                      //     return Container(
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 16,
                      //         vertical: 12,
                      //       ),
                      //       margin: const EdgeInsets.symmetric(vertical: 8),
                      //       decoration: BoxDecoration(
                      //         color: MyColors.white,
                      //         borderRadius: BorderRadius.circular(12),
                      //         border: Border.all(
                      //           color: controller.isEnabled.value
                      //               ? MyColors.green.withValues(alpha: 0.6)
                      //               : MyColors.red.withValues(alpha: 0.6),
                      //           width: 1.2,
                      //         ),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.black.withValues(alpha: 0.05),
                      //             blurRadius: 6,
                      //             offset: const Offset(0, 2),
                      //           ),
                      //         ],
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             controller.isEnabled.value
                      //                 ? "Active"
                      //                 : "Inactive",
                      //             style: MyTexts.medium16.copyWith(
                      //               color: controller.isEnabled.value
                      //                   ? MyColors.green
                      //                   : MyColors.red,
                      //             ),
                      //           ),
                      //           CustomSwitch(
                      //             value: controller.isEnabled.value,
                      //             onChanged: (val) async {
                      //               final result = await Get.bottomSheet<bool>(
                      //                 Container(
                      //                   padding: const EdgeInsets.all(20),
                      //                   decoration: BoxDecoration(
                      //                     color: MyColors.white,
                      //                     borderRadius:
                      //                     const BorderRadius.vertical(
                      //                       top: Radius.circular(20),
                      //                     ),
                      //                   ),
                      //                   child: Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Icon(
                      //                         val
                      //                             ? Icons.check_circle
                      //                             : Icons.cancel,
                      //                         color: val
                      //                             ? MyColors.green
                      //                             : MyColors.red,
                      //                         size: 40,
                      //                       ),
                      //                       const SizedBox(height: 12),
                      //                       Text(
                      //                         val
                      //                             ? "Activate Product"
                      //                             : "Deactivate Product",
                      //                         style: MyTexts.medium18,
                      //                       ),
                      //                       const SizedBox(height: 8),
                      //                       Text(
                      //                         val
                      //                             ? "Are you sure you want to mark this product as Active?"
                      //                             : "Are you sure you want to mark this product as Inactive?",
                      //                         style: MyTexts.regular14.copyWith(
                      //                           color: MyColors.shadeOfGray,
                      //                         ),
                      //                         textAlign: TextAlign.center,
                      //                       ),
                      //                       SizedBox(height: 2.h),
                      //                       Row(
                      //                         children: [
                      //                           Expanded(
                      //                             child: OutlinedButton(
                      //                               onPressed: () =>
                      //                                   Get.back(result: false),
                      //                               style:
                      //                               OutlinedButton.styleFrom(
                      //                                 foregroundColor:
                      //                                 MyColors
                      //                                     .fontBlack,
                      //                                 side:
                      //                                 const BorderSide(
                      //                                   color:
                      //                                   Colors.grey,
                      //                                 ),
                      //                               ),
                      //                               child: const Text("Cancel"),
                      //                             ),
                      //                           ),
                      //                           const SizedBox(width: 12),
                      //                           Expanded(
                      //                             child: ElevatedButton(
                      //                               style: ElevatedButton
                      //                                   .styleFrom(
                      //                                 backgroundColor:
                      //                                 MyColors.primary,
                      //                                 shape: RoundedRectangleBorder(
                      //                                   borderRadius:
                      //                                   BorderRadius.circular(
                      //                                     12,
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                               onPressed: () =>
                      //                                   Get.back(result: true),
                      //                               child: Text(
                      //                                 "Yes, Confirm",
                      //                                 style: MyTexts.light16
                      //                                     .copyWith(
                      //                                   color:
                      //                                   MyColors.white,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //               if (result == true) {
                      //                 controller.isEnabled.value = val;
                      //               }
                      //             },
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   }),
                      SizedBox(height: 2.h),
                      Center(
                        child: Obx(
                              () =>
                              RoundedButton(
                                buttonName: 'SUBMIT',
                                onTap: controller.isLoading.value
                                    ? null
                                    : controller.submitProduct,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
