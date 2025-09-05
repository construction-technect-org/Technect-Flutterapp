import 'dart:convert';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/editProfile/services/EditProfileService.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:file_picker/file_picker.dart';

class EditProfileController extends GetxController {
  final businessNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessContactController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final projectsCompletedController = TextEditingController();

  EditProfileService editProfileService = EditProfileService();

  final scrollController = ScrollController();
  final titleKey = GlobalKey();

  final isLoading = false.obs;

  RxString businessHours = "".obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;

  final currentStep = 1.obs;
  final totalSteps = 2;

  final selectedDocuments = <String, PlatformFile>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _populateExistingData();
  }

  void _populateExistingData() {
    try {
      final homeController = Get.find<HomeController>();
      final merchantProfile = homeController.profileData.value.data?.merchantProfile;

      if (merchantProfile != null) {
        // Populate text fields
        businessNameController.text = merchantProfile.businessName ?? '';
        businessEmailController.text = merchantProfile.businessEmail ?? '';
        businessContactController.text = merchantProfile.businessContactNumber ?? '';
        yearsInBusinessController.text =
            merchantProfile.yearsInBusiness?.toString() ?? '';
        projectsCompletedController.text =
            merchantProfile.projectsCompleted?.toString() ?? '';

        // Populate business hours
        if (merchantProfile.businessHours?.isNotEmpty == true) {
          final hoursList = merchantProfile.businessHours!
              .map(
                (hour) => {
                  'day_of_week': hour.dayOfWeek,
                  'day_name': hour.dayName,
                  'is_open': hour.isOpen,
                  'open_time': hour.openTime,
                  'close_time': hour.closeTime,
                },
              )
              .toList();
          businessHoursData.value = hoursList;
        }
      }
    } catch (e) {
      Get.printError(info: 'Error populating existing data: $e');
    }
  }

  void addBusinessHours(String hours) {
    businessHours.value = hours;
  }

  void handleBusinessHoursData(List<Map<String, dynamic>> data) {
    businessHoursData.value = data;
  }

  void scrollToTitle() {
    final context = titleKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void updateProfile() {
    if (currentStep.value == 1) {
      if (_validateBusinessDetails()) {
        nextStep();
      }
    } else if (currentStep.value == 2) {
      _submitProfile();
    }
  }

  bool _validateBusinessDetails() {
    if (businessNameController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter business name");
      return false;
    }
    if (businessEmailController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter business email");
      return false;
    }
    if (businessContactController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter business contact number");
      return false;
    }
    if (yearsInBusinessController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter years in business");
      return false;
    }
    if (projectsCompletedController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter projects completed");
      return false;
    }
    if (businessHoursData.isEmpty) {
      SnackBars.errorSnackBar(content: "Please set business hours");
      return false;
    }
    return true;
  }

  void _submitProfile() {
    _handleMerchantData();
  }

  Future<void> _handleMerchantData() async {
    try {
      isLoading.value = true;

      // Check if this is update or submit based on merchant ID
      final homeController = Get.find<HomeController>();
      final merchantProfile = homeController.profileData.value.data?.merchantProfile;
      final isUpdate = merchantProfile?.id != null;

      // For new profiles, validate required documents
      if (!isUpdate && (!isDocumentSelected('GST') || !isDocumentSelected('UDYAM'))) {
        SnackBars.errorSnackBar(content: "Please upload all required documents");
        return;
      }

      final formFields = <String, dynamic>{
        'business_name': businessNameController.text.trim(),
        'business_email': businessEmailController.text.trim(),
        'business_contact_number': businessContactController.text.trim(),
        'years_in_business': yearsInBusinessController.text.trim(),
        'projects_completed': projectsCompletedController.text.trim(),
        'business_hours': json.encode(businessHoursData.toList()),
      };

      final files = <String, String>{};
      final gstFile = getSelectedDocument('GST');
      final udyamFile = getSelectedDocument('UDYAM');

      // Only include files if they are newly selected
      if (gstFile?.path != null) {
        files['business_license'] = gstFile!.path!;
      }
      if (udyamFile?.path != null) {
        files['identity_certificate'] = udyamFile!.path!;
      }

      // Call appropriate API based on merchant ID
      final response = isUpdate
          ? await editProfileService.updateMerchantData(
              formFields: formFields,
              files: files.isNotEmpty ? files : null,
            )
          : await editProfileService.submitMerchantData(
              formFields: formFields,
              files: files.isNotEmpty ? files : null,
            );

      if (response['success'] == true) {
        try {
          final commonController = Get.find<CommonController>();

          if (isUpdate) {
            await homeController.fetchProfileData();
            final updatedProfile = homeController.profileData.value.data?.merchantProfile;
            if (updatedProfile?.profileCompletionPercentage != null &&
                updatedProfile!.profileCompletionPercentage! < 80) {
              commonController.hasProfileComplete.value = false;
            }
            if (commonController.hasProfileComplete.value == false) {
              commonController.hasProfileComplete.value = true;
              Get.offAllNamed(Routes.MAIN);
            } else {
              Get.back();
            }
          } else {
            if (commonController.hasProfileComplete.value == false) {
              commonController.hasProfileComplete.value = true;
              Get.offAllNamed(Routes.MAIN);
            } else {
              homeController.onReturnFromEditProfile();
              Get.back();
            }
          }
        } catch (e) {
          Get.printError(info: 'Could not notify home controller: $e');
          Get.back();
        }
      } else {
        SnackBars.errorSnackBar(
          content:
              response['message'] ??
              'Failed to ${isUpdate ? 'update' : 'submit'} profile',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addSelectedDocument(String certificationType, PlatformFile file) {
    selectedDocuments[certificationType] = file;
  }

  PlatformFile? getSelectedDocument(String certificationType) {
    return selectedDocuments[certificationType];
  }

  String? getSelectedDocumentPath(String certificationType) {
    final file = selectedDocuments[certificationType];
    return file?.path;
  }

  String? getSelectedDocumentName(String certificationType) {
    final file = selectedDocuments[certificationType];
    return file?.name;
  }

  bool isDocumentSelected(String certificationType) {
    return selectedDocuments.containsKey(certificationType);
  }

  Future<void> pickFile(String certificationType) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final PlatformFile file = result.files.first;
        addSelectedDocument(certificationType, file);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick file: $e', time: 3);
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToTitle();
    });
  }
}
