import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/stepper_widget_add_product.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/controller/add_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({super.key});

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

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
                onTap: () {
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
              title: Text(controller.isEdit ? "EDIT PRODUCT" : "ADD PRODUCT"),
              isCenter: false,
            ),

            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey2,
                    // autovalidateMode: AutovalidateMode.,
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
                              () => DashedCircle(
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
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
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
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter product name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        if (controller.isEdit)
                          CommonTextField(
                            headerText: 'Product Code',
                            readOnly: true,
                            hintText: "CTPC01",
                            bgColor: Colors.grey.shade100,
                            controller: controller.productCodeController,
                          ),
                        if (controller.isEdit) SizedBox(height: 2.h),
                        CommonDropdown<String>(
                          headerText: 'Main Category',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select a main category";
                            }
                            return null;
                          },
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
                        CommonDropdown<String>(
                          headerText: 'Sub-category',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select a sub category";
                            }
                            return null;
                          },
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
                              return controller.isOutStock.value
                                  ? Column(
                                      children: [
                                        SizedBox(height: 1.h),
                                        CommonTextField(
                                          hintText: "Add  Stock",
                                          controller:
                                              controller.stockController,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Please enter stock";
                                            }
                                            if (double.tryParse(val) == null) {
                                              return "Enter valid number";
                                            }
                                            if (int.tryParse(val) == 0) {
                                              return "Stock can not be zero";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                            SizedBox(height: 2.h),
                          ],
                        ),
                        Obx(() {
                          if (controller.productNames.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonDropdown<String>(
                                  headerText: 'Product',
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please select product";
                                    }
                                    return null;
                                  },
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
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                headerText: 'Rate',
                                hintText: "ENTER RATE",
                                controller: controller.priceController,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter rate";
                                  }
                                  if (double.tryParse(val) == null) {
                                    return "Enter valid number";
                                  }
                                  if (int.tryParse(val) == 0) {
                                    return "Rate can not be zero";
                                  }
                                  return null;
                                },
                                onChange: (p0) {
                                  if (controller.selectedGST.value != null) {
                                    controller.gstCalculate();
                                  }
                                },
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "₹",
                                    style: MyTexts.regular20.copyWith(
                                      color: MyColors.lightBlueSecond,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: CommonDropdown<String>(
                                headerText: 'GST',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please select gst";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  if ((val ?? "").isNotEmpty) {
                                    if (controller
                                        .priceController
                                        .text
                                        .isNotEmpty) {
                                      controller.gstCalculate();
                                    }
                                  }
                                },
                                hintText: "SELECT GST PERCENTAGE",
                                items: controller.gstList,
                                selectedValue: controller.selectedGST,
                                itemLabel: (item) => item,
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
                                  child: Text(
                                    "₹",
                                    style: MyTexts.regular20.copyWith(
                                      color: MyColors.lightBlueSecond,
                                    ),
                                  ),
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
                          controller: controller.noteController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter note";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        CommonTextField(
                          headerText: 'Terms & Conditions',
                          hintText: "ADD  CONDITIONS",
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter terms & condition";
                            }
                            return null;
                          },
                          maxLine: 3,
                          controller: controller.termsController,
                        ),
                        SizedBox(height: 4.h),
                        Center(
                          child: RoundedButton(
                            buttonName: 'PROCEED',
                            onTap: () async {
                              if (controller.pickedFilePath.value.isEmpty) {
                                SnackBars.errorSnackBar(
                                  content: 'Product image is required',
                                );
                                return;
                              }
                              if (formKey2.currentState!.validate()) {
                                if (await controller.firstPartValidation()) {
                                  controller.showExtraFields.value = true;
                                  controller.pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              } else {
                                SnackBars.errorSnackBar(
                                  content:
                                      "Please fill all required fields properly",
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ------------------- PAGE 2 -------------------
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StepperWidgetAddProduct(currentStep: 2),
                        SizedBox(height: 3.h),
                        CommonTextField(
                          headerText: 'Brand Name',
                          hintText: "ENTER PRODUCT BRAND NAME",
                          controller: controller.brandNameController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter brand name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        Obx(() {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.filters.length,
                            itemBuilder: (context, index) {
                              final filter = controller.filters[index];
                              final controllerField = controller
                                  .dynamicControllers[filter.filterName];

                              // Dropdown type
                              if (filter.filterType == 'dropdown') {
                                controller.dropdownValues.putIfAbsent(
                                  filter.filterName!,
                                  () => Rxn<String>(),
                                );

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: CommonDropdown<String>(
                                    headerText: filter.filterLabel ?? '',
                                    hintText:
                                        "Select ${filter.filterLabel ?? ''}",
                                    items: (filter.dropdownList ?? [])
                                        .cast<String>(),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please select ${filter.filterLabel ?? 'a value'}";
                                      }
                                      return null;
                                    },
                                    selectedValue: controller
                                        .dropdownValues[filter.filterName]!,
                                    itemLabel: (item) => item,
                                    onChanged: (val) {
                                      controller
                                              .dynamicControllers[filter
                                                  .filterName]
                                              ?.text =
                                          val ?? '';
                                    },
                                  ),
                                );
                              }
                              // Number type filter
                              if (filter.filterType == 'number') {
                                final min = double.tryParse(
                                  filter.minValue?.toString() ?? '',
                                );
                                final max = double.tryParse(
                                  filter.maxValue?.toString() ?? '',
                                );

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: CommonTextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    headerText: filter.filterLabel ?? '',
                                    hintText:
                                        "Enter ${filter.filterLabel ?? ''}",
                                    controller: controllerField,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please enter a value";
                                      }
                                      final numValue = double.tryParse(val);
                                      if (numValue == null) {
                                        return "Enter a valid number";
                                      }
                                      if (min != null && numValue < min) {
                                        return "Value must be ≥ $min";
                                      }
                                      if (max != null && numValue > max) {
                                        return "Value must be ≤ $max";
                                      }
                                      return null;
                                    },
                                    suffixIcon: filter.unit != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                              top: 12.0,
                                            ),
                                            child: Text(
                                              filter.unit!,
                                              style: MyTexts.medium14.copyWith(
                                                color: MyColors.primary,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }

                              //  text type
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: CommonTextField(
                                  keyboardType: TextInputType.number,
                                  headerText: filter.filterLabel ?? '',
                                  hintText: "Enter ${filter.filterLabel ?? ''}",
                                  controller: controllerField,

                                  suffixIcon: filter.unit != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            top: 8.0,
                                          ),
                                          child: Text(
                                            filter.unit!,
                                            style: MyTexts.regular14.copyWith(
                                              color: MyColors.grey,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            },
                          );
                        }),

                        SizedBox(height: 2.h),
                        Center(
                          child:  RoundedButton(
                              buttonName: 'SUBMIT',
                              onTap: () async {
                                if (formKey1.currentState!.validate()) {
                                  if (await controller.firstPartValidation()) {
                                    hideKeyboard();
                                    controller.submitProduct(formKey1);
                                  }
                                } else {
                                  SnackBars.errorSnackBar(
                                    content:
                                    "Please fill all required fields properly",
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
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
