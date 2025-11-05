import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/AddServiceRequirement/controllers/add_service_requirement_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class AddServiceRequirementView extends StatelessWidget {
  AddServiceRequirementView({super.key});

  final controller = Get.put(AddServiceRequirementController());

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
              controller.serviceRequirementId != null
                  ? "Edit Service Requirement"
                  : "Add Service Requirement",
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
                  buttonName: controller.serviceRequirementId != null
                      ? 'Update'
                      : 'Submit',
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.submitServiceRequirement();
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
                    hintText: "Select service main category",
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
                    hintText: "Select service sub-category",
                    items: controller.subCategoryNames,
                    selectedValue: controller.selectedSubCategory,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      controller.onSubCategorySelected(value);
                    },
                  ),
                  SizedBox(height: 2.h),
                  Obx(() {
                    if (controller.serviceCategoryNames.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropdown<String>(
                            headerText: 'Service Category',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select service category";
                              }
                              return null;
                            },
                            hintText: "Select Service Category",
                            items: controller.serviceCategoryNames,
                            selectedValue: controller.selectedServiceCategory,
                            itemLabel: (item) => item,
                            onChanged: (val) {
                              controller.onServiceCategorySelected(val);
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
                    headerText: 'Estimate Start Date',
                    hintText: "Select estimate start date",
                    controller: controller.estimateStartDateController,
                    readOnly: true,
                    onTap: () => controller.selectEstimateStartDate(context),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please select estimate start date";
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
