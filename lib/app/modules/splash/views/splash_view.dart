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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Asset.bricksBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Image.asset(Asset.splashLogo, fit: BoxFit.contain),
              SizedBox(height: 1.h),
              Text(Constants.constructionTechnect, style: MyTexts.extraBold20),
              SizedBox(height: 0.3.h),
              Text(
                Constants.connectingConstructionWorldwide,
                style: MyTexts.medium14,
              ),
              const Spacer(),
              const Spacer(),
              const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
