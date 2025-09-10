import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/SignUpPassword/controllers/sign_up_password_controller.dart';

class SignUpPasswordView extends GetView<SignUpPasswordController> {
  const SignUpPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // Stepper
                    const StepperWidget(currentStep: 2),
                    SizedBox(height: 2.h),
                    Text('SIGN UP', style: MyTexts.light22),
                    Text(
                      'Create Password',
                      style: MyTexts.light16.copyWith(color: MyColors.greyDetails),
                    ),
                    SizedBox(height: 2.h),
                    // Password
                    Row(
                      children: [
                        Text(
                          'Create Password',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                        Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
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
                                controller: controller.passwordController,
                                obscureText: !controller.isPasswordVisible.value,
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
                              controller.togglePasswordVisibility();
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
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 16,
                          color: MyColors.warning,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Eg: one uppercase, one number and lowercase',
                            style: MyTexts.light14.copyWith(color: MyColors.warning),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          'Confirm Password',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                        Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
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
                                obscureText: !controller.isConfirmPasswordVisible.value,
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

                    SizedBox(height: 6.h),
                    Obx(
                      () => RoundedButton(
                        buttonName: controller.isLoading.value
                            ? 'CREATING ACCOUNT...'
                            : 'SUBMIT',
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                controller.completeSignUp();
                              },
                      ),
                    ),

                    SizedBox(height: 5.sh),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
