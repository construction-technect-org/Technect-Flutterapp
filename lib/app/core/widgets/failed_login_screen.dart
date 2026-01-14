import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/common_button.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class FailedLoginScreen extends StatelessWidget {
  const FailedLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.loginBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 34,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: MyColors.grayEA),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(Asset.failure, height: 14, width: 14),
                    const Gap(16),
                    Text(
                      "Failed! to login",
                      style: MyTexts.bold18.copyWith(
                        color: const Color(0xFF058200),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(48),
              RoundedButton(buttonName: "Retry", onTap: () {}),
              const Gap(30),
              RoundedButton(
                buttonName: "Click here to recover your account",
                child: Colors.transparent,
                borderColor: MyColors.blueBorder,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
