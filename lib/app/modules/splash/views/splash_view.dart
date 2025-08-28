import 'dart:developer';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.token ?? 'null');

    // ✅ Handle Web separately
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Asset.logoWithoutBack, fit: BoxFit.contain, width: 250),
              const SizedBox(height: 20),
              Text(
                'Welcome to Construction Technect (Web)',
style: MyTexts.light22              ),
            ],
          ),
        ),
      );
    }

    // ✅ Handle Mobile
    if (Device.screenType == ScreenType.mobile) {
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

    // ✅ Fallback for tablets / desktop (non-web)
    return const Scaffold(
      body: Center(child: Text("Unsupported device")),
    );
  }
}
