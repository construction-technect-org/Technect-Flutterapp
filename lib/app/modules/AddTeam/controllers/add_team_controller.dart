import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class AddTeamController extends GetxController {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emialIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  AddTeamService addTeamService = AddTeamService();
  RoleManagementController roleController = Get.find();
  HomeController homeController = Get.find();
  RxBool isLoading = false.obs;
  final Rx<TeamListData> teamDetailsModel = TeamListData().obs;
  RxBool isEdit = false.obs;
  RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<GetAllRole>? selectedRole = GetAllRole().obs;

  @override
  void onInit() {
    _loadRolesFromStorage();
    final arg = Get.arguments;
    if (arg != null) {
      teamDetailsModel.value = arg['data'];
      loadTeamData();
    }
    super.onInit();
  }

  Future<void> _loadRolesFromStorage() async {
    final cachedRoles = myPref.getRoles();
    if (cachedRoles != null && cachedRoles.isNotEmpty) {
      roles.assignAll(cachedRoles);
    }
  }

  void loadTeamData() {
    isEdit.value = true;
    fNameController.text=teamDetailsModel.value.firstName ?? '';
    lNameController.text=teamDetailsModel.value.lastName ?? '';
    emialIdController.text = teamDetailsModel.value.emailId ?? '';
    phoneNumberController.text = teamDetailsModel.value.mobileNumber ?? '';
    selectedRole!.value = roles.firstWhere(
      (element) => element.id == teamDetailsModel.value.teamRoleId,
      orElse: () {
        return roles.first;
      },
    );
  }

  Future<void> addTeam() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    if (isEdit.value) {
      fields = {
        "first_name": fNameController.text,
        "last_name": lNameController.text,
        "email_id": emialIdController.text,
        "phone_number": phoneNumberController.text,
        "team_role_id": selectedRole?.value.id ?? '',
      };
    } else {
      fields = {
        "first_name": fNameController.text,
        "last_name": lNameController.text,
        "email_id": emialIdController.text,
        "mobile_number": phoneNumberController.text,
        "team_role_id": selectedRole?.value.id ?? '',
      };
    }
    try {
      if (isEdit.value) {
        await addTeamService.updateTeam(
          fields: fields,
          id: '${teamDetailsModel.value.id ?? ''}',
        );
        await homeController.refreshTeamList();
        isLoading.value = false;
        Get.back();
      } else {
        await addTeamService.addTeam(fields: fields,);
        await homeController.refreshTeamList();
        // await roleController.fetchTeamStatsOverview();
        isLoading.value = false;
        Get.back();
      }
    } catch (e) {
      isLoading.value = false;
      // Error snackbar is already shown by ApiManager
    }
  }
  Rxn<String> selectedCategory = Rxn<String>();


  Future<void> filedValidation() async {

    // Validate Full Name
    if (fNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'First name is required');
    } else if (fNameController.text.length < 3) {
      SnackBars.errorSnackBar(content: 'First name must be at least 3 characters');
    }
    if (lNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'First name is required');
    } else if (lNameController.text.length < 2) {
      SnackBars.errorSnackBar(content: 'Last name must be at least 2 characters');
    }
    else if (emialIdController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Email is required');
    } else if (!GetUtils.isEmail(emialIdController.text)) {
      SnackBars.errorSnackBar(content: 'Please enter a valid email');
    } else if (phoneNumberController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Phone number is required');
    } else if (!GetUtils.isPhoneNumber(phoneNumberController.text)) {
      SnackBars.errorSnackBar(content: 'Please enter a valid phone number');
    } else if (phoneNumberController.text.length != 10) {
      SnackBars.errorSnackBar(content: 'Phone number must be 10 digits');
    } else if (selectedCategory.value == "") {
      SnackBars.errorSnackBar(content: 'User role is required');
    } else if (!isEdit.value) {

        await addTeam();

    } else {
      await addTeam();
    }
  }
}
