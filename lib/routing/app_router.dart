import 'package:construction_technet/presentation/features/splash/splash_screen.dart';
import 'package:construction_technet/routing/routes_name.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(
                  child: Text('Something went wrong! Please try again later.'),
                ),
              ),
        );
    }
  }
}
