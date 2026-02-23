import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/services/AddKycService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/controller/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/controllers/edit_product_controller.dart';

class SwitchAccountController extends GetxController {
  final AppHiveService _appHiveService = Get.find<AppHiveService>();
  final ConnectorHomeController controller = Get.put(ConnectorHomeController());

  RxString currentRole = ''.obs;

  RxBool hasPartnerAccount = false.obs;
  RxBool hasConnectorAccount = false.obs;

  Future<void> switchAccount() async {
    final data = await AddKycService().getProfileId();
    final List<Profile> profiles = data.profiles ?? [];

    if (currentRole.value == 'partner') {
      // 🔹 Switch to connector
      final connector = profiles.firstWhere(
        (e) => e.profileType == "connector",
        orElse: () => Profile(),
      );

      if (connector.profileId != null) {
        await switchProfile(connector.profileId!, connector.profileType ?? "");
        currentRole.value = 'connector';
        myPref.setRole("connector");
        await controller.fetchConnectorModule();
        await EditProductController().fetchProjects();
      }
    } else {
      // 🔹 Switch to merchant (partner)
      final merchant = profiles.firstWhere(
        (e) => e.profileType == "merchant",
        orElse: () => Profile(),
      );

      if (merchant.profileId != null) {
        await switchProfile(merchant.profileId!, merchant.profileType ?? "");
        currentRole.value = 'partner';
        myPref.setRole("partner");
        await controller.fetchConnectorModule();
      }
    }
    myPref.role.val = currentRole.value;
    // if (currentRole.value == 'partner') {
    //   currentRole.value = 'connector';
    // } else {
    //   currentRole.value = 'partner';
    // }
    // myPref.role.val = currentRole.value;
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

  Future<void> addConnectorAccount() async {
    if(myPref.role.val=="partner"){
      await becomeConnector();
      currentRole.value = 'connector';
      myPref.setRole("connector");
      await controller.fetchConnectorModule();
      await EditProductController().fetchProjects();
      myPref.role.val = currentRole.value;
      Get.back();
      Get.offAllNamed(Routes.MAIN);
    }
    else{
      Get.back();
      Get.toNamed(Routes.CONNECTOR_PROFILE, arguments: {"isSwitch": true});
    }

  }

  final ApiManager apiManager = ApiManager();

  Future<void> switchProfile(String profileId, String profileType) async {
    try {
      final body = {"profileId": profileId, "profileType": profileType};

      final switchResponse = await apiManager.postObject(
        url: "/${APIConstants.switchAccount}",
        body: body,
      );
      final String? token = switchResponse["token"];

      if (token != null && token.isNotEmpty) {
        await _appHiveService.setToken(token);
        myPref.setToken(token);
        Get.printInfo(info: "✅ New token stored successfully");
      }
    } catch (e) {
      Get.printInfo(info: "❌ Switch Profile Error: $e");
    }
  }
  Future<void> becomeConnector() async {
    try {

      final becomeConnectorResponse = await apiManager.postObject(
        url: "/v1/api/auth/profiles/merchant/become-connector",
        body: {}
      );
      final String? token = becomeConnectorResponse["token"];

      if (token != null && token.isNotEmpty) {
        await _appHiveService.setToken(token);
        myPref.setToken(token);
        Get.printInfo(info: "✅ New token stored successfully");
      }
    } catch (e) {
      Get.printInfo(info: "❌ becomeConnector Error: $e");
    }
  }

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
    Get.printInfo(
      info: '🌐has All Data   : ${commonController.profileData.value}',
    );
    Future.microtask(() async {
      await commonController.fetchProfileDataM();
      currentRole.value = myPref.role.val;
    });
  }
}
