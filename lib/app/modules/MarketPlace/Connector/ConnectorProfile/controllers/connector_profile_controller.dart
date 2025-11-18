import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/services/AddKycService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';

class ConnectorProfileController extends GetxController {
  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;
  final isSwitch = false.obs;

  HomeController get homeController => Get.find<HomeController>();

  ProfileModel get profileData => homeController.profileData.value;

  ConnectorProfile? get connectorProfile => profileData.data?.connectorProfile;

  UserModel? get userData => profileData.data?.user;

  int get profileCompletionPercentage =>
      connectorProfile?.profileCompletionPercentage ?? 0;

  final aadhaarController = TextEditingController();
  RxBool isVerified = false.obs;

  Future<void> proceedKyc() async {
    isLoading.value = true;
    try {
      final response = await AddKycService().connectorAddKYC(
        aadhaar: aadhaarController.text.trim(),
      );
      if (response.success) {
        myPref.role.val = "connector";
        Get.find<SwitchAccountController>().updateRole(role: "connector");
        Get.offAllNamed(Routes.MAIN);
      } else {
        SnackBars.errorSnackBar(content: response.message);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isSwitch.value = true;
    }
    Get.lazyPut(() => HomeController());
  }
}
