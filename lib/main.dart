import 'package:construction_technect/app/core/utils/imports.dart';

void main() {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: "Construction Technect",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          // Web-specific configurations
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        );
      },
    ),
  );
}
