import 'package:get/get.dart';

class SwitchAccountController extends GetxController {
  // Current role: 'partner' or 'connector'
  RxString currentRole = 'partner'.obs;

  // Account status
  RxBool hasPartnerAccount = true.obs;
  RxBool hasConnectorAccount = false.obs;

  bool get canAddPartner => !hasPartnerAccount.value && currentRole.value == 'connector';
  bool get canAddConnector => !hasConnectorAccount.value && currentRole.value == 'partner';
  bool get canSwitchAccount => hasPartnerAccount.value && hasConnectorAccount.value;

  void switchAccount() {
    if (currentRole.value == 'partner') {
      currentRole.value = 'connector';
    } else {
      currentRole.value = 'partner';
    }
    Get.back();
  }

  void addPartnerAccount() {
    hasPartnerAccount.value = true;
    Get.back();
  }

  void addConnectorAccount() {
    hasConnectorAccount.value = true;
    Get.back();
  }
}
