import 'package:get/get.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../Service/team_detail_service.dart';
import '../models/team_detail_model.dart';

class TeamDetailsController extends GetxController {
  /// Reactive data
  RxString userName = "Mike Junior".obs;
  TeamDetailsModel? teamDetailsModel;
  RxString teamId = "".obs;
  RxString userEmail = "mike@constructiontechnet.com".obs;
  RxString userRole = "Admin".obs;
  RxString userPhone = "8950482123".obs;
  RxString userAddress = "12/45, East Street, Main Chowk, Dattawadi, "
      "Mhasoba Chowk, Near Ajit Super Market, Pune, Maharashtra-411030".obs;
  RxString userStatus = "Active".obs;
  RxString profileUrl = "https://via.placeholder.com/150".obs;

  // Document-related observables
  RxString aadhaarUrl = "".obs;
  RxString panUrl = "".obs;
  RxList<Map<String, String>> documents = <Map<String, String>>[].obs;

  RxBool isLoading = false.obs;

  // Create instance of service
  TeamDetailsService teamDetailsService = TeamDetailsService();

  @override
  void onInit() {
    super.onInit();
    handlePassedData();
  }

  void handlePassedData() {
    final arguments = Get.arguments;
    teamId.value = arguments?['team_id']?.toString() ?? "";

    if (teamId.value.isNotEmpty) {
      teamDetail();
    } else {
      SnackBars.errorSnackBar(content: "No team ID provided");
    }
  }

  Future<void> teamDetail() async {
    isLoading.value = true;
    try {
      // Call instance method instead of static method
      final teamDetails = await teamDetailsService.teamDetail(teamId.value);

      if (teamDetails.success == true) {
        teamDetailsModel = teamDetails;

        // Update UI with actual API data
        _updateUIWithTeamData();

      } else {
        SnackBars.errorSnackBar(
          content: 'Failed to load team details',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(
        content: 'Failed to fetch team details: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _updateUIWithTeamData() {
    if (teamDetailsModel?.data != null) {
      final data = teamDetailsModel!.data!;

      // Update user information
      userName.value = data.fullName ?? userName.value;
      userEmail.value = data.emailId ?? userEmail.value;
      userRole.value = data.roleTitle ?? userRole.value;
      userPhone.value = data.phoneNumber ?? userPhone.value;
      userAddress.value = data.address ?? userAddress.value;
      profileUrl.value = data.profilePhotoUrl ?? profileUrl.value;
      userStatus.value = data.isActive == true ? "Active" : "Inactive";

      // Update document information
      aadhaarUrl.value = data.aadharCardPhotoUrl ?? "";
      panUrl.value = data.panCardPhotoUrl ?? "";

      // Update documents list for UI
      documents.clear();
      if (aadhaarUrl.value.isNotEmpty) {
        documents.add({
          "title": "Aadhaar Card",
          "url": aadhaarUrl.value,
          "type": "aadhaar"
        });
      }
      if (panUrl.value.isNotEmpty) {
        documents.add({
          "title": "PAN Card",
          "url": panUrl.value,
          "type": "pan"
        });
      }
    }
  }

  // Refresh team details
  Future<void> refreshTeamDetails() async {
    if (teamId.value.isNotEmpty) {
      await teamDetail();
    }
  }
}