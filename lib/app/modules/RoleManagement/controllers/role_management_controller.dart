import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {
  final users = [
    {
      "name": "Mike Junior",
      "role": "Owner",
      "email": "mike@constructiontechnet.com",
      "status": "Active",
      "image": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Sarah Lee",
      "role": "Manager",
      "email": "sarah@constructiontechnet.com",
      "status": "Active",
      "image": "https://i.pravatar.cc/150?img=5",
    },
  ].obs;

  final roles = <GetAllRole>[].obs;
  final isLoading = false.obs;

  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    super.onInit();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    await _loadRolesFromStorage();
  }

  Future<void> _loadRolesFromStorage() async {
    final cachedRoles = myPref.getRoles();
    if (cachedRoles != null && cachedRoles.isNotEmpty) {
      roles.assignAll(cachedRoles);
    } else {
      await fetchRoles();
    }
  }

  Future<void> _saveRolesToStorage() async {
    await myPref.saveRoles(roles.toList());
  }

  Future<void> fetchRoles() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAllRoles();
      if (result != null && result.success) {
        roles.assignAll(result.data);
        await _saveRolesToStorage();
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Method to refresh roles when returning from add/edit role screen
  Future<void> refreshRoles() async {
    await fetchRoles();
  }
}
