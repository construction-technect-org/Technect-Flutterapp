import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';

class RoleManagementController extends GetxController {
  static final RoleManagementController to = Get.find();

  final RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<Statistics> statistics = Statistics().obs;

  RxBool showRoles = true.obs;

  final Rx<TeamStatsModel?> teamStats = Rx<TeamStatsModel?>(null);
  AddTeamService addTeamService = AddTeamService();
  HomeController homeController = Get.find();
  final isLoading = false.obs;
  final isLoadingTeam = false.obs;
  final isLoadingTeamStats = false.obs;

  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      showRoles.value = Get.arguments["isRole"] ?? true;
    }
    loadRoles();
  }

  Future<void> loadRoles() async {
    await _loadRolesFromStorage();
  }

  Future<void> _loadRolesFromStorage() async {
    final cachedRoleModel = myPref.getRoleModelData();
    if (cachedRoleModel != null && cachedRoleModel.data.isNotEmpty) {
      roles.assignAll(cachedRoleModel.data);
      if (cachedRoleModel.statistics != null) {
        statistics.value = cachedRoleModel.statistics!;
      }
      // Still fetch from API in background to ensure data is up-to-date
      fetchRoles();
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
        }
        myPref.setRoleModelData(result);
      } else if (result != null && !result.success) {
        // API returned error - use cache if available
        final cachedRoleModel = myPref.getRoleModelData();
        if (cachedRoleModel != null && cachedRoleModel.data.isNotEmpty) {
          roles.assignAll(cachedRoleModel.data);
          if (cachedRoleModel.statistics != null) {
            statistics.value = cachedRoleModel.statistics!;
          }
        }
      } else {
        // Null response - use cache if available
        final cachedRoleModel = myPref.getRoleModelData();
        if (cachedRoleModel != null && cachedRoleModel.data.isNotEmpty) {
          roles.assignAll(cachedRoleModel.data);
          if (cachedRoleModel.statistics != null) {
            statistics.value = cachedRoleModel.statistics!;
          }
        }
      }
    } catch (e) {
      final cachedRoleModel = myPref.getRoleModelData();
      if (cachedRoleModel != null && cachedRoleModel.data.isNotEmpty) {
        roles.assignAll(cachedRoleModel.data);
        if (cachedRoleModel.statistics != null) {
          statistics.value = cachedRoleModel.statistics!;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTeamMember(int teamMemberId) async {
    try {
      isLoadingTeam.value = true;
      final response = await addTeamService.deleteTeamMember(teamMemberId);
      if (response['success'] == true) {
        await homeController.refreshTeamList();
        await homeController.fetchTeamList();
        SnackBars.successSnackBar(content: 'Team member deleted successfully');
      } else {
        final message = response['message'] ?? 'Failed to delete team member';
        SnackBars.errorSnackBar(content: message);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting team member: $e');
    } finally {
      isLoadingTeam.value = false;
    }
  }

  Future<void> refreshRoles() async {
    await fetchRoles();
  }

  Future<void> deleteRole(int roleId) async {
    try {
      isLoading.value = true;
      final response = await _service.deleteRole(roleId);
      if (response != null &&
          (response['success'] == true || response['status'] == true)) {
        // Remove from local list immediately - create new list to trigger UI update
        final updatedRoles = roles.where((r) => r.id != roleId).toList();

        // Update statistics - create new instance to trigger reactivity
        final currentStats = statistics.value;
        final currentTotal = int.tryParse(currentStats.totalRoles ?? '0') ?? 0;
        final newTotal = currentTotal > 0 ? currentTotal - 1 : 0;

        // Create new Statistics instance to trigger observable update
        statistics.value = Statistics(
          totalRoles: newTotal.toString(),
          activeRoles: newTotal.toString(),
          openTickets: currentStats.openTickets,
          closedTickets: currentStats.closedTickets,
          inProgressTickets: currentStats.inProgressTickets,
          resolvedTickets: currentStats.resolvedTickets,
          totalTeamMember: currentStats.totalTeamMember,
          activeTeamMember: currentStats.activeTeamMember,
          avgResponse: currentStats.avgResponse,
        );

        // CRITICAL: Update the roles list FIRST while loading is still true
        // This ensures the list is updated before UI rebuilds
        roles.assignAll(updatedRoles);

        // Set loading to false - this will trigger Obx to rebuild and show updated list
        isLoading.value = false;

        // Update cache and storage in background (async)
        final updatedModel = GetAllRoleModel(
          success: true,
          data: updatedRoles,
          message: 'Role deleted successfully',
          statistics: statistics.value,
        );
        myPref.setRoleModelData(updatedModel);
        await _saveRolesToStorage();

        SnackBars.successSnackBar(content: 'Role deleted successfully');

        // Don't refresh from API immediately - the local state is already correct
        // The next manual refresh or screen reload will sync with server
      } else {
        final message = response != null
            ? (response['message'] ?? 'Failed to delete role')
            : 'Failed to delete role';
        SnackBars.errorSnackBar(content: message);
        isLoading.value = false;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting role: $e');
      isLoading.value = false;
    }
  }
}
