import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();
  final selectedFunctionalities = ''.obs;
  final selectedFunctionality = ''.obs;
  final isLoading = false.obs;
  Rx<GetAllRole> dataModel = GetAllRole().obs;

  int? roleId;
  RxBool isEdit = false.obs;

  // Comprehensive functionalities list
  final List<String> functionalities = [
    'Report',
    'Analysis',
    'Add Team',
    'Lead Management',
    'Sales Management',
    'Accounts Management',
    'Task Management',
    'Settings',
    'Chat System',
    'Download',
    'Add Lead',
    'Edit Lead',
    'Delete Lead',
    'Add Sale',
    'Edit Sale',
    'Delete Sale',
    'Add Account',
    'Edit Account',
    'Delete Account',
    'Add steps',
    'Edit steps',
    'Delete steps',
  ];

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

    // Check if the value exists in functionalities list (case-insensitive)
    String found;
    try {
      found = functionalities.firstWhere(
        (func) => func.toLowerCase() == functionalityValue.toLowerCase(),
      );
    } catch (e) {
      found = functionalityValue;
    }

    selectedFunctionality.value = found;
    selectedFunctionalities.value = found;
  }

  void selectFunctionality(String label) {
    selectedFunctionality.value = label;
    selectedFunctionalities.value = label;
  }

  bool isFunctionalitySelected(String label) {
    return selectedFunctionality.value == label;
  }

  Future<void> saveRole() async {
    if (selectedFunctionality.value.isEmpty) {
      Get.snackbar("Error", "Please select a functionality");
      return;
    }

    // Ensure functionality is set for API
    selectedFunctionalities.value = selectedFunctionality.value;

    isLoading.value = true;

    try {
      if (isEdit.value && roleId != null) {
        final result = await RoleService.updateRole(
          roleId: roleId!,
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities.value,
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
          functionalities: selectedFunctionalities.value,
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
