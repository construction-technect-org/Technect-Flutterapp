import 'package:construction_technect/app/modules/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();

  final selectedFunctionalities = <String>[].obs;
  final isLoading = false.obs;

  int? roleId;
  bool isEdit = false;

  void loadRoleData(dynamic role) {
    isEdit = true;
    roleId = role.id;

    roleController.text = role.roleTitle ?? '';
    roleDescription.text = role.roleDescription ?? '';

    if (role.functionalities is String) {
      selectedFunctionalities.assignAll(
        role.functionalities.replaceAll('{', '').replaceAll('}', '').split(","),
      );
    } else if (role.functionalities is List) {
      selectedFunctionalities.assignAll(List<String>.from(role.functionalities));
    }
  }

  Future<void> saveRole() async {
    if (roleController.text.isEmpty || roleDescription.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    isLoading.value = true;

    try {
      if (isEdit && roleId != null) {
        final result = await RoleService.updateRole(
          roleId: roleId!,
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities,
          isActive: true,
        );

        if (result != null && result.success) {
          // Refresh role management screen
          await _refreshRoleManagement();
          Get.back();
          Get.snackbar("Success", "Role updated successfully!");
        } else {
          Get.snackbar("Failed", result?.message ?? "Something went wrong");
        }
      } else {
        final result = await RoleService.createRole(
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities,
          isActive: true,
        );

        if (result != null && result.success) {
          // Refresh role management screen
          await _refreshRoleManagement();
          Get.back();
          Get.snackbar("Success", "Role created successfully!");
        } else {
          Get.snackbar("Failed", result?.message ?? "Something went wrong");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _refreshRoleManagement() async {
    try {
      // Try to find and refresh the role management controller
      if (Get.isRegistered<RoleManagementController>()) {
        final roleManagementController = Get.find<RoleManagementController>();
        await roleManagementController.refreshRoles();
      }
    } catch (e) {
      // If controller is not found, it's okay - the roles will be refreshed when user navigates back
      print('RoleManagementController not found: $e');
    }
  }

  void toggleFunctionality(String func) {
    if (selectedFunctionalities.contains(func)) {
      selectedFunctionalities.remove(func);
    } else {
      selectedFunctionalities.add(func);
    }
  }
}
