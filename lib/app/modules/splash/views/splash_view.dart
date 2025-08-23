import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.token ?? 'null');
    if (Device.screenType != ScreenType.mobile) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.custom('F4F0E4').withOpacity(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Asset.logoWithoutBack, fit: BoxFit.contain),
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Text(
                    'Connecting Construction WorldWide',
                    style: MyTexts.medium16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
