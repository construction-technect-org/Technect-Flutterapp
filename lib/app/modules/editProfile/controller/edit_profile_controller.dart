import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class EditProfileController extends GetxController {
  /// TextEditingControllers
  final businessNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessContactController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final projectsCompletedController = TextEditingController();

  /// Scroll Controller + GlobalKey
  final scrollController = ScrollController();
  final titleKey = GlobalKey();

  RxString businessHours = "".obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;

  final currentStep = 1.obs;
  final totalSteps = 2;

  /// Document selection tracking - stores file objects for API upload
  final selectedDocuments = <String, PlatformFile>{}.obs;

  void addBusinessHours(String hours) {
    businessHours.value = hours;
  }

  /// Handle business hours data from business hours screen
  void handleBusinessHoursData(List<Map<String, dynamic>> data) {
    businessHoursData.value = data;

    // Create display string for business hours
    if (data.isNotEmpty) {
      String displayText = "";
      for (int i = 0; i < data.length; i++) {
        final day = data[i];
        if (day['is_open'] == true) {
          displayText +=
              "${day['day_name']}         ${day['open_time']} - ${day['close_time']}";
        } else {
          displayText += "${day['day_name']}         Closed";
        }
        if (i < data.length - 1) displayText += "\n";
      }
      businessHours.value = displayText;
    }

    Get.printInfo(info: '📅 Business hours updated: ${businessHours.value}');
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
      // Scroll to top when changing steps
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
      // Scroll to top when changing steps
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
    _submitMerchantData();
  }

  /// Submit merchant data to API
  Future<void> _submitMerchantData() async {
    try {
      // Validate required documents
      if (!isDocumentSelected('GST') || !isDocumentSelected('UDYAM')) {
        SnackBars.errorSnackBar(
          content: "Please upload all required documents",
        );
        return;
      }

      // Prepare form data
      final formData = <String, dynamic>{
        'business_name': businessNameController.text.trim(),
        'business_email': businessEmailController.text.trim(),
        'business_contact_number': businessContactController.text.trim(),
        'years_in_business': yearsInBusinessController.text.trim(),
        'projects_completed': projectsCompletedController.text.trim(),
        'business_hours': businessHoursData.toList().toString(),
      };

      // Add files
      final gstFile = getSelectedDocument('GST');
      final udyamFile = getSelectedDocument('UDYAM');

      if (gstFile?.path != null) {
        formData['business_license'] = gstFile!.path;
      }
      if (udyamFile?.path != null) {
        formData['identity_certificate'] = udyamFile!.path;
      }

      // Call API
      final response = await ApiManager().postObject(
        url: APIConstants.merchantSubmit,
        body: formData,
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: "Profile Updated Successfully!");

        // Notify home controller that user is returning from edit profile
        try {
          final homeController = Get.find<HomeController>();
          homeController.onReturnFromEditProfile();
        } catch (e) {
          Get.printError(info: 'Could not notify home controller: $e');
        }

        Get.back(); // Go back to previous screen
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to update profile',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error updating profile: $e');
    }
  }

  /// Add selected document
  void addSelectedDocument(String certificationType, PlatformFile file) {
    selectedDocuments[certificationType] = file;
    Get.printInfo(
      info: '📄 Added document for $certificationType: ${file.name}',
    );
  }

  /// Get selected document
  PlatformFile? getSelectedDocument(String certificationType) {
    return selectedDocuments[certificationType];
  }

  /// Get selected document file path
  String? getSelectedDocumentPath(String certificationType) {
    final file = selectedDocuments[certificationType];
    return file?.path;
  }

  /// Get selected document name
  String? getSelectedDocumentName(String certificationType) {
    final file = selectedDocuments[certificationType];
    return file?.name;
  }

  /// Check if document is selected
  bool isDocumentSelected(String certificationType) {
    return selectedDocuments.containsKey(certificationType);
  }

  /// Pick file using file_picker
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
