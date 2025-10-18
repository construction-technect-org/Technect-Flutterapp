import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

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
}
