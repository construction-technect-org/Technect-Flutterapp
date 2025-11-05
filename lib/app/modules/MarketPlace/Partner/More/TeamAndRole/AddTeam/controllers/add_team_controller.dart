import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:image_picker/image_picker.dart';

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
  // Email availability state
  RxString emailError = "".obs;
  RxBool isEmailValidating = false.obs;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(
      File(pickedFile.path),
    );
    selectedImage.value = File(compressedFile.path);
  }

  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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

  Future<void> pickImageBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: MyColors.gray2E),
              title: Text(
                "Camera",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: MyColors.gray2E),
              title: Text(
                "Gallery",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadRolesFromStorage() async {
    final cachedRoles = myPref.getRoles();
    if (cachedRoles != null && cachedRoles.isNotEmpty) {
      roles.assignAll(cachedRoles);
    }
  }

  void loadTeamData() {
    isEdit.value = true;
    fNameController.text = teamDetailsModel.value.firstName ?? '';
    lNameController.text = teamDetailsModel.value.lastName ?? '';
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
    Map<String, String>? files;

    Map<String, dynamic> fields = {};
    if (isEdit.value) {
      if (selectedImage.value != null) {
        files = {'profile_photo': selectedImage.value!.path};
      }
      fields = {
        "first_name": fNameController.text,
        "last_name": lNameController.text,
        "email_id": emialIdController.text,
        "phone_number": phoneNumberController.text,
        "team_role_id": selectedRole?.value.id ?? '',
      };
    } else {
      if (selectedImage.value != null) {
        files = {'profile_photo': selectedImage.value!.path};
      }
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
          files: files,
          id: '${teamDetailsModel.value.id ?? ''}',
        );
        await homeController.refreshTeamList();
        isLoading.value = false;
        Get.back();
      } else {
        await addTeamService.addTeam(fields: fields, files: files);
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

  Future<void> deleteTeamMember(int teamMemberId) async {
    try {
      isLoading.value = true;
      final response = await addTeamService.deleteTeamMember(teamMemberId);

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Team member deleted successfully');
        // Refresh team list in Home controller
        await homeController.refreshTeamList();
        // Also refresh the cached data
        await homeController.fetchTeamList();
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to delete team member',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting team member: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filedValidation() async {
    if (!isEdit.value) {
      await addTeam();
    } else {
      await addTeam();
    }
  }

  Future<void> validateEmailAvailability(String email) async {
    isEmailValidating.value = true;
    emailError.value = await Validate.validateEmailAsync(email) ?? "";
    isEmailValidating.value = false;
  }
}
