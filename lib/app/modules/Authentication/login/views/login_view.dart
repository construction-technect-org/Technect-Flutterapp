import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
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
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sw),
                    child: Form(
                      key: controller.formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(30),
                            Text(
                              'LOGIN',
                              style: MyTexts.medium20.copyWith(
                                color: Colors.black,
                                fontFamily: MyTexts.SpaceGrotesk
                              ),
                            ),
                            const Gap(30),
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
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                // controlled from your controller
                                hintText: "******",
                                prefixIcon: SvgPicture.asset(
                                  Asset.lockIcon,
                                  width: 20,
                                  height: 20,
                                  colorFilter: const ColorFilter.mode(
                                    MyColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
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
                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          controller.rememberMe.value =
                                              !controller.rememberMe.value;
                                        },
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                            border: Border.all(
                                              color: MyColors.grey,
                                            ),
                                            color: controller.rememberMe.value
                                                ? MyColors.primary
                                                : Colors.transparent,
                                          ),
                                          child: controller.rememberMe.value
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    Text(
                                      'Remember Me',
                                      style: MyTexts.medium13.copyWith(
                                        color: MyColors.grey,
                                        fontFamily: MyTexts.SpaceGrotesk
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.FORGOT_PASSWORD);
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.red,
                                        fontFamily: MyTexts.SpaceGrotesk
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(24),
                            Obx(
                              () => RoundedButton(
                                buttonName: 'LOGIN',
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
                                    color: MyColors.greySecond,
                                    indent: 20.sw,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  child: Text(
                                    'Or Continue with',
                                    style: MyTexts.medium13.copyWith(
                                      color: MyColors.greySecond,
                                        fontFamily: MyTexts.SpaceGrotesk

                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: MyColors.greySecond,
                                    endIndent: 20.sw,
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
                                      border: Border.all(
                                        color: MyColors.greyThird,
                                      ),
                                    ),
                                    height: 6.sh,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(Asset.googleIcon),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                SizedBox(width: 10.sw),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: MyColors.greyThird,
                                      ),
                                    ),
                                    height: 6.sh,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                        fontFamily: MyTexts.SpaceGrotesk

                                    ),
                                  ),
                                  Text(
                                    "Sign-up",
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.lightBlueSecond,
                                        fontFamily: MyTexts.SpaceGrotesk
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
