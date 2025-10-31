import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/controllers/add_requirement_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class AddRequirementView extends StatelessWidget {
  AddRequirementView({super.key});

  final controller = Get.put(AddRequirementController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            title: Text(
              controller.requirementId != null
                  ? "Edit requirement"
                  : "Add requirement",
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: RoundedButton(
                  buttonName: controller.requirementId != null
                      ? 'Update'
                      : 'Submit',
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.submitRequirement();
                    } else {
                      SnackBars.errorSnackBar(
                        content: "Please fill all required fields properly",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonDropdown<String>(
                    headerText: 'Main Category',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please select a main category";
                      }
                      return null;
                    },
                    hintText: "Select product main category",
                    items: controller.mainCategoryNames,
                    selectedValue: controller.selectedMainCategory,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      controller.onMainCategorySelected(value);
                    },
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
                    hintText: "Select product sub-category",
                    items: controller.subCategoryNames,
                    selectedValue: controller.selectedSubCategory,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      controller.onSubCategorySelected(value);
                    },
                  ),
                  SizedBox(height: 2.h),
                  Obx(() {
                    if (controller.productCategoryNames.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropdown<String>(
                            headerText: 'Product Category',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select product category";
                              }
                              return null;
                            },
                            hintText: "Select Product Category",
                            items: controller.productCategoryNames,
                            selectedValue: controller.selectedProductCategory,
                            itemLabel: (item) => item,
                            onChanged: (val) {
                              controller.onProductCategorySelected(val);
                            },
                          ),
                          SizedBox(height: 2.h),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Obx(() {
                    if (controller.subProductCategoryNames.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropdown<String>(
                            headerText: 'Sub Product Category',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select sub product category";
                              }
                              return null;
                            },
                            hintText: "Select Sub Product Category",
                            items: controller.subProductCategoryNames,
                            selectedValue:
                                controller.selectedSubProductCategory,
                            itemLabel: (item) => item,
                            onChanged: (val) {
                              controller.onSubProductCategorySelected(val);
                            },
                          ),
                          SizedBox(height: 2.h),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  CommonDropdown<SiteLocation>(
                    headerText: 'Site Address',
                    validator: (val) {
                      if (val == null) {
                        return "Please select site address";
                      }
                      return null;
                    },
                    hintText: "Select site address",
                    items: controller.siteLocations,
                    selectedValue: controller.selectedSiteAddress,
                    itemLabel: (item) => item.siteName ?? 'No site name',
                    onChanged: (val) {
                      controller.selectSiteAddress(val);
                    },
                  ),
                  SizedBox(height: 2.h),
                  CommonTextField(
                    headerText: 'Quantity',
                    hintText: "Enter quantity",
                    controller: controller.quantityController,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter quantity";
                      }
                      if (double.tryParse(val) == null) {
                        return "Enter valid number";
                      }
                      if (int.tryParse(val) == 0) {
                        return "Quantity can not be zero";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  Obx(() {
                    if (controller.uomOptions.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropdown<String>(
                            headerText:
                                controller.uomFilter?.filterLabel ?? 'UOM',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select ${controller.uomFilter?.filterLabel ?? 'UOM'}";
                              }
                              return null;
                            },
                            hintText:
                                "Select ${controller.uomFilter?.filterLabel ?? 'UOM'}",
                            items: controller.uomOptions,
                            selectedValue: controller.selectedUOM,
                            itemLabel: (item) => item,
                            onChanged: (val) {
                              controller.selectedUOM.value = val;
                            },
                          ),
                          SizedBox(height: 2.h),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  CommonTextField(
                    headerText: 'Estimate Delivery Date',
                    hintText: "Select estimate delivery date",
                    controller: controller.estimateDeliveryDateController,
                    readOnly: true,
                    onTap: () => controller.selectEstimateDeliveryDate(context),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please select estimate delivery date";
                      }
                      return null;
                    },
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  SizedBox(height: 2.h),
                  CommonTextField(
                    headerText: 'Note',
                    hintText: "Write a note",
                    maxLine: 4,
                    controller: controller.noteController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Please enter note";
                      }
                      if (!RegExp('[a-zA-Z0-9]').hasMatch(val.trim())) {
                        return "Note must contain at least one letter or number";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
