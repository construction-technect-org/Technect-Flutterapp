import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/profile/services/document_service.dart';

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
}
