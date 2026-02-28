import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/otp_verification_view.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.loginBg), fit: BoxFit.cover),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.sw),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonAppBar(
                        backgroundColor: Colors.transparent,
                        title: const Text("Forgot password"),
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

                      const Gap(24),
                      CommonPhoneField(
                        headerText: "Enter Your Mobile Number",
                        controller: controller.phoneEmailController,
                        focusNode: FocusNode(),
                        isValid: controller.isValid,
                        isRed: true,
                        onTap: () async {
                          await controller.getPhoneNumber();
                        },
                        customErrorMessage: controller.mobileValidationError,
                        onCountryCodeChanged: (code) {
                          controller.countryCode.value = code;
                        },
                      ),
                      const Gap(24),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            final email = controller.emailController.text;
                            // Only validate availability if format is valid
                            final formatError = Validate.validateEmail(email);
                            if (formatError == null) {
                              controller.validateEmailAvailability(email);
                            } else {
                              // Format error - clear API error, validator will show format error
                              controller.emailError.value = "";
                            }
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              focusNode: controller.emailFocusNode,
                              headerText: "Enter your email address",
                              hintText: "Enter your email address",
                              isRed: true,
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.gra54,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(254),
                                EmailInputFormatter(),
                              ],
                              validator: (value) => Validate.validateEmail(value),
                              onChange: (value) {
                                controller.emailError.value = "";
                              },
                              onFieldSubmitted: (value) {
                                if (value != null) {
                                  // Only validate availability if format is valid
                                  final formatError = Validate.validateEmail(value);
                                  if (formatError == null) {
                                    controller.validateEmailAvailability(value);
                                  } else {
                                    // Format error - clear API error, validator will show format error
                                    controller.emailError.value = "";
                                  }
                                }
                              },
                            ),
                            Obx(() {
                              if (controller.emailError.value.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.emailError.value,
                                    style: MyTexts.medium13.copyWith(color: MyColors.red33),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: 'Request otp',
              onTap: () async {
                //if (!formKey.currentState!.validate()) return;
                if (controller.mobileValidationError.isNotEmpty ||
                    controller.mobileValidationError.value != '') {
                  return;
                }
                if (controller.emailError.value.isNotEmpty) {
                  SnackBars.errorSnackBar(content: controller.emailError.value);
                  return;
                }
                controller.isValid.value = -1;
                if (controller.phoneEmailController.text.isEmpty) {
                  controller.isValid.value = 0;
                }
                if (formKey.currentState!.validate()) {
                  if (controller.phoneEmailController.text.isEmpty &&
                      controller.emailController.text.isEmpty) {
                    controller.isValid.value = 0;
                  } else {
                    await controller.sendOtp().then((val) {
                      if (controller.otpSend.value) {
                        Get.to(
                          () => OtpVerificationView(
                            isLoading: controller.isLoading,
                            onTap: () async {
                              await controller.sendOtp().then((val) {
                                controller.startTimer();
                              });
                            },
                            onCompleted: (value) {
                              controller.otpController.text = value;
                              controller.verifyOtp();
                            },
                            countdownController: controller.countdownController,
                            isResendVisible: controller.isResendVisible,
                            otpController: controller.otpController,
                            onFinished: () {
                              controller.onCountdownFinish();
                            },
                            mobileNumber:
                                "${controller.countryCode.value} ${controller.phoneEmailController.text}",
                            email: controller.emailController.text.isNotEmpty
                                ? controller.emailController.text
                                : null,
                          ),
                        );
                        controller.startTimer();
                      }
                    });
                  }

                  // controller.resetPassword();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
