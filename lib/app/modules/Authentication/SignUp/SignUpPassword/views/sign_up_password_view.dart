import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: RoundedButton(
                buttonName: 'SUBMIT',
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          controller.completeSignUp();
                        }
                      },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Text(
                            'Set Password',
                            style: MyTexts.medium20.copyWith(
                              color: MyColors.primary,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Obx(() {
                            return CommonTextField(
                              validator: validatePassword,
                              textInputAction: TextInputAction.next,
                              headerText: "New Password",
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              hintText:
                                  "Eg: one uppercase, one number and lowercase",
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
                          SizedBox(height: 2.h),
                          Obx(() {
                            return CommonTextField(
                              validator: (val) => validateConfirmPassword(
                                val,
                                controller.passwordController.text,
                              ),
                              textInputAction: TextInputAction.done,
                              headerText: "Confirm Password",
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  !controller.isConfirmPasswordVisible.value,
                              hintText:
                                  "Eg: one uppercase, one number and lowercase",
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
                          SizedBox(height: 5.h),
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
