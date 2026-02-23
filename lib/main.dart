import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/services/fcm_service.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/controller/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/sub_category_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/sub_category_item_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/main_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:construction_technect/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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
   // if(myPref.token==""){
   //  Get.lazyPut(() => CommonController());
   //  Get.lazyPut(() => SwitchAccountController());
   //  Get.lazyPut(() => ConnectorHomeController());
   // }
   // else{
     Get.put<CommonController>(CommonController(), permanent: true);
     Get.put<SwitchAccountController>(SwitchAccountController(), permanent: true);
     Get.put<ConnectorHomeController>(ConnectorHomeController(), permanent: true);
   // }
    Get.put<SubCategoryController>(SubCategoryController(), permanent: true);
    Get.put<SubCategoryItemController>(SubCategoryItemController(), permanent: true);
    Get.put<MainHomeController>(MainHomeController(), permanent: true);
    myPref = Get.find();
  }
}
