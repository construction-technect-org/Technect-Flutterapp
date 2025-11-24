import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';

class RoleManagementController extends GetxController {
  final RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<Statistics> statistics = Statistics().obs;

  RxBool showRoles = true.obs;

  final Rx<TeamStatsModel?> teamStats = Rx<TeamStatsModel?>(null);
  AddTeamService addTeamService = AddTeamService();
  HomeController homeController = Get.find();
  final isLoading = false.obs;
  final isLoadingTeam = false.obs;
  final isLoadingTeamStats = false.obs;

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
      final result = await GetAllRoleService().fetchAllRoles();
      roles.assignAll(result.data);
      statistics.value = result.statistics!;
      myPref.setRoleModelData(result);
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTeamMember(int teamMemberId) async {
    try {
      isLoadingTeam.value = true;
      await addTeamService.deleteTeamMember(teamMemberId);
      await  Get.find<CommonController>().refreshTeamList();
      await  Get.find<CommonController>().fetchTeamList();
    } catch (e) {
      // ignore: avoid_print
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
      await GetAllRoleService().deleteRole(roleId);
      await fetchRoles();
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }
}
