
// ignore_for_file: prefer_typing_uninitialized_variables, type_annotate_public_apis

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddTeam/service/add_team_service.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/TeamDetails/models/team_detail_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddTeamController extends GetxController {
  final fullNameController = TextEditingController();
  final emialIdController = TextEditingController();
  // ignore: non_constant_identifier_names
  final PhonenumberController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final pinCodeController = TextEditingController();
  final aadharCardController = TextEditingController();
  final panCardController = TextEditingController();
  AddTeamService addTeamService = AddTeamService();
  RxList<String> categories =
      <String>["PanCard", "AadharCard", "DrivingLicen"].obs;

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
  final args = Get.arguments;
  final Rx<TeamDetailsModel> teamDetailsModel = TeamDetailsModel().obs;
  RxBool isEdit = false.obs;
  RxList<GetAllRole> roles = <GetAllRole>[].obs;
  Rx<GetAllRole>? selectedRole = GetAllRole().obs;
  final GetAllRoleService _service = GetAllRoleService();

  @override
  void onInit() {
    if (args != null) {
      teamDetailsModel.value = args['data'];
      isEdit.value = true;
    }
    loadRoles();
    super.onInit();
  }

  Future<void> loadRoles() async {
    try {
      final result = await _service.fetchAllRoles();
      if (result != null && result.success) {
        roles.assignAll(result.data);
        selectedRole!.value = roles.first;
        if(isEdit.value){
          loadTeamData(teamDetailsModel.value);

        }
        await _saveRolesToStorage();

      }
    } finally {}
  }

  Future<void> _saveRolesToStorage() async {
    await myPref.saveRoles(roles.toList());
  }

  void loadTeamData(TeamDetailsModel team) {
    isEdit.value = true;
    teamDetailsModel.value = team;
    fullNameController.text = team.data?.fullName ?? '';
    emialIdController.text = team.data?.emailId ?? '';
    PhonenumberController.text = team.data?.phoneNumber ?? '';
    addressController.text = team.data?.address ?? '';
    stateController.text = team.data?.state ?? '';
    cityController.text = team.data?.city ?? '';
    pinCodeController.text = team.data?.pincode ?? '';
    aadharCardController.text = team.data?.aadharCardNumber ?? '';
    panCardController.text = team.data?.panCardNumber ?? '';
    pickedFileProfilePhotoPath.value = team.data?.profilePhotoUrl ?? '';
    pickedFileAadhaarCardPhotoPath.value = team.data?.aadharCardPhotoUrl ?? '';
    pickedFilePanCardPhotoPath.value = team.data?.panCardPhotoUrl ?? '';
    selectedRole!.value = roles.value.firstWhere(
      (element) => element.id == team.data?.teamRoleId,orElse: () {
        return roles.value.first;
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

  void submitProduct() {
    showExtraFields.value = true;
  }

  void loadSubCategories(String? category) {
    if (category == null) {
      selectedSubCategory.value = null;
      return;
    }

    selectedSubCategory.value = null; // reset on category change
  }

  Future<void> addTeam() async {
    isLoading.value = true;
     Map<String, dynamic> fields ={};
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
    final Map<String, String> selectedFiles = {
      "profile_photo": pickedFileProfilePhotoPath.value,
      "aadhar_card_photo": pickedFileAadhaarCardPhotoPath.value,
      "pan_card_photo": pickedFilePanCardPhotoPath.value,
    };
    try {
      var  addTeamResponse;
      if(isEdit.value){
        addTeamResponse = await addTeamService.updateTeam(
          fields: fields,
          files: selectedFiles,
          id: '${teamDetailsModel.value.data?.id??''}'
        );
      }else {
        addTeamResponse = await addTeamService.addTeam(
          fields: fields,
          files: selectedFiles,
        );
      }
      if (addTeamResponse.success == true) {
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
        SnackBars.errorSnackBar(
          content: addTeamResponse.message ?? 'Something went wrong!!',
        );
      }
    } catch (e) {
      // Error snackbar is already shown by ApiManager
      // No need to show another one here
    }

  }

 Future<void> pickFile(String type) async {
    try {
      final XFile? result = await CommonConstant().filePick();

      if (result != null && result.path.isNotEmpty) {
        final XFile file = result;
        if (type == 'profile_photo') {
          pickedFileProfilePhotoName.value = file.name ?? '';
          pickedFileProfilePhotoPath.value = file.path ?? '';
        }
        if (type == 'aadhar_card_photo') {
          pickedFileAadhaarCardPhotoName.value = file.name ?? '';
          pickedFileAadhaarCardPhotoPath.value = file.path ?? '';
        }
        if (type == 'pan_card_photo') {
          pickedFilePanCardPhotoName.value = file.name ?? '';
          pickedFilePanCardPhotoPath.value = file.path ?? '';
        }

        // addSelectedDocument(certificationType, file);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick file: $e', time: 3);
    }
  }

  void filedValidation() {
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
      SnackBars.errorSnackBar(
        content: 'Address must be at least 10 characters',
      );
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
    } else if (pickedFileProfilePhotoPath.value.isEmpty ) {
      SnackBars.errorSnackBar(
        content: 'Profile photo Photo is required',
      );
    }else if (pickedFileAadhaarCardPhotoPath.value.isEmpty ) {
      SnackBars.errorSnackBar(
        content: 'Aadhar card Photo is required',
      );
    }else if (pickedFilePanCardPhotoPath.value.isEmpty ) {
      SnackBars.errorSnackBar(
        content: 'PAN card Photo is required',
      );
    } else {
      addTeam();
      // Get.toNamed(Routes.APPROVAL_INBOX);
    }
  }
}
