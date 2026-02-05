import 'package:construction_technect/app/core/utils/permission_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();
  final RxList<String> selectedFunctionalities = <String>[].obs;
  final isLoading = false.obs;
  Rx<GetAllRole> dataModel = GetAllRole().obs;

  int? roleId;
  RxBool isEdit = false.obs;
  final List<PermissionItem> functionalities =
      PermissionLabelUtils.permissionItems;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument != null) {
      isEdit.value = argument['isEdit'] ?? false;
      dataModel.value = argument['data'] ?? GetAllRole();
    }
    if (isEdit.value) {
      loadRoleData(dataModel.value);
    }
  }

  void loadRoleData(GetAllRole role) {
    isEdit.value = true;
    roleId = role.id;

    roleController.text = role.roleTitle ?? '';
    roleDescription.text = role.roleDescription ?? '';

    final functionalityValue = role.functionalities ?? '';

    selectedFunctionalities.value = functionalityValue
        .split(',')
        .map((e) => e.trim())
        .toList();
  }

  void toggleFunctionality(String key) {
    if (selectedFunctionalities.contains(key)) {
      selectedFunctionalities.remove(key);
    } else {
      selectedFunctionalities.add(key);
    }
  }

  bool isFunctionalitySelected(String key) {
    return selectedFunctionalities.contains(key);
  }

  Future<void> saveRole() async {
    if (selectedFunctionalities.isEmpty) {
      Get.snackbar("Error", "Please select a functionality");
      return;
    }

    isLoading.value = true;

    try {
      if (isEdit.value && roleId != null) {
        final result = await RoleService.updateRole(
          roleId: roleId!,
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities.join(','),
          isActive: true,
        );

        if (result.success) {
          await _refreshRoleManagement();
          Get.back();
        }
      } else {
        final result = await RoleService.createRole(
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities.join(','),
          isActive: true,
        );

        if (result.success) {
          await _refreshRoleManagement();
          Get.back();
        }
      }
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _refreshRoleManagement() async {
    try {
      if (Get.isRegistered<RoleManagementController>()) {
        final roleManagementController = Get.find<RoleManagementController>();
        await roleManagementController.refreshRoles();
      }
    } catch (e) {
      // ignore: avoid_print
    }
  }
}
