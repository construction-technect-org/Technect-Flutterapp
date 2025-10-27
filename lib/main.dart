import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

late AppSharedPreference myPref;

Future<void> initService() async {
  await Get.putAsync(() {
    return AppSharedPreference().initializeStorage();
  });
  myPref = Get.find();
}

Future<void> main() async {
  await initService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return SafeArea(
          top: false,
          bottom: true,
          child: GetMaterialApp(
            title: "CONSTRUCTION TECHNECT",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: ThemeData(useMaterial3: false),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fadeIn,
            initialBinding: InitialBinding(),
            // Web-specific configurations
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          ),
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
