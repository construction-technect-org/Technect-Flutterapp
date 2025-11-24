import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';

class CRMDashboardController extends GetxController{
  final isLoading = false.obs;
  Rx<ProfileModel> profileData = ProfileModel().obs;

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final profileResponse = await HomeService().getProfile();

      if (profileResponse.success == true &&
          profileResponse.data?.user != null) {
        profileData.value = profileResponse;
        myPref.setProfileData(profileResponse.toJson());
        myPref.setUserModel(profileResponse.data!.user!);

        if ((profileData.value.data?.merchantProfile?.website ?? "")
            .isNotEmpty) {
          Get.find<CommonController>().hasProfileComplete.value = true;
        } else {
          Get.find<CommonController>().hasProfileComplete.value = false;
        }
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxString getCurrentAddress() {
    if (myPref.role.val == "partner") {
      if (profileData.value.data?.addresses?.isNotEmpty == true) {
        final int index =
            profileData.value.data?.addresses?.indexWhere(
                  (e) => e.isDefault == true,
            ) ??
                0;
        final address = profileData.value.data?.addresses?[index];

        return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
      }
      return 'No address found'.obs;
    } else {
      if (profileData.value.data?.siteLocations?.isNotEmpty == true) {
        final int index =
            profileData.value.data?.siteLocations?.indexWhere(
                  (e) => e.isDefault == true,
            ) ??
                0;
        final address = profileData.value.data?.siteLocations?[index];

        return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
      }
      return 'No address found'.obs;
    }
  }

  RxList<TeamListData> teamList = <TeamListData>[].obs;

  Future<void> _loadTeamFromStorage() async {
    final cachedTeamModel = myPref.getTeamModelData();
    if (cachedTeamModel != null &&
        cachedTeamModel.data != null &&
        cachedTeamModel.data!.isNotEmpty) {
      teamList.assignAll(cachedTeamModel.data!);
    } else {
      await fetchTeamList();
    }
  }


  Future<void> fetchTeamList() async {
    try {
      isLoading.value = true;
      final TeamListModel result = await GetAllRoleService().fetchAllTeam();
      teamList.clear();
      teamList.addAll(result.data ?? []);
      myPref.setTeamModelData(result);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfileData();
    _loadTeamFromStorage();
  }
}