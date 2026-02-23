import "dart:developer";

import 'package:construction_technect/app/core/utils/permission_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/UpdatedRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/permissions_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/role_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AddRoleController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final roleController = TextEditingController();
  final roleDescription = TextEditingController();
  final RxList<String> selectedFunctionalities = <String>[].obs;

  final RxList<String> selectedPermissions = <String>[].obs;
  final isLoading = false.obs;
  Rx<GetAllRole> dataModel = GetAllRole().obs;

  final AddRoleService _addRoleService = Get.find<AddRoleService>();

  List<UserPermissions?> userPer = <UserPermissions?>[];
  RxList<UserPermissions?> allPermissions = <UserPermissions?>[].obs;

  /// grouped by category
  RxMap<String, List<UserPermissions?>> groupedPermissions = <String, List<UserPermissions?>>{}.obs;

  /// selected permission ids
  RxMap<String, bool> selected = <String, bool>{}.obs;
  List<String> finalSelectedIds = <String>[];
  List<String> finalSelectedCode = <String>[];

  String? roleId;
  RxBool isEdit = false.obs;
  final List<PermissionItem> functionalities = PermissionLabelUtils.permissionItems;

  Future<void> fetchAllPermissions() async {
    try {
      isLoading.value = true;
      final res = await _addRoleService.getPermisssions("merchant");
      if (res.success == true) {
        userPer.addAll(res.permissions!);
        setPermissions(userPer);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setPermissions(List<UserPermissions?> list) {
    allPermissions.value = list;

    groupByCategory(list);

    /// default unselected
    for (final item in list) {
      selected[item?.id ?? ""] = false;
    }
  }

  void groupByCategory(List<UserPermissions?> list) {
    final Map<String, List<UserPermissions?>> grouped = {};

    for (final item in list) {
      final String key = item?.category ?? "Other";

      if (grouped.containsKey(key)) {
        grouped[key]!.add(item);
      } else {
        grouped[key] = [item];
      }
    }

    groupedPermissions.value = grouped;
  }

  /// 🔵 toggle single permission
  void togglePermission(String id, bool value) {
    selected[id] = value;
  }

  /// 🔵 get selected ids for API
  List<String> getSelectedIds() {
    finalSelectedIds = selected.entries.where((e) => e.value == true).map((e) => e.key).toList();
    return finalSelectedIds;
  }

  List<String> getCodeID() {
    finalSelectedCode.clear();
    for (int j = 0; j < userPer.length; j++) {
      for (int i = 0; i < finalSelectedIds.length; i++) {
        if (finalSelectedIds[i] == userPer[j]!.id) {
          finalSelectedCode.add(userPer[j]!.code!);
          break;
        }
      }
    }
    return finalSelectedCode;
  }

  /// 🔵 select all in category
  void selectAllCategory(String category, bool value) {
    final list = groupedPermissions[category];
    if (list == null) return;

    for (final item in list) {
      selected[item!.id ?? ""] = value;
    }
  }

  /// 🔵 select all global
  void selectAll(bool value) {
    for (final item in allPermissions) {
      selected[item?.id ?? ""] = value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument != null) {
      isEdit.value = argument['isEdit'] ?? false;
      dataModel.value = argument['data'] ?? GetAllRole();
    }
    fetchAllPermissions();
    if (isEdit.value) {
      loadRoleData(dataModel.value);
    }
  }

  void loadRoleData(GetAllRole role) {
    isEdit.value = true;
    roleId = role.id;

    roleController.text = role.roleName ?? '';
    roleDescription.text = role.description ?? '';

    // ✅ Direct List assign karo — split ki zaroorat nahi
    selectedFunctionalities.value = role.permissions ?? [];

    // ✅ Checkboxes pre-select karo
    selected.clear();
    for (final perm in role.permissions ?? []) {
      for (final perms in groupedPermissions.values) {
        for (final p in perms) {
          if (p?.code == perm) {
            selected[p!.id!] = true;
          }
        }
      }
    }
    selected.refresh();
  }

  void toggleFunctionality(String key) {
    if (selectedPermissions.contains(key)) {
      selectedPermissions.remove(key);
    } else {
      selectedPermissions.add(key);
    }
  }

  bool isFunctionalitySelected(String key) {
    return selectedPermissions.contains(key);
  }

  Future<void> saveRole() async {
    if (!formKey.currentState!.validate()) return;

    final selectedCodes = getCodeID();

    if (selectedCodes.isEmpty) {
      Get.rawSnackbar(
        title: "Error",
        message: "Please select at least one permission",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      isLoading.value = true;

      if (isEdit.value && roleId != null && roleId!.isNotEmpty) {
        // ✅ Update Role
        final UpdatedRoleModel result = await RoleService.updateRole(
          roleId: roleId!,
          roleName: roleController.text.trim(),
          description: roleDescription.text.trim(),
          permissions: selectedCodes,
        );

        if (result.success == true) {
          Get.back(result: true);
          Get.rawSnackbar(
            title: "Success",
            message: result.message ?? "Role updated successfully",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        // ✅ Create Role
        final AddRoleModel result = await RoleService.createRole(
          roleName: roleController.text.trim(),
          description: roleDescription.text.trim(),
          permissions: selectedCodes,
        );

        if (result.success == true) {
          Get.back(result: true);
          Get.rawSnackbar(
            title: "Success",
            message: result.message ?? "Role created successfully",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      Get.printError(info: 'saveRole error: $e');
      Get.rawSnackbar(
        title: "Error",
        message: "Something went wrong",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
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
