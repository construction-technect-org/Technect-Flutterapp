import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_screen.dart';
import 'package:get/get.dart';

class SwitchAccountController extends GetxController {
  // currentRole comes from preference
  RxString currentRole = ''.obs;

  // Account statuses from prefs
  RxBool hasPartnerAccount = false.obs;
  RxBool hasConnectorAccount = false.obs;

  bool get canAddPartner =>
      !hasPartnerAccount.value && currentRole.value == 'connector';

  bool get canAddConnector =>
      !hasConnectorAccount.value && currentRole.value == 'partner';

  bool get canSwitchAccount =>
      hasPartnerAccount.value && hasConnectorAccount.value;

  @override
  void onInit() {
    super.onInit();
    currentRole.value = myPref.role.val ?? ''; // "partner" or "connector"
    hasPartnerAccount.value =
        Get.find<HomeController>().profileData.value.data?.merchantProfile !=
        null;
    hasConnectorAccount.value =
        Get.find<HomeController>().profileData.value.data?.connectorProfile !=
        null;
    print(hasPartnerAccount.value);
    print(hasConnectorAccount.value);
  }

  void switchAccount() {
    if (currentRole.value == 'partner') {
      currentRole.value = 'connector';
    } else {
      currentRole.value = 'partner';
    }
    myPref.role.val = currentRole.value;
    Get.back();
    Get.offAllNamed(Routes.MAIN);
    Get.snackbar(
      "Account Switched",
      "Now using ${currentRole.value.capitalizeFirst} account.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addPartnerAccount() {
    hasPartnerAccount.value = true;
    Get.back();
    Get.to(() => const SwitchAccountScreen());
  }

  void addConnectorAccount() {
    // Get.toNamed(Routes.SIGN_UP_DETAILS);
    hasConnectorAccount.value = true;
    Get.back();
    Get.to(() => const SwitchAccountScreen());
  }
}
