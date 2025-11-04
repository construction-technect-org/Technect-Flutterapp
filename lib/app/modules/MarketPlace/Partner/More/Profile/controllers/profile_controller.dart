import 'dart:convert';
import 'dart:io';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/services/document_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/services/edit_profile_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  static final ProfileController to = Get.find();

  final isSwitch = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();
  RxString image = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null) {
      isSwitch.value = true;
    }
    businessModel.value.gstinNumber =
        HomeController.to.profileData.value.data?.user?.gst ?? "";
    if (merchantProfile != null) {
      businessModel.value.website = merchantProfile?.website ?? "";
      businessModel.value.businessEmail = merchantProfile?.businessEmail ?? "";
      businessModel.value.year = merchantProfile?.yearsInBusiness != null
          ? merchantProfile?.yearsInBusiness.toString()
          : "";
      businessModel.value.businessContactNumber =
          merchantProfile?.businessContactNumber ?? "";
      businessModel.value.alternativeBusinessEmail =
          merchantProfile?.alternativeBusinessContactNumber ?? "";
      businessModel.value.businessName = merchantProfile?.businessName ?? "";
      businessModel.value.gstinNumber = merchantProfile?.gstinNumber ?? "";
      businessModel.value.image = merchantProfile?.merchantLogo ?? "";

      final timeFormatter = DateFormat.jm();

      businessHoursData.value = businessHours.map((e) {
        String? formattedOpen;
        String? formattedClose;

        if (e.openTime != null && e.openTime!.isNotEmpty) {
          final open = DateFormat("HH:mm:ss").parse(e.openTime!);
          formattedOpen = timeFormatter.format(open);
        }

        if (e.closeTime != null && e.closeTime!.isNotEmpty) {
          final close = DateFormat("HH:mm:ss").parse(e.closeTime!);
          formattedClose = timeFormatter.format(close);
        }

        return {
          "id": e.id,
          "is_open": e.isOpen,
          "day_name": e.dayName,
          "open_time": formattedOpen,
          "close_time": formattedClose,
          "day_of_week": e.dayOfWeek,
        };
      }).toList();

      if (merchantProfile?.documents != null) {
        loadCertificatesFromDocuments(merchantProfile!.documents!);
      }

      // Ensure observers are notified after assigning individual fields
      businessModel.refresh();
    }
  }

  void loadCertificatesFromDocuments(List<Documents> documents) {
    for (final doc in documents) {
      final type = doc.documentType ?? "";
      final name = doc.documentName ?? "";
      final path = doc.filePath;

      if (type == "gst_certificate") {
        certificates[0].filePath = path;
        certificates[0].name = name;
      } else if (type == "udyam_certificate") {
        certificates[1].filePath = path;
        certificates[1].name = name;
      } else if (type == "mtc_certificate") {
        certificates[2].filePath = path;
        certificates[2].name = name;
      } else {
        // Add extra certificates dynamically
        certificates.add(
          CertificateModel(
            title: (doc.documentType ?? type)
                .replaceAll("_", " ")
                .toUpperCase(),
            filePath: path,
            name: doc.documentName ?? "",
          ),
        );
      }
    }

    certificates.refresh();
  }

  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;

  final DocumentService _documentService = DocumentService();

  HomeController get homeController => HomeController.to;

  ProfileModel get profileData => homeController.profileData.value;

  MerchantProfile? get merchantProfile => profileData.data?.merchantProfile;

  UserModel? get userData => profileData.data?.user;

  int get profileCompletionPercentage =>
      merchantProfile?.profileCompletionPercentage ?? 0;

  List<BusinessHours> get businessHours => merchantProfile?.businessHours ?? [];

  List<Documents> get documents => merchantProfile?.documents ?? [];

  List<SiteLocation> get addressData =>
      homeController.profileData.value.data?.siteLocations ?? [];

  String? get businessWebsite => merchantProfile?.businessWebsite;

  String? get currentAddress {
    if (addressData.isNotEmpty) {
      final currentAddress = addressData.first;
      return '${currentAddress.fullAddress ?? ''}, ${currentAddress.landmark ?? ''}';
    }
    return null;
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  String getDocumentDisplayName(String? documentType) {
    return _documentService.getDocumentDisplayName(documentType);
  }

  Future<void> viewDocument(Documents document) async {
    try {
      await _documentService.viewDocument(document);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error opening document: $e');
    }
  }

  Future<void> deleteDocument(int documentId) async {
    try {
      isLoading.value = true;
      final response = await _documentService.deleteDocument(documentId);

      if (response.success == true) {
        SnackBars.successSnackBar(
          content: response.message ?? 'Document deleted successfully',
        );
        await homeController.fetchProfileData();
      } else {
        SnackBars.errorSnackBar(
          content: response.message ?? 'Failed to delete document',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting document: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showDeleteConfirmationDialog(int documentId, String documentName) {
    Get.dialog(
      Dialog(
        backgroundColor: MyColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: DeleteConfirmationDialog(
          title: 'Are you sure?',
          subtitle: 'This cannot be un-done.',
          deleteButtonText: 'Delete document',
          onDelete: () => deleteDocument(documentId),
        ),
      ),
    );
  }

  final certificates = <CertificateModel>[
    CertificateModel(title: "GST Certificate", isDefault: true),
    CertificateModel(title: "MSME/Udyam Certificate", isDefault: true),
    CertificateModel(title: "Pan Certificate", isDefault: true),
  ].obs;

  void addCertificate(String title) {
    certificates.add(CertificateModel(title: title));
  }

  void updateCertificateFile(int index, String filePath) {
    certificates[index].filePath = filePath;
    certificates[index].name = basename(filePath);
    certificates.refresh();
  }

  void removeCertificate(int index) {
    if (index >= 3) {
      certificates.removeAt(index);
      certificates.refresh();
    } else {
      certificates[index].filePath = null;
      certificates.refresh();
    }
  }

  Future<void> pickAndSetCertificateFile(int index) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        const maxSizeInBytes = 2 * 1024 * 1024;

        if (file.size > maxSizeInBytes) {
          SnackBars.errorSnackBar(content: "File size must be less than 2 MB");
          return;
        }

        final fileName = file.name.toLowerCase();
        final fileExtension = fileName.split('.').last;
        final allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

        if (!fileName.contains('.')) {
          SnackBars.errorSnackBar(
            content:
                "Please select a file with a valid extension (PDF, JPG, PNG, DOC, TXT)",
          );
          return;
        }

        final disallowedExtensions = [
          'rtf',
          'odt',
          'xls',
          'xlsx',
          'ppt',
          'pptx',
          'zip',
          'rar',
          'exe',
          'bat',
          'sh',
        ];
        if (disallowedExtensions.contains(fileExtension)) {
          SnackBars.errorSnackBar(
            content:
                "RTF, ODT, and other document files are not allowed. Only PDF, JPG, PNG, DOC, and TXT files are accepted for certificates.",
          );
          return;
        }

        if (!allowedExtensions.contains(fileExtension)) {
          SnackBars.errorSnackBar(
            content:
                "Invalid certificate. Please upload only PDF or image files.",
          );
          return;
        }

        if (file.bytes != null) {
          final bytes = file.bytes!;
          final isValidFile = _validateFileType(bytes, fileExtension);

          if (!isValidFile) {
            SnackBars.errorSnackBar(
              content:
                  "Invalid file format. Please select a valid PDF, JPG, or PNG file",
            );
            return;
          }
        }

        certificates[index].filePath = file.path;
        certificates[index].name = basename(file.path ?? "");
        certificates.refresh();
      } else {
        SnackBars.errorSnackBar(content: "No file selected");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error selecting file: $e");
    }
  }

  Future<String?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      final sizeInBytes = file.size;
      const maxSizeInBytes = 2 * 1024 * 1024; // 2 MB

      if (sizeInBytes > maxSizeInBytes) {
        SnackBars.errorSnackBar(
          content: "File too large,please select a file smaller than 2 MB",
        );
        return null;
      }

      // Robust validation for file extension and MIME type
      final fileName = file.name.toLowerCase();
      final fileExtension = fileName.split('.').last;
      final allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

      // Check if file has an extension
      if (!fileName.contains('.')) {
        SnackBars.errorSnackBar(
          content:
              "Please select a file with a valid extension (PDF, JPG, PNG, DOC, TXT)",
        );
        return null;
      }

      // Check for explicitly disallowed file types
      final disallowedExtensions = [
        'rtf',
        'odt',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
        'zip',
        'rar',
        'exe',
        'bat',
        'sh',
      ];
      if (disallowedExtensions.contains(fileExtension)) {
        SnackBars.errorSnackBar(
          content:
              "RTF, ODT, and other document files are not allowed. Only PDF, JPG, PNG, DOC, and TXT files are accepted for certificates.",
        );
        return null;
      }

      // Check file extension
      if (!allowedExtensions.contains(fileExtension)) {
        SnackBars.errorSnackBar(
          content:
              "Only PDF, JPG, PNG, DOC, and TXT files are allowed for certificates",
        );
        return null;
      }

      // Additional MIME type validation for extra security
      if (file.bytes != null) {
        final bytes = file.bytes!;
        final isValidFile = _validateFileType(bytes, fileExtension);

        if (!isValidFile) {
          SnackBars.errorSnackBar(
            content:
                "Invalid file format. Please select a valid PDF, JPG, or PNG file",
          );
          return null;
        }
      }

      return file.path;
    }

    return null;
  }

  Rx<BusinessModel> businessModel = BusinessModel().obs;

  void handleBusinessHoursData(List<Map<String, dynamic>> data) {
    businessHoursData.value = data;
  }

  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;
  EditProfileService editProfileService = EditProfileService();

  // Validate file type by checking file signatures (magic numbers)
  bool _validateFileType(List<int> bytes, String extension) {
    if (bytes.length < 4) return false;

    // Check file signatures
    switch (extension.toLowerCase()) {
      case 'pdf':
        // PDF files start with %PDF
        final pdfSignature = String.fromCharCodes(bytes.take(4));
        return pdfSignature == '%PDF';

      case 'jpg':
      case 'jpeg':
        // JPEG files start with FF D8 FF
        return bytes.length >= 3 &&
            bytes[0] == 0xFF &&
            bytes[1] == 0xD8 &&
            bytes[2] == 0xFF;

      case 'png':
        // PNG files start with 89 50 4E 47
        return bytes.length >= 4 &&
            bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4E &&
            bytes[3] == 0x47;

      case 'doc':
      case 'docx':
        // DOC/DOCX files have specific signatures
        // DOC files start with D0 CF 11 E0 (OLE signature)
        // DOCX files are ZIP archives with specific structure
        if (bytes.length >= 4) {
          // Check for OLE signature (DOC files)
          if (bytes[0] == 0xD0 &&
              bytes[1] == 0xCF &&
              bytes[2] == 0x11 &&
              bytes[3] == 0xE0) {
            return true;
          }
          // Check for ZIP signature (DOCX files)
          if (bytes[0] == 0x50 &&
              bytes[1] == 0x4B &&
              bytes[2] == 0x03 &&
              bytes[3] == 0x04) {
            return true;
          }
        }
        return false;

      case 'txt':
        // TXT files are plain text, so we'll be more lenient
        // Check if it contains mostly printable ASCII characters
        if (bytes.isEmpty) return true;
        int printableCount = 0;
        for (final int byte in bytes) {
          if (byte >= 32 && byte <= 126 ||
              byte == 9 ||
              byte == 10 ||
              byte == 13) {
            printableCount++;
          }
        }
        return printableCount >=
            (bytes.length * 0.8); // 80% printable characters

      default:
        return false;
    }
  }

  String? _normalizeTime(dynamic time) {
    if (time == null || time.toString().isEmpty) return null;

    // If already in HH:mm format, return as is
    if (RegExp(r'^\d{2}:\d{2}$').hasMatch(time.toString())) {
      return time.toString();
    }

    try {
      final parsed = DateFormat.jm().parse(time.toString()); // parses "9:00 AM"
      return DateFormat.Hm().format(parsed); // converts to "09:00"
    } catch (_) {
      return time.toString(); // fallback, don’t break
    }
  }

  Future<void> handleMerchantData() async {
    try {
      isLoading.value = true;

      final homeController = HomeController.to;
      final merchantProfile =
          homeController.profileData.value.data?.merchantProfile;
      final bool isUpdate;
      if (isSwitch.value) {
        isUpdate = false;
      } else {
        isUpdate = (merchantProfile?.businessEmail != null);
      }

      final formFields = <String, dynamic>{
        'business_name': businessModel.value.businessName.toString(),
        'gstin_number': businessModel.value.gstinNumber.toString(),
        'year_of_established': businessModel.value.year.toString(),
        'business_email': businessModel.value.businessEmail.toString(),
        if ((businessModel.value.alternativeBusinessEmail ?? "").isNotEmpty)
          'alternative_business_contact_number': businessModel
              .value
              .alternativeBusinessEmail
              .toString(),
        'business_contact_number': businessModel.value.businessContactNumber
            .toString(),
        'website': businessModel.value.website.toString(),
        if (!isUpdate)
          'business_hours': json.encode(businessHoursData.toList()),
      };

      final files = <String, String>{};
      if (!(businessModel.value.image ?? "").contains("merchant-logo")) {
        files['merchant_logo'] = businessModel.value.image ?? "";
      }
      if (certificates.isNotEmpty &&
          !(certificates[0].filePath ?? "").startsWith("merchant-documents")) {
        files['gst_certificate'] = certificates[0].filePath!;
      }

      if (certificates.length > 1 &&
          !(certificates[1].filePath ?? "").startsWith("merchant-documents")) {
        files['udyam_certificate'] = certificates[1].filePath!;
      }

      if (certificates.length > 2 &&
          !(certificates[2].filePath ?? "").startsWith("merchant-documents")) {
        files['mtc_certificate'] = certificates[2].filePath!;
      }

      // For any additional certificates
      if (certificates.length > 3) {
        for (var i = 3; i < certificates.length; i++) {
          if (!(certificates[i].filePath ?? "").startsWith(
            "merchant-documents",
          )) {
            files[certificates[i].title] = certificates[i].filePath!;
          }
        }
      }
      final normalizedBusinessHours = businessHoursData.map((day) {
        return {
          "day_of_week": day["day_of_week"],
          "day_name": day["day_name"],
          "is_open": day["is_open"],
          "open_time": _normalizeTime(day["open_time"]),
          "close_time": _normalizeTime(day["close_time"]),
        };
      }).toList();
      formFields['business_hours'] = json.encode(normalizedBusinessHours);

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
          Get.find<CommonController>().hasProfileComplete.value = true;
          if (isUpdate) {
            await homeController.fetchProfileData();
            Get.back();
            SnackBars.successSnackBar(content: "Profile update successfully");
          } else {
            if (isSwitch.value) {
              Get.find<SwitchAccountController>().updateRole(role: "partner");
              myPref.role.val = "partner";
              Get.offAllNamed(Routes.MAIN);
            } else {
              await homeController.fetchProfileData();
              Get.back();
              SnackBars.successSnackBar(content: "Profile update successfully");
            }
          }
        } catch (e) {
          Get.printError(info: 'Could not notify Home controller: $e');
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
      // No Error show
    } finally {
      isLoading.value = false;
    }
  }
}

class CertificateModel {
  final String title;
  String? filePath;
  String? name;
  final bool isDefault;

  CertificateModel({
    required this.title,
    this.filePath,
    this.name,
    this.isDefault = false,
  });
}

class BusinessModel {
  String? businessName;
  String? website;
  String? businessEmail;
  String? alternativeBusinessEmail;
  String? gstinNumber;
  String? year;
  String? address;
  String? businessContactNumber;
  String? image;

  BusinessModel({
    this.businessName,
    this.website,
    this.businessEmail,
    this.gstinNumber,
    this.businessContactNumber,
    this.alternativeBusinessEmail,
    this.address,
    this.year,
    this.image,
  });
}
