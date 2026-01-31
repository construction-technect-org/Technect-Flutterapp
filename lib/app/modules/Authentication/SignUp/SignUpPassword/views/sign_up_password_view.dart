import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/controllers/sign_up_password_controller.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/widget/save_pass_widget.dart';

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
            backgroundColor: Colors.white,
            /* bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: RoundedButton(
                buttonName: 'Continue',
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          controller.completeSignUp();
                        }
                      },
              ),
            ),*/
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                          padding: EdgeInsets.symmetric(horizontal: 6.sw),
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
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  hintText: "Enter new password",
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
                                  controller:
                                      controller.confirmPasswordController,
                                  obscureText: !controller
                                      .isConfirmPasswordVisible
                                      .value,
                                  hintText: "Re-enter new password",
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
                              SizedBox(height: 2.h),
                              SavePassWidget(
                                state: controller.rememberMe,
                                onChanged: (val) =>
                                    controller.rememberMe.value = val,
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: RoundedButton(
                                  buttonName: 'Continue',
                                  onTap: controller.isLoading.value
                                      ? null
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.signUpComplete();
                                          }
                                        },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
