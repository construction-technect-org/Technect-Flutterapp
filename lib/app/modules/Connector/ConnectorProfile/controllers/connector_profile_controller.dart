// import 'package:construction_technect/app/core/utils/imports.dart';

// class ConnectorProfileController extends GetxController {
//   final selectedTabIndex = 0.obs;
//   final isLoading = false.obs;


// }


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';

class ConnectorProfileController extends GetxController {
  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;


  HomeController get homeController => Get.find<HomeController>();

  ProfileModel get profileData => homeController.profileData.value;
  MerchantProfile? get merchantProfile => profileData.data?.merchantProfile;
  UserModel? get userData => profileData.data?.user;
  int get profileCompletionPercentage =>
      merchantProfile?.profileCompletionPercentage ?? 0;

  
}

 

