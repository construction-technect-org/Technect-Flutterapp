import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Asset.bricksBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 50),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(43),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 4.h),
                          Text(
                            'FORGOT PASSWORD',
                            style: MyTexts.medium20.copyWith(
                              color: Colors.black,
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          CommonPhoneField(
                            
                            suffix: Obx(() {
                              if (!controller.otpSend.value) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (controller.otpSend.value) {
                                        await controller.sendOtp().then((val) {
                                          controller.startTimer();
                                        });
                                      } else {
                                        controller.sendOtp();
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
                                return const SizedBox();
                              } else {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (controller.otpSend.value) {
                                        await controller.sendOtp().then((val) {
                                          controller.startTimer();
                                        });
                                      } else {
                                        controller.sendOtp();
                                        controller.otpSend.value = true;
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
                            controller: controller.phoneEmailController,
                            focusNode: FocusNode(),
                            isValid: controller.isValid,
                            onCountryCodeChanged: (code) {
                              controller.countryCode.value = code;
                            },
                          ),
                          SizedBox(height: 2.h),
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
                              ],
                            );
                          }),
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
                          SizedBox(height: 1.h),
                          // New Password
                          Obx(() {
                            return CommonTextField(
                              validator: validatePassword,
                              // validator: ,
                              textInputAction: TextInputAction.next,
                              headerText: "Password",
                              controller: controller.newPasswordController,
                              obscureText:
                                  !controller.isNewPasswordVisible.value,
                              hintText: "Enter the password",
                              showDivider: true,
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    controller.toggleNewPasswordVisibility(),
                                child: Icon(
                                  controller.isNewPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: MyColors.primary,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                size: 16,
                                color: MyColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Eg: one uppercase, one number and lowercase',
                                  style: MyTexts.light14.copyWith(
                                    color: MyColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.8.h),
                          Obx(() {
                            return CommonTextField(
                              validator: (val) => validateConfirmPassword(
                                val,
                                controller.newPassword.string,
                              ),
                              textInputAction: TextInputAction.done,
                              headerText: "Confirm Password",
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  !controller.isConfirmPasswordVisible.value,
                              hintText: "Re-enter the password",
                              showDivider: true,
                              suffixIcon: GestureDetector(
                                onTap: () => controller
                                    .toggleConfirmPasswordVisibility(),
                                child: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: MyColors.primary,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 4.sh),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: RoundedButton(
                buttonName: 'RESET MY PASSWORD',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    controller.resetPassword();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
