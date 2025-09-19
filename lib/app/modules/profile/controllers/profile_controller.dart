import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/profile/services/document_service.dart';
import 'package:file_picker/file_picker.dart';

class ProfileController extends GetxController {
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
        SnackBars.errorSnackBar(content: response.message ?? 'Failed to delete document');
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
    certificates.removeAt(index);
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
  String? businessContactNumber;
  int? yearsInBusiness;
  int? projectsCompleted;

  BusinessModel({
     this.businessName,
     this.website,
     this.businessEmail,
     this.gstinNumber,
     this.businessContactNumber,
     this.yearsInBusiness,
     this.projectsCompleted,
  });
}
