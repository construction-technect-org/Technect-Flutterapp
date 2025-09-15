import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/stepper_widget_add_product.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddService/controllers/add_service_controller.dart';

class AddServiceView extends GetView<AddServiceController> {
  const AddServiceView({super.key});

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
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            leading: InkWell(
              onTap: () {
                if (controller.pageController.page == 0) {
                  Get.back();
                } else {
                  controller.pageController.jumpToPage(0);
                }
              },
              child: const Icon(Icons.arrow_back_rounded, size: 24, color: Colors.black),
            ),
            titleSpacing: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.isEdit ? "EDIT SERVICE" : "ADD SERVICE",
                  style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                ),
                const SizedBox(height: 2),
                Text(
                  "Enter Service Details",
                  style: MyTexts.medium14.copyWith(color: MyColors.shadeOfGray),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // ------------------- PAGE 1 -------------------
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
                          "Service Image",
                          style: MyTexts.regular18.copyWith(color: MyColors.lightBlue),
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
                                          borderRadius: BorderRadius.circular(8),
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
                                        ? "Upload Service Image"
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
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Service Name',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(controller: controller.serviceNameController),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Service Type',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          if (!controller.isEdit)
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          if (controller.isEdit) ...[
                            const SizedBox(width: 8),
                            Text(
                              '(Read Only)',
                              style: MyTexts.light12.copyWith(color: MyColors.grey),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        items: controller.serviceTypeNames,
                        selectedValue: controller.selectedServiceType,
                        onChanged: controller.isEdit
                            ? null
                            : controller.onServiceTypeSelected,
                        hintText: 'Select Service Type',
                        itemLabel: (item) => item,
                        enabled: !controller.isEdit,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Service',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          if (!controller.isEdit)
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          if (controller.isEdit) ...[
                            const SizedBox(width: 8),
                            Text(
                              '(Read Only)',
                              style: MyTexts.light12.copyWith(color: MyColors.grey),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        items: controller.serviceNames,
                        selectedValue: controller.selectedService,
                        onChanged: controller.isEdit
                            ? null
                            : controller.onServiceSelected,
                        itemLabel: (item) => item,
                        hintText: 'Select Service',
                        enabled: !controller.isEdit,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'UOM',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CommonDropdown<String>(
                        itemLabel: (item) => item,
                        items: controller.uomList,
                        selectedValue: controller.selectedUom,
                        onChanged: controller.onUomSelected,
                        hintText: 'Select UOM',
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller: controller.priceController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.gstCalculate();
                        },
                      ),
                      SizedBox(height: 2.h),
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
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.gstCalculate();
                        },
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'GST Price',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller: controller.gstPriceController,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller: controller.termsController,
                        maxLines: 3,
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: RoundedButton(
                          buttonName: 'PROCEED',
                          onTap: () async {
                            if (await controller.firstPartValidation()) {
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
                      Row(
                        children: [
                          Text(
                            'Description',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller: controller.descriptionController,
                        maxLines: 8,
                        hintText: 'Enter service description...',
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: Obx(
                          () => RoundedButton(
                            buttonName: 'SUBMIT',
                            onTap: controller.isLoading.value
                                ? null
                                : controller.createServiceValidation,
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
