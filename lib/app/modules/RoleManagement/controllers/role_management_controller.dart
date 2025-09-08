import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {

  final roles = <GetAllRole>[].obs;
  final RxList<TeamListData> teamList = <TeamListData>[].obs;
  final isLoading = false.obs;
  final isLoadingTeam = false.obs;

  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    super.onInit();
    loadRoles();
    fetchTeamList();
  }

  Future<void> loadRoles() async {
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

  Future<void> fetchTeamList() async {
    try {
      isLoadingTeam.value = true;
      final TeamListModel? result = await _service.fetchAllTeam();
      if (result?.success==true) {
        isLoadingTeam.value=false;
        teamList.clear();
        teamList.value.addAll(result?.data??[]);
      }
    } finally {
      isLoadingTeam.value = false;
    }
  }

  // Method to refresh roles when returning from add/edit role screen
  Future<void> refreshRoles() async {
    await fetchRoles();
  }
}
