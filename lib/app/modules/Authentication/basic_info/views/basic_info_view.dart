import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/modules/Authentication/basic_info/controllers/basic_info_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfoBottomSheet extends StatelessWidget {
  BasicInfoBottomSheet({super.key});

  final controller = Get.put(BasicInfoController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Drag Indicator
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Basic Info",
                  style: MyTexts.medium16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Let's start with knowing you better",
                  style: MyTexts.medium13.copyWith(
                    color: MyColors.gra54,
                  ),
                ),

                const SizedBox(height: 25),

                /// First Name
                CommonTextField(
                  headerText: "First Name",
                  hintText: "Enter first name",
                  // isRed: true,
                  controller: controller.firstNameController,
                  focusNode: controller.firstNameFocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(controller.lastNameFocus);
                  },
                ),

                const SizedBox(height: 18),

                /// Last Name
                CommonTextField(
                  headerText: "Last Name",
                  hintText: "Enter last name",
                  // isRed: true,
                  controller: controller.lastNameController,
                  focusNode: controller.lastNameFocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(controller.designationFocus);
                  },
                ),

                const SizedBox(height: 18),

                /// Designation
                CommonTextField(
                  headerText: "What's your Designation",
                  hintText: "Enter designation",
                  // isRed: true,
                  controller: controller.designationController,
                  focusNode: controller.designationFocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Designation is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                /// Continue Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isButtonEnabled.value
                          ? controller.onContinue
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        controller.isButtonEnabled.value
                            ? MyColors.primary
                            : MyColors.grey1,
                        disabledBackgroundColor: MyColors.grey1,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: MyTexts.medium14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: MyTexts.medium12.copyWith(
                      color: MyColors.gra54,
                    ),
                    children: [
                      const TextSpan(
                          text:
                          "By continuing you agree to our "),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: MyTexts.medium12.copyWith(
                          color: MyColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {},
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: MyTexts.medium12.copyWith(
                          color: MyColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {},
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