// ignore_for_file: type_annotate_public_apis

import 'dart:developer';

import 'package:construction_technect/app/modules/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();
  final argument = Get.arguments;
  final selectedFunctionalities = ''.obs;
  final isLoading = false.obs;
  Rx<GetAllRole> dataModel = GetAllRole().obs;

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

  void loadRoleData(GetAllRole role) {
    isEdit.value = true;
    roleId = role.id;

    roleController.text = role.roleTitle ?? '';
    roleDescription.text = role.roleDescription ?? '';

    selectedFunctionalities.value = role.functionalities ?? '';
  }

  Future<void> saveRole() async {
    if (roleController.text.isEmpty || roleDescription.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    else if(selectedFunctionalities.value.isEmpty){
      Get.snackbar("Error", "Please select functionality");
      return;
    }

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

        if (result != null && result.success) {
          await _refreshRoleManagement();
          Get.back();
          Get.back();
        } else {
          Get.snackbar("Failed", result?.message ?? "Something went wrong");
        }
      } else {
        final result = await RoleService.createRole(
          roleTitle: roleController.text,
          roleDescription: roleDescription.text,
          functionalities: selectedFunctionalities.value,
          isActive: true,
        );

        if (result != null && result.success) {
          await _refreshRoleManagement();
          Get.back();
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
      if (Get.isRegistered<RoleManagementController>()) {
        final roleManagementController = Get.find<RoleManagementController>();
        await roleManagementController.refreshRoles();
      }
    } catch (e) {
      log('RoleManagementController not found: $e');
    }
  }
}
