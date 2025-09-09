import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {
  final RxList<GetAllRole> roles = <GetAllRole>[].obs;
  final Rx<TeamStatsModel?> teamStats = Rx<TeamStatsModel?>(null);
  HomeController homeController = Get.find();
  final isLoading = false.obs;
  final isLoadingTeam = false.obs;
  final isLoadingTeamStats = false.obs;

  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    super.onInit();
    loadRoles();
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

  Future<void> refreshTeamStatsOverview() async {
    await fetchTeamStatsOverview();
  }
}
