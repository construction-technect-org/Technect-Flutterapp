import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';

class SignUpDetailsView extends GetView<SignUpDetailsController> {
  SignUpDetailsView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.loginBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text("Sign up"),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter your Details',
                              style: MyTexts.medium20.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Lets start with the basics first',
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            CommonTextField(
                              isRed: true,
                              headerText: "First Name",
                              hintText: "Enter your first name",
                              controller: controller.firstNameController,
                              autofillHints: const [AutofillHints.givenName],
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                NameInputFormatter(),
                              ],
                              validator: (value) =>
                                  validateName(value, fieldName: "first name"),
                            ),

                            SizedBox(height: 1.8.h),

                            CommonTextField(
                              headerText: "Last Name",
                              isRed: true,

                              hintText: "Enter your last name",
                              controller: controller.lastNameController,
                              autofillHints: const [AutofillHints.familyName],
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                NameInputFormatter(),
                              ],
                              validator: (value) =>
                                  validateName(value, fieldName: "last name"),
                            ),
                            SizedBox(height: 1.8.h),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  final email = controller.emailController.text;
                                  controller.validateEmailAvailability(email);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextField(
                                    headerText: "Email ID",
                                    hintText: "Enter your email address",
                                    isRed: true,

                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: const [AutofillHints.email],
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(254),
                                      EmailInputFormatter(),
                                    ],
                                    validator: (value) =>
                                        Validate.validateEmail(value),
                                    onChange: (value) {
                                      controller.emailError.value = "";
                                    },
                                    onFieldSubmitted: (value) {
                                      if (value != null) {
                                        controller.validateEmailAvailability(
                                          value,
                                        );
                                      }
                                    },
                                  ),
                                  Obx(() {
                                    if (controller
                                        .emailError
                                        .value
                                        .isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          controller.emailError.value,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                ],
                              ),
                            ),

                            SizedBox(height: 1.8.h),
                            Obx(() {
                              final role = Get.find<SignUpRoleController>()
                                  .selectedRoleName
                                  .value;
                              if (role == "House-Owner") {
                                return CommonTextField(
                                  headerText: "KYC",
                                  hintText: "Enter your Aadhaar card",
                                  controller: controller.aadhaarController,
                                  suffixPadding: 0,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      final value = controller
                                          .aadhaarController
                                          .text
                                          .trim();
                                      if (value.isEmpty) {
                                        SnackBars.errorSnackBar(
                                          content:
                                              "Please enter Aadhaar number",
                                        );
                                        controller.isVerified.value = false;
                                        return;
                                      } else if (value.length != 12) {
                                        SnackBars.errorSnackBar(
                                          content:
                                              "Aadhaar number must be exactly 12 digits",
                                        );
                                        controller.isVerified.value = false;
                                        return;
                                      }
                                      controller.isVerified.value = true;
                                      SnackBars.successSnackBar(
                                        content:
                                            "Aadhaar verified successfully!",
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: MyColors.primary,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Verify",
                                          style: MyTexts.medium16.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter Aadhaar number";
                                    }
                                    if (value.trim().length != 12) {
                                      return "Aadhaar number must be exactly 12 digits";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                );
                              }
                              return CommonTextField(
                                headerText: "GSTIN",
                                hintText: "Enter your GSTIN number",
                                controller: controller.gstController,
                                isRed: true,
                                suffixPadding: 0,
                                suffixIcon: GestureDetector(
                                  onTap: () async => await controller
                                      .validateGSTAvailability(),
                                  child: Container(
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: MyColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Verify",
                                        style: MyTexts.medium16.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter GSTIN number";
                                  }
                                  if (value.trim().length != 15) {
                                    return "GSTIN number must be exactly 15 characters";
                                  }
                                  if (!RegExp(
                                    r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$',
                                  ).hasMatch(value.trim())) {
                                    return "Please enter a valid GSTIN number";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  LengthLimitingTextInputFormatter(15),
                                ],
                              );
                            }),
                            SizedBox(height: 2.h),
                            Obx(() {
                              if (!controller.isVerified.value) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.grayE6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: MyColors.grayE6,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: AlignmentGeometry.topLeft,
                                        child: Text(
                                          SignUpRoleController
                                                      .to
                                                      .selectedRoleName
                                                      .value ==
                                                  "House-Owner"
                                              ? "Aadhaar card details"
                                              : "Company details",
                                          style: MyTexts.medium13.copyWith(
                                            color: MyColors.gray2E,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (SignUpRoleController
                                                  .to
                                                  .selectedRoleName
                                                  .value ==
                                              "House-Owner") ...[
                                            Text(
                                              "Aadhaar number ",
                                              style: MyTexts.medium13.copyWith(
                                                color: MyColors.dustyGray,
                                              ),
                                            ),
                                            const Gap(4),
                                            Text(
                                              controller.aadhaarController.text,
                                              style: MyTexts.medium16.copyWith(
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ] else ...[
                                            Text(
                                              "Company name ",
                                              style: MyTexts.medium13.copyWith(
                                                color: MyColors.dustyGray,
                                              ),
                                            ),
                                            const Gap(4),
                                            Text(
                                              "XYZ Company",
                                              style: MyTexts.medium16.copyWith(
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ],
                                          const Gap(12),
                                          Text(
                                            "Address",
                                            style: MyTexts.medium13.copyWith(
                                              color: MyColors.dustyGray,
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            "Flat No. 305, Block B, Prestige Lakeview Apartments",
                                            style: MyTexts.medium16.copyWith(
                                              color: MyColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'Continue',
            onTap: () async {
              hideKeyboard();
              if (!formKey.currentState!.validate()) return;

              // Run async availability check when email is provided and format is valid
              if (controller.emailController.text.trim().isNotEmpty) {
                await controller.validateEmailAvailability(
                  controller.emailController.text,
                );
              }

              // Block on availability error
              if (controller.emailError.value.isNotEmpty) {
                SnackBars.errorSnackBar(content: controller.emailError.value);
                return;
              }

              if (controller.isVerified.value) {
                controller.openPhoneNumberBottomSheet();
              } else {
                final String text =
                    Get.find<SignUpRoleController>().selectedRoleName.value ==
                        "House-Owner"
                    ? "aadhaar number first"
                    : "GSTIN number";
                SnackBars.errorSnackBar(content: "Please verify $text");
              }
            },
          ),
        ),
      ),
    );
  }
}
