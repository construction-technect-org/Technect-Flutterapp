import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/services/fcm_service.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize FCM service
  await FCMService.initialize();
  await Hive.initFlutter();
  await Hive.openBox('appBox');

  await Get.putAsync<AppHiveService>(() async {
    final service = AppHiveService();
    await service.init();
    return service;
  });
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return SafeArea(
          top: false,
          child: GetMaterialApp(
            title: "CONSTRUCTION TECHNECT",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: ThemeData(useMaterial3: false),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fadeIn,
            initialBinding: InitialBinding(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                  //viewInsets: EdgeInsets.zero,
                ),
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
    Get.put<ManageApi>(ManageApi(), permanent: true);
    Get.put<HomeService>(HomeService(), permanent: true);
    Get.put<CommonController>(CommonController(), permanent: true);
    myPref = Get.find();
  }
}
