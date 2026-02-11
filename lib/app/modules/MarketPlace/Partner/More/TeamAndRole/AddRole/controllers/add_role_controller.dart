import 'package:construction_technect/app/core/utils/permission_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/permissions_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/AddRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/role_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  RxMap<String, List<UserPermissions?>> groupedPermissions =
      <String, List<UserPermissions?>>{}.obs;

  /// selected permission ids
  RxMap<String, bool> selected = <String, bool>{}.obs;
  List<String> finalSelectedIds = <String>[];
  List<String> finalSelectedCode = <String>[];

  int? roleId;
  RxBool isEdit = false.obs;
  final List<PermissionItem> functionalities =
      PermissionLabelUtils.permissionItems;

  Future<void> fetchAllPermissions() async {
    try {
      isLoading.value = true;
      final res = await _addRoleService.getPermisssions("merchant");
      if (res.success == true) {
        userPer.addAll(res.permissions!);
        setPermissions(userPer);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setPermissions(List<UserPermissions?> list) {
    allPermissions.value = list;

    groupByCategory(list);

    /// default unselected
    for (var item in list) {
      selected[item?.id ?? ""] = false;
    }
  }

  void groupByCategory(List<UserPermissions?> list) {
    final Map<String, List<UserPermissions?>> grouped = {};

    for (var item in list) {
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
    finalSelectedIds = selected.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();
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
    var list = groupedPermissions[category];
    if (list == null) return;

    for (var item in list) {
      selected[item!.id ?? ""] = value;
    }
  }

  /// 🔵 select all global
  void selectAll(bool value) {
    for (var item in allPermissions) {
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

    roleController.text = role.roleTitle ?? '';
    roleDescription.text = role.roleDescription ?? '';

    final functionalityValue = role.functionalities ?? '';

    selectedFunctionalities.value = functionalityValue
        .split(',')
        .map((e) => e.trim())
        .toList();
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
