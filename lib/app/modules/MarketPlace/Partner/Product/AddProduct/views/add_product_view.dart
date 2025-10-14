import 'dart:io';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
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
                        SizedBox(height: 1.h),
                        if (controller.isEdit)
                          Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(5, (index) {
                                  final path = controller.imageSlots[index];

                                  if (path != null) {
                                    return Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            top: 8,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: GestureDetector(
                                              // onTap: () => controller.showFullImage(path),
                                              child: path.contains('http')
                                                  ? getImageView(
                                                      finalUrl: path,
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(
                                                      File(path),
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.removeImageAt(index),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(3),
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                        top: 8,
                                      ),
                                      child: GestureDetector(
                                        onTap: controller.pickImageEdit,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MyColors.grey,
                                              width: 1.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.grey.shade100,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ),
                            ),
                          ),
                        if (!controller.isEdit)
                          Obx(() {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...controller.pickedFilePathList.map(
                                    (path) => Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            top: 8,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.dialog(
                                                  Dialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.topRight,
                                                      children: [
                                                        InteractiveViewer(
                                                          child:
                                                              path.contains(
                                                                'http',
                                                              )
                                                              ? Image.network(
                                                                  path,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                )
                                                              : Image.file(
                                                                  File(path),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                16.0,
                                                              ),
                                                          child: GestureDetector(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: path.contains('http')
                                                  ? getImageView(
                                                      finalUrl: path ?? "",
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(
                                                      File(path),
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () => controller
                                                .pickedFilePathList
                                                .remove(path),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(3),
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (controller.pickedFilePathList.length < 5)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                        top: 8,
                                      ),
                                      child: GestureDetector(
                                        onTap: controller.pickImage,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MyColors.grey,
                                              width: 1.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.grey.shade100,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
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
                                headerText: 'Ex Factory Price',
                                hintText: "ENTER PRICE",
                                controller: controller.priceController,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter price";
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
                                headerText: 'Ex Factory Amount',
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
                              if (controller.pickedFilePathList.isEmpty &&
                                  !controller.isEdit) {
                                SnackBars.errorSnackBar(
                                  content: 'Please upload at least one image',
                                );
                                return;
                              }
                              if (controller.isEdit) {
                                final hasImage = controller.imageSlots.any(
                                  (path) =>
                                      path != null &&
                                      path.toString().trim().isNotEmpty,
                                );
                                if (!hasImage) {
                                  SnackBars.errorSnackBar(
                                    content: 'Please upload at least one image',
                                  );
                                  return;
                                }
                              }
                              if (formKey2.currentState!.validate()) {
                                controller.showExtraFields.value = true;
                                controller.pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
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
                        Obx(() {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.filters.length,
                            itemBuilder: (context, index) {
                              final filter = controller.filters[index];
                              final controllerField = controller
                                  .dynamicControllers[filter.filterName];

                              // 🔹 Single Dropdown
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

                              if (filter.filterType == 'dropdown_multiple') {
                                controller.multiDropdownValues.putIfAbsent(
                                  filter.filterName!,
                                  () => <String>[].obs,
                                );

                                // RxString for showing validation error
                                final RxString errorText = ''.obs;

                                final selectedList = controller
                                    .multiDropdownValues[filter.filterName]!;

                                return Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              filter.filterLabel ?? '',
                                              style: MyTexts.regular16.copyWith(
                                                color: MyColors.lightBlue,
                                                fontFamily: MyTexts.SpaceGrotesk,
                                              ),
                                            ),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        GestureDetector(
                                          onTap: () async {
                                            final List<String> items =
                                                (filter.dropdownList ?? [])
                                                    .cast<String>();

                                            final selected = await showDialog<List<String>>(
                                              context: context,
                                              builder: (_) {
                                                final tempSelection =
                                                    selectedList.toSet().obs;
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  title: Text(
                                                    "Select ${filter.filterLabel ?? ''}",
                                                  ),
                                                  titleTextStyle: MyTexts
                                                      .medium14
                                                      .copyWith(
                                                        color: MyColors.primary,
                                                        fontFamily:
                                                            MyTexts.SpaceGrotesk,
                                                      ),
                                                  content: Obx(
                                                    () => SingleChildScrollView(
                                                      child: Column(
                                                        children: items.map((
                                                          item,
                                                        ) {
                                                          final isSelected =
                                                              tempSelection
                                                                  .contains(
                                                                    item,
                                                                  );
                                                          return CheckboxListTile(
                                                            title: Text(item),
                                                            value: isSelected,
                                                            onChanged: (checked) {
                                                              if (checked ==
                                                                  true) {
                                                                tempSelection
                                                                    .add(item);
                                                              } else {
                                                                tempSelection
                                                                    .remove(
                                                                      item,
                                                                    );
                                                              }
                                                            },
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Get.back(
                                                        result: tempSelection
                                                            .toList(),
                                                      ),
                                                      child: const Text("OK"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (selected != null) {
                                              selectedList.assignAll(selected);
                                              controller
                                                  .dynamicControllers[filter
                                                      .filterName]
                                                  ?.text = selected.join(
                                                ', ',
                                              );

                                              // 🧠 Validation: clear error if at least one item selected
                                              if (selectedList.isNotEmpty) {
                                                errorText.value = '';
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: errorText.isNotEmpty
                                                    ? Colors.red
                                                    : MyColors.grey.withOpacity(
                                                        0.4,
                                                      ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    selectedList.isEmpty
                                                        ? "Select ${filter.filterLabel ?? ''}"
                                                        : selectedList.join(
                                                            ', ',
                                                          ),
                                                    style: selectedList.isEmpty
                                                        ? MyTexts.regular16
                                                              .copyWith(
                                                                color: MyColors
                                                                    .primary
                                                                    .withOpacity(
                                                                      0.5,
                                                                    ),
                                                                fontFamily:
                                                                    MyTexts
                                                                        .SpaceGrotesk,
                                                              )
                                                        : MyTexts.medium16
                                                              .copyWith(
                                                                color: MyColors
                                                                    .primary,
                                                                fontFamily:
                                                                    MyTexts
                                                                        .SpaceGrotesk,
                                                              ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (errorText.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4,
                                              left: 8,
                                            ),
                                            child: Text(
                                              errorText.value,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }

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

                              return Padding(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: CommonTextField(
                                  headerText: filter.filterLabel ?? '',
                                  hintText: "Enter ${filter.filterLabel ?? ''}",
                                  controller: controllerField,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter a value";
                                    }
                                    return null;
                                  },
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
                          child: RoundedButton(
                            buttonName: 'SUBMIT',
                            onTap: () {
                              hideKeyboard();

                              if (!formKey1.currentState!.validate()) {
                                SnackBars.errorSnackBar(
                                  content:
                                      "Please fill all required fields properly",
                                );
                                return;
                              }

                              bool allValid = true;

                              controller.multiDropdownValues.forEach((
                                key,
                                list,
                              ) {
                                if (list.isEmpty) {
                                  allValid = false;
                                  SnackBars.errorSnackBar(
                                    content:
                                        "Please select at least one value for $key",
                                  );
                                }
                              });

                              if (!allValid) return;

                              controller.submitProduct(formKey1);
                            },
                          ),
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
