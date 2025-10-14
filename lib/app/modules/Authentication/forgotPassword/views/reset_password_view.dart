import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:gap/gap.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final controller = Get.find<ForgotPasswordController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: const Text("Reset password"),
            isCenter: false,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: "Submit",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  controller.resetPassword();
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(20),
                  Obx(() {
                    return CommonTextField(
                      validator: validatePassword,
                      // validator: ,
                      textInputAction: TextInputAction.next,
                      headerText: "New Password",
                      controller: controller.newPasswordController,
                      obscureText: !controller.isNewPasswordVisible.value,
                      hintText: "Eg: one uppercase, one number and lowercase",
                      showDivider: true,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.toggleNewPasswordVisibility(),
                        child: Icon(
                          controller.isNewPasswordVisible.value
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
                        controller.newPasswordController.text,
                      ),
                      textInputAction: TextInputAction.done,
                      headerText: "Confirm Password",
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      hintText: "Eg: one uppercase, one number and lowercase",
                      showDivider: true,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.toggleConfirmPasswordVisibility(),
                        child: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: MyColors.primary,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
