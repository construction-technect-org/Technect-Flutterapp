import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddLocationManually/controller/add_location_manually_controller.dart';
import 'package:flutter/services.dart';

class AddLocationManuallyView extends GetView<AddLocationController> {
  const AddLocationManuallyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => controller.locationAdded.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Asset.locationComplete,
                        ).paddingSymmetric(horizontal: 20),
                        SizedBox(height: 2.h),
                        Text(
                          "Location Connected!",
                          style: MyTexts.bold20.copyWith(
                            color: MyColors.textFieldBackground,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Your location is successfully connected.",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.grey1,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              borderRadius: BorderRadius.circular(50),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 0.8.h),
                            Obx(
                              () => Text(
                                controller.isEditing.value
                                    ? "Edit Location"
                                    : "Add Location Manually",
                                style: MyTexts.medium18.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.4.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Select your location for better tracking",
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.shadeOfGray,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Text(
                              'Address Line 1',
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
                        CustomTextField(
                          controller: controller.addressLine1Controller,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Address Line 2',
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
                        CustomTextField(
                          controller: controller.addressLine2Controller,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Landmark',
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
                        CustomTextField(
                          controller: controller.landmarkController,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'City',
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
                        CustomTextField(controller: controller.cityController),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'State',
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
                        CustomTextField(controller: controller.stateController),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Pin Code',
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
                        CustomTextField(
                          controller: controller.pinCodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                        ),
                        const Spacer(),
                        Obx(
                          () => RoundedButton(
                            buttonName: controller.isLoading.value
                                ? 'SUBMITTING...'
                                : 'SUBMIT',
                            onTap: controller.isLoading.value
                                ? null
                                : () => controller.submitLocation(),
                          ),
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
