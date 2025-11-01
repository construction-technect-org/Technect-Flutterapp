import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/google_sign_in_service.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/widget/save_pass_widget.dart';
import 'package:construction_technect/app/modules/Authentication/login/controllers/login_controller.dart';
import 'package:gap/gap.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.loginBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.sw),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(50),
                        Container(
                          height: 193,
                          width: 234,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Asset.auth),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Center(
                          child: Text(
                            'India’s Fastest Growing\nConstruction Network',
                            style: MyTexts.medium18.copyWith(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(24),
                        Align(
                          alignment: AlignmentGeometry.topLeft,
                          child: Text(
                            'Login',
                            style: MyTexts.medium20.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Gap(16),
                        CommonPhoneField(
                          headerText: "Mobile Number",
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          isValid: controller.isValid,
                          onCountryCodeChanged: (code) {
                            controller.countryCode.value = code;
                          },
                          onSubmitted: (val) {
                            FocusScope.of(
                              context,
                            ).requestFocus(controller.passwordFocusNode);
                          },
                        ),
                        const Gap(16),
                        Obx(() {
                          return CommonTextField(
                            textInputAction: TextInputAction.done,
                            headerText: "Password",
                            focusNode: controller.passwordFocusNode,
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            // controlled from your controller
                            hintText: "Password",
                            validator: (val) {
                              if ((val ?? "").isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
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
                        Obx(() {
                          if (controller.loginError.value.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.loginError.value,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Remember Me
                            SavePassWidget(
                              state: controller.rememberMe,
                              onChanged: (val) =>
                                  controller.rememberMe.value = val,
                            ),
                            //Forgot Password
                            TextButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.FORGOT_PASSWORD),
                              child: Text(
                                'Forgot Password?',
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.gra54,
                                  decoration: TextDecoration.underline,
                                  decorationColor: MyColors.gra54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
                        Obx(
                          () => RoundedButton(
                            buttonName: 'Login',
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    controller.isValid.value = -1;
                                    if (controller
                                        .mobileController
                                        .text
                                        .isEmpty) {
                                      controller.isValid.value = 0;
                                    }
                                    if (controller.formKey.currentState
                                            ?.validate() ??
                                        false) {
                                      if (controller
                                          .mobileController
                                          .text
                                          .isEmpty) {
                                        controller.isValid.value = 0;
                                      } else {
                                        hideKeyboard();
                                        controller.login();
                                      }
                                    }
                                  },
                          ),
                        ),
                        const Gap(24),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: MyColors.grayD4,
                                indent: 10.sw,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Text(
                                'Or',
                                style: MyTexts.medium13.copyWith(
                                  color: MyColors.greySecond,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: MyColors.grayD4,
                                endIndent: 10.sw,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyColors.grayD4),
                                ),
                                height: 4.sh,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(Asset.googleIcon),
                                ),
                              ),
                              onTap: () async {
                                try {
                                  final user =
                                      await GoogleSignInService.signInWithGoogle();
                                  if (user != null) {
                                    await controller.callSocialLoginAPI(user);
                                  } else {
                                    SnackBars.errorSnackBar(
                                      content:
                                          'Google Sign-In was cancelled by user',
                                    );
                                  }
                                } catch (e) {
                                  SnackBars.errorSnackBar(
                                    content: 'Google Sign-In failed: $e',
                                  );
                                }
                              },
                            ),
                            SizedBox(width: 10.sw),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyColors.grayD4),
                                ),
                                height: 4.sh,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(Asset.facebookIcon),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const Gap(24),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SIGN_UP_ROLE);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: MyTexts.regular16.copyWith(
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                              Text(
                                "Sign-up",
                                style: MyTexts.bold16.copyWith(
                                  color: MyColors.primary,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(32),
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
