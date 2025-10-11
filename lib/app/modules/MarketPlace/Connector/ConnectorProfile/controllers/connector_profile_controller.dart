


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/controllers/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class ConnectorProfileController extends GetxController {
  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;


  ConnectorHomeController get homeController => Get.find<ConnectorHomeController>();

  ProfileModel get profileData => homeController.profileData.value;
  ConnectorProfile? get connectorProfile => profileData.data?.connectorProfile;
  UserModel? get userData => profileData.data?.user;
  int get profileCompletionPercentage =>
      connectorProfile?.profileCompletionPercentage ?? 0;

}

 

