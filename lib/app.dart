import 'package:construction_technet/routing/app_router.dart';
import 'package:construction_technet/routing/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/constants_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (__, _) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffolfBackGroundColor,
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            textTheme: AppTheme.customTextTheme,
          ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: RouteNames.splash,
        );
      },
    );
  }
}
