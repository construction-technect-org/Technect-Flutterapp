import 'package:construction_technet/core/constants/constants_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // background image
            Positioned.fill(
              child: Image.asset(AppImages.brickBackground, fit: BoxFit.cover),
            ),

            // logo and app name
            Column(
              spacing: 5.r,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.r),
                Image.asset(AppImages.splashLogo, fit: BoxFit.cover),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  AppStrings.connecting,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.splashSecondaryTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      // Navigator.pushReplacementNamed(context, RouteNames.login);
    });
  }
}
