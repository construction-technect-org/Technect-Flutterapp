// ignore_for_file: type_annotate_public_apis

import 'package:construction_technect/app/modules/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/RoleDetails/models/role_details_model.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();
  final argument = Get.arguments;
  final selectedFunctionalities = <String>[].obs;
  final isLoading = false.obs;
  Rx<RoleDetailsModel> dataModel = RoleDetailsModel().obs;

  int? roleId;
  RxBool isEdit = false.obs;

  @override
  void onInit() {
    if (argument != null) {
      isEdit.value = argument["isEdit"];
      dataModel.value = argument["data"];
    }
    if (isEdit.value) {
      loadRoleData(dataModel.value);
    }
    super.onInit();
  }

  void loadRoleData(RoleDetailsModel role) {
    isEdit.value = true;
    roleId = role.data?.id;

    roleController.text = role.data?.roleTitle ?? '';
    roleDescription.text = role.data?.roleDescription ?? '';

    if (role.data?.functionalities is String) {
      selectedFunctionalities.assignAll(
        (role.data?.functionalities ?? '')
            .replaceAll('{', '')
            .replaceAll('}', '')
            .split(","),
      );
    } else if (role.data?.functionalities is List) {
      selectedFunctionalities.assignAll(
        List<String>.from(role.data?.functionalities ?? []),
      );
    }
  }

  Future<void> saveRole() async {
    if (roleController.text.isEmpty || roleDescription.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    isLoading.value = true;

    try {
      if (isEdit.value && roleId != null) {
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
        await roleManagementController.refreshTeam();
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
