import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:get/get.dart';

class RoleDetailsController extends GetxController {
  GetAllRole? roleDetailsModel;
  RxString roleTitle = "Admin".obs;
  RxString roleId = "".obs;
  RxString roleDescription = "".obs;
  RxList<String> functionalities = <String>[].obs;
  RxString roleStatus = "Active".obs;
  RxBool isLoading = false.obs;
  RoleService roleService = RoleService();
  RoleManagementController roleManagementController = Get.find();

  @override
  void onInit() {
    super.onInit();
    handlePassedData();
  }

  void handlePassedData() {
    final arguments = Get.arguments;
    roleDetailsModel = arguments?['getRole'] ?? GetAllRole();
    roleId.value = (roleDetailsModel?.id ?? 0).toString();
    roleTitle.value = roleDetailsModel?.roleName ?? "Admin";
    // roleStatus.value = roleDetailsModel?.isActive == true
    //     ? "Active"
    //     : "InActive";
    roleDescription.value = roleDetailsModel?.description ?? '';
    functionalities.value = roleDetailsModel?.permissions ?? [];
  }

  Future<void> deleteRole(String id) async {
    try {
      isLoading.value = true;
      await roleService.deleteRole(id);
      await roleManagementController.refreshRoles();
      Get.back();
    } catch (e) {
      // ignore: avoid_print
    }
  }
}
