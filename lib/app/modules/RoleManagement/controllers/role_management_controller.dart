import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {
  final RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<Statistics> statistics = Statistics().obs;

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
  }

  Future<void> loadRoles() async {
    await _loadRolesFromStorage();
  }

  Future<void> _loadRolesFromStorage() async {
    final cachedRoles = myPref.getRoles();
    final getRoleStats = myPref.getRoleStats(); // ✅ use role stats only
    if (cachedRoles != null && cachedRoles.isNotEmpty) {
      if (getRoleStats != null) {
        statistics.value = Statistics(
          totalRoles: getRoleStats.totalRoles,
          activeRoles: getRoleStats.activeRoles,
        );
      }
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
        if (result.statistics != null) {
          statistics.value = result.statistics!;
          await myPref.saveRoleStats(result.statistics!); // ✅ save role stats separately
        }
        await _saveRolesToStorage();
      }
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> refreshRoles() async {
    await fetchRoles();
  }

}
