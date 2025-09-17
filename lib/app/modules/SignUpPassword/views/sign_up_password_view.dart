import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/SignUpPassword/controllers/sign_up_password_controller.dart';

class SignUpPasswordView extends GetView<SignUpPasswordController> {
  const SignUpPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: CommonAppBar(title: const Text("SIGN UP"), isCenter: false),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h),
              // Stepper
              const StepperWidget(currentStep: 2),
              SizedBox(height: 2.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Password',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.lightBlue,
                          fontFamily: MyTexts.Roboto,
                        ),                    ),
                      SizedBox(height: 2.h),
                      // Password
                      Obx(() {
                        return CommonTextField(
                          textInputAction: TextInputAction.done,
                          headerText: "Password",
                          controller: controller.passwordController,
                          obscureText:
                          !controller.isPasswordVisible.value,
                          hintText: "Enter the password",
                          showDivider: true,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.togglePasswordVisibility(),
                            child: Icon(
                              controller.isPasswordVisible.value
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
                      SizedBox(height: 1.8.h),
                      Obx(() {
                        return CommonTextField(
                          textInputAction: TextInputAction.done,
                          headerText: "Confirm Password",
                          controller: controller.confirmPasswordController,
                          obscureText:
                          !controller.isConfirmPasswordVisible.value,
                          hintText: "Re-enter the password",
                          showDivider: true,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.toggleConfirmPasswordVisibility(),
                            child: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.primary,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 5.h),
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

            ],
          ),
        ),
      ),
    );
  }
}
