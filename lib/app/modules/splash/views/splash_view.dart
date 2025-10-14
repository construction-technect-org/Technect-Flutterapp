// import 'dart:developer';

// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:construction_technect/app/modules/splash/controllers/splash_controller.dart';

// class SplashView extends GetView<SplashController> {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     log(controller.token ?? 'null');

//     // ✅ Handle Web separately
//     if (kIsWeb) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(Asset.logoWithoutBack, fit: BoxFit.contain, width: 250),
//               const SizedBox(height: 20),
//               Text('Welcome to Construction Technect (Web)', style: MyTexts.light22),
//             ],
//           ),
//         ),
//       );
//     }

//     // ✅ Handle Mobile
//     if (Device.screenType == ScreenType.mobile) {
//       return Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               color: MyColors.custom('F4F0E4').withOpacity(0.5),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(Asset.logoWithoutBack, fit: BoxFit.contain),
//                   Transform.translate(
//                     offset: const Offset(0, -40),
//                     child: Text(
//                       'Connecting Construction WorldWide',
//                       style: MyTexts.medium16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     // ✅ Fallback for tablets / desktop (non-web)
//     return const Scaffold(body: Center(child: Text("Unsupported device")));
//   }
// }

import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/splash/controllers/splash_controller.dart';
import 'package:gap/gap.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.token ?? 'null');

    if (kIsWeb) {
      return Scaffold(
        body: Stack(
          children: [
            // Full background image
            Positioned.fill(
              child: Image.asset(
                Asset.splashBg, // 🔹 add your background image in assets
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Asset.logoWithoutBack,
                    fit: BoxFit.contain,
                    width: 250,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to Construction Technect (Web)',
                    style: MyTexts.light22,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            // Full background image
            Positioned.fill(
              child: Image.asset(Asset.splashBg, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Asset.appLogo,
                      fit: BoxFit.contain,
                      width: 192,
                      height: 206,
                    ),
                    const Gap(20),
                    Text(
                      "Connecting Construction Worldwide",
                      style: MyTexts.medium18.copyWith(color: MyColors.gray2E),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
