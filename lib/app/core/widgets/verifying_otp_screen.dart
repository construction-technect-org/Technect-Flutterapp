import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';

class VerifyingOtpScreen extends StatefulWidget {
  VerifyingOtpScreen({super.key, this.header, this.onTap});

  final String? header;

  final Function()? onTap;

  @override
  State<VerifyingOtpScreen> createState() => _VerifyingOtpScreenState();
}

class _VerifyingOtpScreenState extends State<VerifyingOtpScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (widget.onTap != null) widget.onTap!();
    });
  }

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Row(
              children: [
                const CircularProgressIndicator(color: MyColors.grey),
                const Gap(16),
                Text(
                  widget.header ?? "",
                  style: MyTexts.bold18.copyWith(color: MyColors.gray2E),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
