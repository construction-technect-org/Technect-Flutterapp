import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

class NoInternetBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          // Lottie.asset(
          //   AppImage.noInternet,
          //   fit: BoxFit.cover,
          //   height: 150,
          // ),
          const SizedBox(height: 24),
          Text(
            'No Internet Connection',
            style: MyTexts.medium18.copyWith(color: MyColors.black),
          ),
          Text(
            'Please check your connection and try again',
            style: MyTexts.regular14.copyWith(color: MyColors.gray2E),

            textAlign: TextAlign.center,
          ),
          const Gap(20),
          RoundedButton(
            width: 160,
            buttonName: "Go to setting",
            onTap: () {
              if (Platform.isAndroid) {
                AppSettings.openAppSettingsPanel(
                  AppSettingsPanelType.internetConnectivity,
                );
              } else {
                AppSettings.openAppSettings(type: AppSettingsType.wifi);
              }
            },
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
