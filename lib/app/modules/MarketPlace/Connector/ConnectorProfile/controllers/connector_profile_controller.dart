import "dart:developer";


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/PocModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/services/AddKycService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';

class ConnectorProfileController extends GetxController {
  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;
  final isSwitch = false.obs;
   Rxn<PocModel> profileDatas = Rxn<PocModel>();

  Rxn<PersonaResponse> personaData = Rxn<PersonaResponse>();

  HomeController get homeController => Get.find<HomeController>();

  ProfileModel get profileData =>
      Get.find<CommonController>().profileData.value;

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

  Future<void> pointOfContact() async {
     final data= await AddKycService().getProfileId();
    personaData.value=data;
    final List<Profile> personas =
        personaData.value?.profiles ?? [];
    final String profileId = personas
        .firstWhere(
          (e) => e.profileType == "connector",
      orElse: () => Profile(),
    )
        .profileId ??
        "";

    log( '✅  C ProfileId : $profileId');
    if (profileId.isNotEmpty) {
      myPref.setProfileId(profileId);
      try {
        final response = await AddKycService().getPointOfContact(profileId);
        if (response.success == true) {
          log( '✅ POC Name Response: ${response.connector?.pocDetails?.pocName??"Null"}');
          profileDatas.value = response;
          log( '✅ POC Name Response: ${profileDatas.value?.connector?.pocDetails?.pocName??"Null"}');

        }
      } catch (e) {
        SnackBars.errorSnackBar(content: "Error: $e");
      }
    } else {
      SnackBars.errorSnackBar(content: "Error: $profileId");
    }
  }

  @override
  void onInit() {
    super.onInit();
    if(myPref.role.val=="connector") {
      pointOfContact();
    }
    if (Get.arguments != null) {
      isSwitch.value = true;
    }
    Get.lazyPut(() => HomeController());
  }
}
