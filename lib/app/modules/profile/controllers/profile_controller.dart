import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';

class ProfileController extends GetxController {
  final selectedTabIndex = 0.obs;

  // Get HomeController instance to access profile data
  HomeController get homeController => Get.find<HomeController>();

  // Get profile data
  ProfileModel get profileData => homeController.profileData.value;

  // Get merchant profile data
  MerchantProfile? get merchantProfile => profileData.data?.merchantProfile;

  // Get user data
  UserModel? get userData => profileData.data?.user;

  // Get profile completion percentage
  int get profileCompletionPercentage =>
      merchantProfile?.profileCompletionPercentage ?? 0;

  // Get business hours
  List<BusinessHours> get businessHours => merchantProfile?.businessHours ?? [];

  // Get documents
  List<Documents> get documents => merchantProfile?.documents ?? [];

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
