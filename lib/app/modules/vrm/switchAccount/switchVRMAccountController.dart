import "dart:developer";


import 'package:construction_technect/app/core/utils/imports.dart';

class SwitchVRMAccountController extends GetxController {
  RxString currentRole = ''.obs;

  RxBool hasPartnerAccount = false.obs;
  RxBool hasConnectorAccount = false.obs;

  void switchAccount() {
    if (currentRole.value == 'partner') {
      currentRole.value = 'connector';
    } else {
      currentRole.value = 'partner';
    }
    myPref.role.val = currentRole.value;
    log("Roleach ${myPref.role.val}");
    Get.back();
    if (myPref.role.val == 'connector') {
      Get.offAllNamed(Routes.VRM_MAIN);
    } else {
      Get.offAllNamed(Routes.CRM_MAIN);
    }
  }

  void addPartnerAccount() {
    Get.back();
    Get.toNamed(Routes.PROFILE, arguments: {"isSwitch": true});
  }

  void addConnectorAccount() {
    Get.back();
    Get.toNamed(Routes.CONNECTOR_PROFILE, arguments: {"isSwitch": true});
  }

  final ApiManager apiManager = ApiManager();

  Future<void> updateRole({required String role}) async {
    try {
      final Map<String, dynamic> fields = {'marketplace_role': role};

      Map<String, String>? files;
      final _ = await apiManager.putMultipart(
        url: APIConstants.updateProfile,
        fields: fields,
        files: files,
      );
    } catch (e, st) {
      SnackBars.errorSnackBar(content: "Update failed: $e $st");
    } finally {}
  }
}
