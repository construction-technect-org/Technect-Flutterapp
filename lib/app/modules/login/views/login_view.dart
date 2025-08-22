import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(43)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 4.h),
                      Text('LOGIN', style: MyTexts.light22),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Text(
                            'Enter Your Mobile Number',
                            style: MyTexts.light18.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light18.copyWith(color: Colors.red)),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.textFieldBorder),
                          color: MyColors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SvgPicture.asset(
                                Asset.phoneIcon,
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  MyColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            // Vertical divider
                            Container(
                              width: 1,
                              height: 30,
                              color: MyColors.textFieldDivider,
                            ),
                            // Text field
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                style: MyTexts.extraBold16.copyWith(
                                  height: 36 / 16,
                                  color: MyColors.primary,
                                ),
                                cursorHeight: 20,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  hintText: 'Enter mobile number',
                                  hintStyle: MyTexts.medium16.copyWith(
                                    color: MyColors.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.sh),
                      Text(
                        'Password*',
                        style: MyTexts.light18.copyWith(color: MyColors.lightBlue),
                      ),
                      SizedBox(height: 1.sh),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.textFieldBorder),
                          color: MyColors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SvgPicture.asset(
                                Asset.lockIcon,
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  MyColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            // Vertical divider
                            Container(
                              width: 1,
                              height: 30,
                              color: MyColors.textFieldDivider,
                            ),
                            // Text field
                            Expanded(
                              child: TextField(
                                obscureText: true,
                                style: MyTexts.extraBold16.copyWith(
                                  color: MyColors.primary,
                                  height: 36 / 16,
                                ),
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: MyTexts.medium16.copyWith(
                                    color: MyColors.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                            // Eye icon
                            Padding(
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(color: MyColors.grey),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember Me',
                                style: MyTexts.medium14.copyWith(color: MyColors.grey),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: MyTexts.medium14.copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.sh),
                      const RoundedButton(buttonName: 'LOGIN'),
                      SizedBox(height: 2.sh),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: MyColors.greySecond,
                              indent: 12.sw,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Text(
                              'Or Continue with',
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.greySecond,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: MyColors.greySecond,
                              endIndent: 16.sw,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: MyColors.greyThird),
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
                                border: Border.all(color: MyColors.greyThird),
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
                      SizedBox(height: 2.5.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ", style: MyTexts.light16),
                          Text(
                            " Sign-up",
                            style: MyTexts.light16.copyWith(
                              color: MyColors.lightBlueSecond,
                            ),
                          ),
                        ],
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
    );
  }
}
