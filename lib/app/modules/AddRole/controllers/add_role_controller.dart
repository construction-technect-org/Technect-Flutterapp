// lib/app/modules/AddRole/controllers/add_role_controller.dart

import 'package:construction_technect/app/modules/AddRole/service/AddRoleService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoleController extends GetxController {
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();

  final selectedFunctionalities = <String>[].obs;
  final isLoading = false.obs;

  // ✅ For edit mode
  int? roleId;
  bool isEdit = false;

void loadRoleData(dynamic role) {
  isEdit = true;
  roleId = role.id;

  roleController.text = role.roleTitle ?? '';
  roleDescription.text = role.roleDescription ?? '';

  // backend functionalities string → List<String>
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

    if (isEdit && roleId != null) {
      /// ✅ Update role API
      final result = await AddRoleService().updateRole(
        roleId: roleId!,
        merchantProfileId: 1, // replace with actual merchant id from session
        roleTitle: roleController.text,
        roleDescription: roleDescription.text,
        functionalities: selectedFunctionalities,
        isActive: true,
      );

      isLoading.value = false;

      if (result != null && result.success) {
        Get.back();
        Get.snackbar("Success", "Role updated successfully!");
      } else {
        Get.snackbar("Failed", result?.message ?? "Something went wrong");
      }
    } else {
      /// ✅ Create role API
      final result = await AddRoleService().createRole(
        merchantProfileId: 1,
        roleTitle: roleController.text,
        roleDescription: roleDescription.text,
        functionalities: selectedFunctionalities,
        isActive: true,
      );

      isLoading.value = false;

      if (result != null && result.success) {
        Get.back();
        Get.snackbar("Success", "Role created successfully!");
      } else {
        Get.snackbar("Failed", result?.message ?? "Something went wrong");
      }
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


