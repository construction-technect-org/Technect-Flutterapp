import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:get/get.dart';

class TeamDetailsController extends GetxController {
  RxString userName = "Mike Junior".obs;
  TeamListData teamDetailsModel = TeamListData();
  RxString teamId = "".obs;
  RxString userEmail = "mike@constructiontechnet.com".obs;
  RxString userRole = "Admin".obs;
  RxString userPhone = "8950482123".obs;
  RxString userAddress =
      "12/45, East Street, Main Chowk, Dattawadi, "
              "Mhasoba Chowk, Near Ajit Super Market, Pune, Maharashtra-411030"
          .obs;
  RxString userStatus = "Active".obs;
  RxString profileUrl = "https://via.placeholder.com/150".obs;

  // Document-related observables
  RxString aadhaarUrl = "".obs;
  RxString panUrl = "".obs;
  RxList<Map<String, String>> documents = <Map<String, String>>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    handlePassedData();
  }

  void handlePassedData() {
    final arguments = Get.arguments;
    if (arguments != null) {
      teamDetailsModel = arguments?['team'] ?? "";
      _updateUIWithTeamData();
    }
  }

  void _updateUIWithTeamData() {
    teamId.value = (teamDetailsModel.id ?? 0).toString();
    userName.value = teamDetailsModel.firstName ?? userName.value;
    userEmail.value = teamDetailsModel.emailId ?? userEmail.value;
    userRole.value = teamDetailsModel.roleTitle ?? userRole.value;
    userPhone.value = teamDetailsModel.mobileNumber ?? userPhone.value;
    profileUrl.value = teamDetailsModel.profilePhotoUrl ?? profileUrl.value;
    userStatus.value = teamDetailsModel.isActive == true ? "Active" : "Inactive";
    documents.clear();
    if (aadhaarUrl.value.isNotEmpty) {
      documents.add({
        "title": "Aadhaar Card",
        "url": aadhaarUrl.value,
        "type": "aadhaar",
      });
    }
    if (panUrl.value.isNotEmpty) {
      documents.add({"title": "PAN Card", "url": panUrl.value, "type": "pan"});
    }
  }
}
