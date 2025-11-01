import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

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
      }
    } catch (e) {
      final cachedRoleModel = myPref.getRoleModelData();
      if (cachedRoleModel != null) {
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
      isLoading.value = true;
      final response = await addTeamService.deleteTeamMember(teamMemberId);
      if (response['success'] == true) {
        await homeController.refreshTeamList();
        await homeController.fetchTeamList();
      }
    } catch (e) {
      // No Commit
    } finally {
      isLoading.value = false;
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
        roles.removeWhere((r) => r.id == roleId);
        await _saveRolesToStorage();
        SnackBars.successSnackBar(content: 'Role deleted successfully');
        await fetchRoles();
      } else {
        final message = response != null
            ? (response['message'] ?? 'Failed to delete role')
            : 'Failed to delete role';
        SnackBars.errorSnackBar(content: message);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting role: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
