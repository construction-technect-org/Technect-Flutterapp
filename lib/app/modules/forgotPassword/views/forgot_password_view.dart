import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.bricksBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(43)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 4.h),
                        Text('FORGOT PASSWORD', style: MyTexts.light22),
                        SizedBox(height: 2.h),
                        // Phone Number / Email
                        Row(
                          children: [
                            Text(
                              'Phone Number / Email',
                              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                            ),
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        CustomTextField(
                          controller: controller.phoneEmailController,
                          suffix: Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                controller.sendOtp();
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: MyColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Obx(
                                    () => Text(
                                      controller.otpSend.value ? "Resend" : 'Verify',
                                      style: MyTexts.medium16.copyWith(
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Enter OTP',
                              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                            ),
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
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
                        SizedBox(height: 2.h),
                        // New Password
                        Row(
                          children: [
                            Text(
                              'New Password',
                              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                            ),
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.textFieldBorder),
                            color: MyColors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => TextField(
                                    controller: controller.newPasswordController,
                                    obscureText: !controller.isNewPasswordVisible.value,
                                    style: MyTexts.extraBold16.copyWith(
                                      color: MyColors.primary,
                                      height: 36 / 16,
                                    ),
                                    cursorHeight: 20,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ),
                              // Eye icon
                              GestureDetector(
                                onTap: () {
                                  controller.toggleNewPasswordVisibility();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: SvgPicture.asset(
                                    Asset.eyeIcon,
                                    width: 18,
                                    height: 18,
                                    colorFilter: const ColorFilter.mode(
                                      MyColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        // Confirm Password
                        Row(
                          children: [
                            Text(
                              'Confirm Password',
                              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                            ),
                            Text(
                              '*',
                              style: MyTexts.light16.copyWith(color: MyColors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.textFieldBorder),
                            color: MyColors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => TextField(
                                    controller: controller.confirmPasswordController,
                                    obscureText:
                                        !controller.isConfirmPasswordVisible.value,
                                    style: MyTexts.extraBold16.copyWith(
                                      color: MyColors.primary,
                                      height: 36 / 16,
                                    ),
                                    cursorHeight: 20,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.toggleConfirmPasswordVisibility();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: SvgPicture.asset(
                                    Asset.eyeIcon,
                                    width: 18,
                                    height: 18,
                                    colorFilter: const ColorFilter.mode(
                                      MyColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        RoundedButton(
                          buttonName: 'RESET MY PASSWORD',
                          onTap: () {
                            controller.resetPassword();
                          },
                        ),
                        SizedBox(height: 4.sh),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
