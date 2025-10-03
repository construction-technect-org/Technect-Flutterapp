import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:get/get.dart';

class RoleDetailsController extends GetxController {
  GetAllRole? roleDetailsModel;
  RxString roleTitle = "Admin".obs;
  RxString roleId = "".obs;
  RxString roleDescription = "".obs;
  RxString functionalities = "".obs;
  RxString roleStatus = "Active".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    handlePassedData();
  }

  void handlePassedData() {
    final arguments = Get.arguments;
    roleDetailsModel = arguments?['getRole'] ?? GetAllRole();
    roleTitle.value = roleDetailsModel?.roleTitle ?? "Admin";
    roleStatus.value = roleDetailsModel?.isActive == true ? "Active" : "InActive";
    roleDescription.value = roleDetailsModel?.roleDescription ?? '';
    functionalities.value = roleDetailsModel?.functionalities ?? '';
  }
}
