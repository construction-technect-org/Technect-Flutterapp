import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddTeamController extends GetxController {
  final fullNameController = TextEditingController();
  final emialIdController = TextEditingController();
  final PhonenumberController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final pinCodeController = TextEditingController();
  final aadharCardController = TextEditingController();
  final panCardController = TextEditingController();
  AddTeamService addTeamService = AddTeamService();
  RxList<String> categories = <String>["PanCard", "AadharCard", "DrivingLicen"].obs;
  RoleManagementController controller = Get.find();

  // Nullable selections
  Rxn<String> selectedCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();

  RxBool showExtraFields = false.obs;
  RxString pickedFileProfilePhotoName = "".obs;
  RxString pickedFileProfilePhotoPath = "".obs;
  RxString pickedFileAadhaarCardPhotoName = "".obs;
  RxString pickedFileAadhaarCardPhotoPath = "".obs;
  RxString pickedFilePanCardPhotoName = "".obs;
  RxString pickedFilePanCardPhotoPath = "".obs;
  RxBool isLoading = false.obs;
  final Rx<TeamListData> teamDetailsModel = TeamListData().obs;
  RxBool isEdit = false.obs;
  RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<GetAllRole>? selectedRole = GetAllRole().obs;

  // Store original photo paths for comparison during updates
  String originalProfilePhotoPath = "";
  String originalAadhaarCardPhotoPath = "";
  String originalPanCardPhotoPath = "";

  @override
  void onInit() {
    _loadRolesFromStorage();
    final arg = Get.arguments;
    if (arg != null) {
      teamDetailsModel.value = arg['data'];
      isEdit.value = true;
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
    fullNameController.text = teamDetailsModel.value.fullName ?? '';
    emialIdController.text = teamDetailsModel.value.emailId ?? '';
    PhonenumberController.text = teamDetailsModel.value.phoneNumber ?? '';
    addressController.text = teamDetailsModel.value.address ?? '';
    stateController.text = teamDetailsModel.value.state ?? '';
    cityController.text = teamDetailsModel.value.city ?? '';
    pinCodeController.text = teamDetailsModel.value.pincode ?? '';
    aadharCardController.text = teamDetailsModel.value.aadharCardNumber ?? '';
    panCardController.text = teamDetailsModel.value.panCardNumber ?? '';
    pickedFileProfilePhotoPath.value = teamDetailsModel.value.profilePhotoUrl ?? '';
    pickedFileAadhaarCardPhotoPath.value =
        teamDetailsModel.value.aadharCardPhotoUrl ?? '';
    pickedFilePanCardPhotoPath.value = teamDetailsModel.value.panCardPhotoUrl ?? '';

    // Store original photo paths for comparison during updates
    originalProfilePhotoPath = teamDetailsModel.value.profilePhotoUrl ?? '';
    originalAadhaarCardPhotoPath = teamDetailsModel.value.aadharCardPhotoUrl ?? '';
    originalPanCardPhotoPath = teamDetailsModel.value.panCardPhotoUrl ?? '';
    selectedRole!.value = roles.firstWhere(
      (element) => element.id == teamDetailsModel.value.teamRoleId,
      orElse: () {
        return roles.first;
      },
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emialIdController.dispose();
    PhonenumberController.dispose();
    addressController.dispose();
    stateController.dispose();
    super.onClose();
  }

  Future<void> addTeam() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    if (isEdit.value) {
      fields = {
        "full_name": fullNameController.text,
        "email_id": emialIdController.text,
        "phone_number": PhonenumberController.text,
        "address": addressController.text,
        "state": stateController.text,
        "city": cityController.text,
        "pincode": pinCodeController.text,
        "aadhar_card_number": aadharCardController.text,
        "pan_card_number": panCardController.text,
        "team_role_id": selectedRole?.value.id ?? '',
        "is_active": "true",
      };
    } else {
      fields = {
        "full_name": fullNameController.text,
        "email_id": emialIdController.text,
        "phone_number": PhonenumberController.text,
        "address": addressController.text,
        "state": stateController.text,
        "city": cityController.text,
        "pincode": pinCodeController.text,
        "aadhar_card_number": aadharCardController.text,
        "pan_card_number": panCardController.text,
        "team_role_id": selectedRole?.value.id ?? '',
        "is_active": "true",
      };
      ;
    }
    Map<String, String> selectedFiles = {};

    if (isEdit.value) {
      // For updates, only include photos that have been changed
      if (pickedFileProfilePhotoPath.value != originalProfilePhotoPath &&
          pickedFileProfilePhotoPath.value.isNotEmpty) {
        selectedFiles["profile_photo"] = pickedFileProfilePhotoPath.value;
      }
      if (pickedFileAadhaarCardPhotoPath.value != originalAadhaarCardPhotoPath &&
          pickedFileAadhaarCardPhotoPath.value.isNotEmpty) {
        selectedFiles["aadhar_card_photo"] = pickedFileAadhaarCardPhotoPath.value;
      }
      if (pickedFilePanCardPhotoPath.value != originalPanCardPhotoPath &&
          pickedFilePanCardPhotoPath.value.isNotEmpty) {
        selectedFiles["pan_card_photo"] = pickedFilePanCardPhotoPath.value;
      }
    } else {
      // For new team members, include all photos
      selectedFiles = {
        "profile_photo": pickedFileProfilePhotoPath.value,
        "aadhar_card_photo": pickedFileAadhaarCardPhotoPath.value,
        "pan_card_photo": pickedFilePanCardPhotoPath.value,
      };
    }
    try {
      if (isEdit.value) {
        await addTeamService.updateTeam(
          fields: fields,
          files: selectedFiles,
          id: '${teamDetailsModel.value.id ?? ''}',
        );
        await controller.fetchTeamList();
        isLoading.value = false;
        Get.back();
        Get.back();
      } else {
        await addTeamService.addTeam(fields: fields, files: selectedFiles);
        await controller.fetchTeamList();
        await controller.fetchTeamStatsOverview();
        isLoading.value = false;
        Get.back();
      }
    } catch (e) {
      // Error snackbar is already shown by ApiManager
    }
  }

  Future<void> pickPhotoFromGallery(String type) async {
    try {
      final XFile? result = await CommonConstant().pickImageFromGallery();

      if (result != null && result.path.isNotEmpty) {
        final XFile file = result;
        if (type == 'profile_photo') {
          pickedFileProfilePhotoName.value = file.name;
          pickedFileProfilePhotoPath.value = file.path;
        }
        if (type == 'aadhar_card_photo') {
          pickedFileAadhaarCardPhotoName.value = file.name;
          pickedFileAadhaarCardPhotoPath.value = file.path;
        }
        if (type == 'pan_card_photo') {
          pickedFilePanCardPhotoName.value = file.name;
          pickedFilePanCardPhotoPath.value = file.path;
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick photo from gallery: $e', time: 3);
    }
  }

  Future<void> filedValidation() async {
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    // Validate Full Name
    if (fullNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Full name is required');
    } else if (fullNameController.text.length < 3) {
      SnackBars.errorSnackBar(content: 'Name must be at least 3 characters');
    } else if (emialIdController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Email is required');
    } else if (!GetUtils.isEmail(emialIdController.text)) {
      SnackBars.errorSnackBar(content: 'Please enter a valid email');
    } else if (PhonenumberController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Phone number is required');
    } else if (!GetUtils.isPhoneNumber(PhonenumberController.text)) {
      SnackBars.errorSnackBar(content: 'Please enter a valid phone number');
    } else if (PhonenumberController.text.length != 10) {
      SnackBars.errorSnackBar(content: 'Phone number must be 10 digits');
    } else if (addressController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Address is required');
    } else if (addressController.text.length < 10) {
      SnackBars.errorSnackBar(content: 'Address must be at least 10 characters');
    } else if (stateController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'State is required');
    } else if (cityController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'City is required');
    } else if (pinCodeController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Pincode is required');
    } else if (!GetUtils.isNumericOnly(pinCodeController.text)) {
      SnackBars.errorSnackBar(content: 'Pincode must contain only numbers');
    } else if (pinCodeController.text.length != 6) {
      SnackBars.errorSnackBar(content: 'Pincode must be 6 digits');
    } else if (aadharCardController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Aadhar card number is required');
    } else if (!GetUtils.isNumericOnly(aadharCardController.text)) {
      SnackBars.errorSnackBar(content: 'Aadhar must contain only numbers');
    } else if (aadharCardController.text.length != 12) {
      SnackBars.errorSnackBar(content: 'Aadhar must be 12 digits');
    } else if (panCardController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'PAN card number is required');
    } else if (panCardController.text.length != 10) {
      SnackBars.errorSnackBar(content: 'PAN must be 10 characters');
    } else if (!panRegex.hasMatch(panCardController.text.toUpperCase())) {
      SnackBars.errorSnackBar(content: 'Please enter a valid PAN number');
    } else if (selectedCategory.value == "") {
      SnackBars.errorSnackBar(content: 'User role is required');
    } else if (!isEdit.value) {
      // Photo validation only for new team members
      if (pickedFileProfilePhotoPath.value.isEmpty) {
        SnackBars.errorSnackBar(content: 'Profile photo Photo is required');
      } else if (pickedFileAadhaarCardPhotoPath.value.isEmpty) {
        SnackBars.errorSnackBar(content: 'Aadhar card Photo is required');
      } else if (pickedFilePanCardPhotoPath.value.isEmpty) {
        SnackBars.errorSnackBar(content: 'PAN card Photo is required');
      } else {
        await addTeam();
      }
    } else {
      // For updates, photos are optional
      await addTeam();
    }
  }
}
