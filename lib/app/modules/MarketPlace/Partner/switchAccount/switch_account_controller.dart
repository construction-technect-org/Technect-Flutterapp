import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/controller/connector_home_controller.dart';

class SwitchAccountController extends GetxController {

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
    print("Roleach ${myPref.role.val}");
    Get.back();
    // Get.delete<ConnectorHomeController>(force: true);
    // Get.delete<CommonController>(force: true);
    Get.offAllNamed(Routes.MAIN);
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final CommonController commonController = Get.find<CommonController>();
    Get.printInfo(info: '🌐has All Data   : ${commonController.profileData.value}');
    commonController.fetchProfileDataM();
    currentRole.value = myPref.role.val;
    hasPartnerAccount.value =
        (commonController
            .profileData
            .value
            .data
            ?.merchantProfile
            ?.businessEmail ??
            "")
            .isNotEmpty;
    Get.printInfo(info: '🌐has Partner n  : ${hasPartnerAccount.value}');

    hasConnectorAccount.value =
        commonController.profileData.value.data?.connectorProfile !=
            null;
    Get.printInfo(
      info: '🌐has Connector n : ${hasConnectorAccount.value}',
    );
  }
}
