import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {
  final roles = <GetAllRole>[].obs;
  final RxList<TeamListData> teamList = <TeamListData>[].obs;
  final Rx<TeamStatsModel?> teamStats = Rx<TeamStatsModel?>(null);
  final isLoading = false.obs;
  final isLoadingTeam = false.obs;
  final isLoadingTeamStats = false.obs;

  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    super.onInit();
    loadRoles();
    loadTeamList();
    loadTeamStats();
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

  Future<void> loadTeamList() async {
    await _loadTeamFromStorage();
  }

  Future<void> _loadTeamFromStorage() async {
    final cachedTeam = myPref.getTeam();
    if (cachedTeam != null && cachedTeam.isNotEmpty) {
      teamList.assignAll(cachedTeam);
    } else {
      await fetchTeamList();
    }
  }

  Future<void> _saveTeamToStorage() async {
    await myPref.saveTeam(teamList.toList());
  }

  Future<void> fetchTeamList() async {
    try {
      isLoadingTeam.value = true;
      final TeamListModel? result = await _service.fetchAllTeam();
      if (result?.success == true) {
        isLoadingTeam.value = false;
        teamList.clear();
        teamList.value.addAll(result?.data ?? []);
        await _saveTeamToStorage();
      }
    } finally {
      isLoadingTeam.value = false;
    }
  }

  Future<void> loadTeamStats() async {
    await _loadTeamStatsFromStorage();
  }

  Future<void> _loadTeamStatsFromStorage() async {
    final cachedStats = myPref.getTeamStats();
    if (cachedStats != null) {
      teamStats.value = cachedStats;
    } else {
      await fetchTeamStatsOverview();
    }
  }

  Future<void> _saveTeamStatsToStorage() async {
    if (teamStats.value != null) {
      await myPref.saveTeamStats(teamStats.value!);
    }
  }

  Future<void> fetchTeamStatsOverview() async {
    try {
      isLoadingTeamStats.value = true;
      final TeamStatsModel? result = await _service.fetchTeamStatsOverview();
      if (result != null && result.success == true) {
        teamStats.value = result;
        await _saveTeamStatsToStorage();
      }
    } finally {
      isLoadingTeamStats.value = false;
    }
  }

  Future<void> refreshRoles() async {
    await fetchRoles();
  }

  Future<void> refreshTeam() async {
    await fetchTeamList();
  }

  Future<void> refreshTeamStatsOverview() async {
    await fetchTeamStatsOverview();
  }
}
