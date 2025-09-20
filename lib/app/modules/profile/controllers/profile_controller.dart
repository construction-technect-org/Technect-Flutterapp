import 'dart:convert';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/editProfile/services/EditProfileService.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/profile/services/document_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (merchantProfile != null) {
      businessModel.value.website = merchantProfile?.website.toString();
      businessModel.value.businessEmail = merchantProfile?.businessEmail
          .toString();
      businessModel.value.businessContactNumber = merchantProfile
          ?.businessContactNumber
          .toString();
      businessModel.value.businessName = merchantProfile?.businessName
          .toString();
      print(businessHours);

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
    }
  }

  void loadCertificatesFromDocuments(List<Documents> documents) {
    for (var doc in documents) {
      final type = doc.documentType ?? "";
      final path = doc.filePath;

      if (type == "gst_certificate") {
        certificates[0].filePath = path;
      } else if (type == "udyam_certificate") {
        certificates[1].filePath = path;
      } else if (type == "mtc_certificate") {
        certificates[2].filePath = path;
      } else {
        // Add extra certificates dynamically
        certificates.add(
          CertificateModel(
            title: (doc.documentName ?? type)
                .replaceAll("_", " ")
                .toUpperCase(),
            filePath: path,
          ),
        );
      }
    }

    certificates.refresh();
  }

  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;

  final DocumentService _documentService = DocumentService();

  HomeController get homeController => Get.find<HomeController>();

  ProfileModel get profileData => homeController.profileData.value;

  MerchantProfile? get merchantProfile => profileData.data?.merchantProfile;

  UserModel? get userData => profileData.data?.user;

  int get profileCompletionPercentage =>
      merchantProfile?.profileCompletionPercentage ?? 0;

  List<BusinessHours> get businessHours => merchantProfile?.businessHours ?? [];

  List<Documents> get documents => merchantProfile?.documents ?? [];

  AddressModel get addressData => homeController.addressData;

  String? get businessWebsite => merchantProfile?.businessWebsite;

  String? get currentAddress {
    if (addressData.data?.addresses?.isNotEmpty == true) {
      final currentAddress = addressData.data!.addresses!.first;
      return '${currentAddress.addressLine1 ?? ''}, ${currentAddress.city ?? ''}, ${currentAddress.state ?? ''}';
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
    CertificateModel(title: "Udyam Certificate", isDefault: true),
    CertificateModel(title: "MSME Certificate", isDefault: true),
  ].obs;

  void addCertificate(String title) {
    certificates.add(CertificateModel(title: title));
  }

  void updateCertificateFile(int index, String filePath) {
    certificates[index].filePath = filePath;
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
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        certificates[index].filePath = result.files.first.path;
        certificates.refresh();
      } else {
        SnackBars.errorSnackBar(content: "No file selected");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error selecting file: $e");
    }
  }

  Future<String?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    return result?.files.single.path;
  }

  Rx<BusinessModel> businessModel = BusinessModel().obs;

  void handleBusinessHoursData(List<Map<String, dynamic>> data) {
    businessHoursData.value = data;
  }

  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;
  EditProfileService editProfileService = EditProfileService();

  Future<void> handleMerchantData() async {
    try {
      isLoading.value = true;

      // Check if this is update or submit based on merchant ID
      final homeController = Get.find<HomeController>();
      final merchantProfile =
          homeController.profileData.value.data?.merchantProfile;
      final isUpdate = merchantProfile?.id != null;

      final formFields = <String, dynamic>{
        'business_name': businessModel.value.businessName.toString(),
        'gstin_number': businessModel.value.gstinNumber.toString(),
        'business_email': businessModel.value.businessEmail.toString(),
        'business_contact_number': businessModel.value.businessContactNumber
            .toString(),
        'website': businessModel.value.website.toString(),
        'business_hours': json.encode(businessHoursData.toList()),
      };

      final files = <String, String>{};

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
            files[certificates[i].title ?? "certificate_$i"] =
                certificates[i].filePath!;
          }
        }
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
            final updatedProfile =
                homeController.profileData.value.data?.merchantProfile;
            if (updatedProfile?.profileCompletionPercentage != null &&
                updatedProfile!.profileCompletionPercentage! < 80) {
              commonController.hasProfileComplete.value = false;
            }
            if (commonController.hasProfileComplete.value == false) {
              commonController.hasProfileComplete.value = true;
              Get.offAll(
                    () => SuccessScreen(
                  title: "Success!",
                  header: "Thanks for Connecting !",
                  onTap: () {
                    Get.offAllNamed(Routes.MAIN);

                  },
                ),
              );
            } else {
              Get.back();
            }
          } else {

            if (commonController.hasProfileComplete.value == false) {
              commonController.hasProfileComplete.value = true;
              Get.offAll(
                    () => SuccessScreen(
                  title: "Success!",
                  header: "Thanks for Connecting !",
                  onTap: () {
                    Get.offAllNamed(Routes.MAIN);

                  },
                ),
              );
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
}

class CertificateModel {
  final String title;
  String? filePath;
  final bool isDefault;

  CertificateModel({
    required this.title,
    this.filePath,
    this.isDefault = false,
  });
}

class BusinessModel {
  String? businessName;
  String? website;
  String? businessEmail;
  String? gstinNumber;
  String? address;
  String? businessContactNumber;

  BusinessModel({
    this.businessName,
    this.website,
    this.businessEmail,
    this.gstinNumber,
    this.businessContactNumber,
    this.address,
  });
}
