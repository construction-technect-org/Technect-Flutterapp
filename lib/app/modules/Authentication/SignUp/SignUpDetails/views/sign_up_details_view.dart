import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';

class SignUpDetailsView extends GetView<SignUpDetailsController> {
  SignUpDetailsView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: CommonAppBar(title: const Text("SIGN UP"), isCenter: false),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.sw),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 2.h),
                const StepperWidget(currentStep: 1),
                SizedBox(height: 3.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your Basic Details',
                          style: MyTexts.medium18.copyWith(
                            color: MyColors.lightBlue,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        SizedBox(height: 2.5.h),
                        CommonTextField(
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
                          onFocusChange: (hasFocus) async {
                            if (!hasFocus) {
                              final email = controller.emailController.text.trim();

                              // Only check if email has value and valid format
                              if (email.isNotEmpty && controller.isValidEmail(email)) {
                                final isAvailable =
                                await controller.signUpService.checkEmail(email: email);

                                if (!isAvailable) {
                                  SnackBars.errorSnackBar(
                                      content: "This email is already registered");
                                }
                              } else if (email.isNotEmpty && !controller.isValidEmail(email)) {
                                SnackBars.errorSnackBar(content: "Please enter a valid email address");
                              }
                            }
                          },
                          child: CommonTextField(
                            headerText: "Email ID",
                            hintText: "Enter your email address",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                              EmailInputFormatter(),
                            ],
                            validator: validateEmail,
                          ),
                        ),


                        SizedBox(height: 1.8.h),
                        CommonTextField(
                          isRed: false,
                          headerText: "GSTIN (optional)",
                          hintText: "xxxxxxxxxxxxxx",
                          controller: controller.gstController,
                        ),
                        SizedBox(height: 1.8.h),
                        CommonPhoneField(
                          suffix: Obx(() {
                            if (!controller.otpSend.value) {
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (controller.otpSend.value) {
                                      await controller.resendOtp().then((val) {
                                        controller.startTimer();
                                      });
                                    } else {
                                      controller.verifyMobileNumber();
                                      controller.startTimer();
                                    }
                                  },
                                  child: Container(
                                    width: 90,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: MyColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          controller.otpSend.value
                                              ? "Resend"
                                              : 'Verify',
                                          style: MyTexts.medium16.copyWith(
                                            color: MyColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (!controller.isResendVisible.value) {
                              return const SizedBox.shrink();
                            } else {
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (controller.otpSend.value) {
                                      await controller.resendOtp().then((val) {
                                        controller.startTimer();
                                      });
                                    } else {
                                      controller.verifyMobileNumber();
                                      controller.startTimer();
                                    }
                                  },
                                  child: Container(
                                    width: 90,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: MyColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          controller.otpSend.value
                                              ? "Resend"
                                              : 'Verify',
                                          style: MyTexts.medium16.copyWith(
                                            color: MyColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                          headerText: "Mobile Number",
                          controller: controller.mobileNumberController,
                          focusNode: FocusNode(),
                          isValid: controller.isValid,
                          onCountryCodeChanged: (code) {
                            controller.countryCode.value = code;
                          },
                        ),
                        SizedBox(height: 1.8.h),
                        // OTP Field
                        Obx(() {
                          if (controller.otpSend.value == false) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Enter OTP',
                                    style: MyTexts.regular16.copyWith(
                                      color: MyColors.lightBlue,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: MyTexts.regular16.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                              PinCodeTextField(
                                appContext: context,
                                length: 4,
                                controller: controller.otpController,
                                onChanged: (value) {
                                  controller.otp.value = value;
                                },
                                onCompleted: (value) {
                                  controller.otp.value = value;
                                },
                                keyboardType: TextInputType.number,
                                textStyle: MyTexts.extraBold16.copyWith(
                                  color: MyColors.primary,
                                ),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(12),
                                  borderWidth: 0.5,
                                  fieldHeight: 57,
                                  fieldWidth: 57,
                                  activeFillColor: MyColors.white,
                                  inactiveFillColor: MyColors.white,
                                  selectedFillColor: MyColors.white,
                                  activeColor: MyColors.primary,
                                  inactiveColor: MyColors.textFieldBorder,
                                  selectedColor: MyColors.primary,
                                ),
                                enableActiveFill: true,
                                animationType: AnimationType.fade,
                              ),
                              Obx(() {
                                return !controller.otpSend.value
                                    ? const SizedBox()
                                    : Align(
                                        alignment: Alignment.bottomRight,
                                        child: Countdown(
                                          controller:
                                              controller.countdownController,
                                          seconds: 30,
                                          interval: const Duration(
                                            milliseconds: 100,
                                          ),
                                          build: (_, double time) {
                                            return Text(
                                              "Resend in 00:${time.ceil().toString().padLeft(2, '0')}",
                                              style: MyTexts.bold16.copyWith(
                                                color: MyColors.green,
                                              ),
                                            );
                                          },
                                          onFinished: () {
                                            controller.onCountdownFinish();
                                          },
                                        ),
                                      );
                              }),
                            ],
                          );
                        }),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'PROCEED',
            onTap: () {
              hideKeyboard();
              controller.isValid.value = -1;
              if (controller.mobileNumberController.text.isEmpty) {
                controller.isValid.value = 0;
              }
              if (formKey.currentState!.validate()) {
                if (controller.otpController.text.isEmpty) {
                  SnackBars.errorSnackBar(content: "Please enter OTP");
                  return;
                }
                if (controller.mobileNumberController.text.isEmpty) {
                  controller.isValid.value = 0;
                } else {
                  controller.proceedToPassword();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
