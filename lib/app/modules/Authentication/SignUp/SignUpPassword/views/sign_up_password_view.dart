import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/controllers/sign_up_password_controller.dart';

class SignUpPasswordView extends GetView<SignUpPasswordController> {
  SignUpPasswordView({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Form(
          key: formKey,
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
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Password
                          Obx(() {
                            return CommonTextField(
                              textInputAction: TextInputAction.done,
                              headerText: "Password",
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              validator: validatePassword,
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
                                  style: MyTexts.light14.copyWith(
                                    color: MyColors.warning,
                                  ),
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
                              validator: (value) => validateConfirmPassword(
                                value,
                                controller.passwordController.text,
                              ),

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
                              buttonName:  'SUBMIT',
                              onTap: controller.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller.completeSignUp();
                                      }
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
        ),
      ),
    );
  }
}
