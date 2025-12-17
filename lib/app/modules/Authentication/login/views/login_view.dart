import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/google_sign_in_service.dart';
import 'package:construction_technect/app/core/widgets/no_network.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/widget/save_pass_widget.dart';
import 'package:construction_technect/app/modules/Authentication/login/controllers/login_controller.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:upgrader/upgrader.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  bool _isBottomSheetOpen = false;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: _buildUpgradeAlert(context),
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);

        if (!connected && !_isBottomSheetOpen) {
          _isBottomSheetOpen = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Get.isBottomSheetOpen == false) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {},
                  child: NoInternetBottomSheet(),
                ),
              ).whenComplete(() {
                _isBottomSheetOpen = false;
              });
            }
          });
        } else if (connected && _isBottomSheetOpen) {
          _isBottomSheetOpen = false;
          Get.back();
        }

        return child;
      },
    );
  }

  Widget _buildUpgradeAlert(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      shouldPopScope: () => true,
      barrierDismissible: true,
      upgrader: Upgrader(durationUntilAlertAgain: const Duration(days: 1)),
      child: _buildMainLoginBody(context),
    );
  }

  Widget _buildMainLoginBody(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.loginBg), fit: BoxFit.cover),
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
                          height: 180,
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
                            style: MyTexts.medium18.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(24),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login',
                            style: MyTexts.medium20.copyWith(color: Colors.black),
                          ),
                        ),
                        const Gap(16),

                        /// 📱 Phone Field
                        CommonPhoneField(
                          headerText: "Mobile Number",
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          isValid: controller.isValid,
                          customErrorMessage: controller.mobileValidationError,
                          onCountryCodeChanged: (code) {
                            controller.countryCode.value = code;
                          },
                          onSubmitted: (val) {
                            FocusScope.of(context).requestFocus(controller.passwordFocusNode);
                          },
                        ),
                        const Gap(16),

                        /// 🔒 Password
                        Obx(() {
                          return CommonTextField(
                            textInputAction: TextInputAction.done,
                            headerText: "Password",
                            focusNode: controller.passwordFocusNode,
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            hintText: "Password",
                            validator: (val) {
                              if ((val ?? "").isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            showDivider: true,
                            suffixIcon: GestureDetector(
                              onTap: () => controller.togglePasswordVisibility(),
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
                            SavePassWidget(
                              state: controller.rememberMe,
                              onChanged: (val) => controller.rememberMe.value = val,
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
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
                                    controller.loginError.value = "";
                                    controller.mobileValidationError.value = "";
                                    controller.isValid.value = -1;
                                    if (!controller.formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final mobileNumber = controller.mobileController.text.trim();
                                    if (mobileNumber.isEmpty) {
                                      controller.isValid.value = 0;
                                      return;
                                    }

                                    final mobileError = ValidationUtils.validateMobileNumber(
                                      mobileNumber,
                                    );
                                    if (mobileError != null) {
                                      controller.mobileValidationError.value = mobileError;
                                      controller.isValid.value = 1;
                                      return;
                                    }

                                    if (controller.formKey.currentState?.validate() ?? false) {
                                      hideKeyboard();
                                      controller.login();
                                    }
                                  },
                          ),
                        ),
                        const Gap(12),
                        RoundedButton(
                          color: Colors.white,
                          fontColor: MyColors.primary,
                          borderColor: MyColors.primary,
                          buttonName: 'Login as team member',
                          onTap: () {
                            controller.openPhoneNumberBottomSheet();
                          },
                        ),

                        const Gap(24),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: MyColors.grayD4, indent: 10.sw, thickness: 1),
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
                                  final user = await GoogleSignInService.signInWithGoogle();
                                  if (user != null) {
                                    await controller.callSocialLoginAPI(user);
                                  } else {
                                    SnackBars.errorSnackBar(
                                      content: 'Google Sign-In was cancelled by user',
                                    );
                                  }
                                } catch (e) {
                                  SnackBars.errorSnackBar(content: 'Google Sign-In failed: $e');
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
                                style: MyTexts.regular16.copyWith(fontFamily: MyTexts.SpaceGrotesk),
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
