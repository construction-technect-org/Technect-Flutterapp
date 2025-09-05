import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';

late AppSharedPreference myPref;

Future<void> initService() async {
  await Get.putAsync(() {
    return AppSharedPreference().initializeStorage();
  });
  myPref = Get.find();
}

Future<void> main() async {
  await initService();
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: "Construction Technect",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          initialBinding: InitialBinding(),
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

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    myPref = Get.find();
    Get.put(CommonController());
  }
}
