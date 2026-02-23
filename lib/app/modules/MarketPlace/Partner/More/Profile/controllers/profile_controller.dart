import 'dart:convert';
import "dart:developer";
import 'dart:io';

import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/services/document_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/services/edit_profile_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  UserMainModel? userMainModel;
  final isSwitch = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  int gstCount = 0;
  int msmeCount = 0;
  int panCount = 0;

  final ImagePicker picker = ImagePicker();
  RxString image = "".obs;
  final TextEditingController titleController = TextEditingController();
  RxString filePath = "".obs;

  RxString selectedDD = ''.obs;
  RxString selectedValue = "Manufacturer".obs;
  Rx<MerchantProfileModel> profileResponse = MerchantProfileModel().obs;
  RxList<Cert> certs = <Cert>[].obs;
  RxList<Cert> tempcerts = <Cert>[].obs;
  RxList<Cert> gstCert = <Cert>[].obs;
  RxList<Cert> msmeCert = <Cert>[].obs;
  RxList<Cert> panCert = <Cert>[].obs;

  Rx<MerchantProfileModel> profileResponse1 = MerchantProfileModel().obs;

  Future<void> pickFiles() async {
    final path = await pickFile();
    if (path != null) {
      filePath.value = path;
    }
  }

  final CommonController _commonController = Get.find<CommonController>();
  final HomeService _homeService = Get.find<HomeService>();

  @override
  void onInit() {
    super.onInit();
    selectedTabIndex.value = 0;
    userMainModel = storage.user;
    if (Get.arguments != null) {
      isSwitch.value = true;
    }

    // Fetch profile data directly from API instead of local storage
    fetchProfileSummaryData();
  }

  Future<void> fetchProfileSummaryData() async {
    try {
      isLoading.value = true;

      // Attempt to find the merchant ID from persona mapping
      String? merchantID;
      final personaDet = storage.personaDetail;
      if (personaDet != null && personaDet.personas != null) {
        for (final p in personaDet.personas!) {
          if (p.profileType == "merchant") {
            merchantID = p.profileId;
            break;
          }
        }
      }

      if (merchantID == null || merchantID.isEmpty) {
        log("No merchant profile found for summary fetch.");
        return;
      }

      // 1. Fetch live merchant profile
      final response = await _homeService.getMerchantProfile(merchantID);
      final merchantData = response.merchant;
      if (merchantData == null) return;

      // Update local observables
      profileResponse1.value = response;

      // 2. Map Business Metrics
      businessModel.value.businessName = merchantData.businessName ?? "";
      businessModel.value.website = merchantData.businessWebsite ?? "";
      businessModel.value.businessEmail = merchantData.businessEmail ?? "";
      businessModel.value.alternativeBusinessEmail = merchantData.alternateBusinessPhone ?? "";
      businessModel.value.gstinNumber =
          merchantData.verificationDetails?.gstNumber ?? merchantData.gstinHash ?? "";
      businessModel.value.businessContactNumber = merchantData.businessPhone ?? "";
      businessModel.value.year = merchantData.yearOfEstablish?.toString() ?? "";
      businessModel.value.image = merchantData.logoKey?.url ?? merchantData.logoKey?.key ?? "";

      if (_commonController.profileData.value.data?.user?.gst?.isNotEmpty == true) {
        businessModel.value.gstinNumber = _commonController.profileData.value.data?.user?.gst ?? "";
      }

      businessModel.refresh();

      // 3. Map Business Hours
      if (merchantData.businessHours != null) {
        _merBizHours.value = merchantData.businessHours;
        _merBizHours.refresh();
        refreshBizHours(merchantData.businessHours);
      }

      // 4. Load Certificates
      await loadMerchantCertificates();
    } catch (e, st) {
      log('Error fetching profile summary data: $e, ST: $st');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshBizHours(MerchantBusninessHours? mer) {
    businessHoursData1.clear();
    log("Sunday ${mer?.monday?.open}");
    businessHoursData1.add({6: mer?.sunday});
    businessHoursData1.add({0: mer?.monday});
    businessHoursData1.add({1: mer?.tuesday});
    businessHoursData1.add({2: mer?.wednesday});
    businessHoursData1.add({3: mer?.thursday});
    businessHoursData1.add({4: mer?.friday});
    businessHoursData1.add({5: mer?.saturday});
    businessHoursData1.refresh();
  }

  RxList<Cert> merCert = <Cert>[].obs;

  Future<void> loadMerchantCertificates() async {
    tempcerts.clear();
    certs.clear();
    gstCert.clear();
    msmeCert.clear();
    panCert.clear();
    await certificateFetch();
    if (profileResponse1.value.merchant!.certifications != null) {
      if (profileResponse1.value.merchant!.certifications!.isNotEmpty) {
        log("certs in");
        tempcerts.addAll(profileResponse1.value.merchant!.certifications!);
        for (int i = 0; i < tempcerts.length; i++) {
          if (tempcerts[i].title == "GST Certificate") {
            gstCert.add(tempcerts[i]);
          }
          if (tempcerts[i].title == "MSME/Udyam Certificate") {
            msmeCert.add(tempcerts[i]);
          }
          if (tempcerts[i].title == "Pan Certificate") {
            panCert.add(tempcerts[i]);
          }
        }
        if (gstCert.isEmpty) {
          certs.add(Cert(title: "GST Certificate"));
        } else {
          certs.add(gstCert[0]);
        }
        if (msmeCert.isEmpty) {
          certs.add(Cert(title: "MSME/Udyam Certificate"));
        } else {
          certs.add(msmeCert[0]);
        }
        if (panCert.isEmpty) {
          certs.add(Cert(title: "Pan Certificate"));
        } else {
          certs.add(panCert[0]);
        }
        for (int i = 0; i < tempcerts.length; i++) {
          if (tempcerts[i].title == "GST Certificate" ||
              tempcerts[i].title == "MSME/Udyam Certificate" ||
              tempcerts[i].title == "Pan Certificate") {
            continue;
          } else {
            certs.add(tempcerts[i]);
          }
        }

        log("Certs $certs");
      } else {
        certs.add(Cert(title: "GST Certificate"));
        certs.add(Cert(title: "MSME/Udyam Certificate"));
        certs.add(Cert(title: "Pan Certificate"));
      }

      // Update jsonCert and certificates to sync with certs length
      jsonCert.clear();
      certificates.clear();
      for (int i = 0; i < certs.length; i++) {
        jsonCert.add(
          AllCertificateModel(title: certs[i].title ?? "", filePath: certs[i].url ?? ""),
        );
        certificates.add(
          CertificateModel(
            title: certs[i].title ?? "",
            filePath: certs[i].url,
            name: certs[i].originalName,
            isDefault: i < 3,
          ),
        );
      }

      certs.refresh();
      jsonCert.refresh();
      certificates.refresh();
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
        certificates.add(
          CertificateModel(
            title: (doc.documentType ?? type).replaceAll("_", " ").toUpperCase(),
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
  final Rx<MerchantBusninessHours?> _merBizHours = Rx<MerchantBusninessHours?>(null);

  CommonController get homeController => Get.find<CommonController>();

  DashBoardController get dashboardController => Get.find<DashBoardController>();

  ProfileModel get profileData => homeController.profileData.value;

  MerchantProfile? get merchantProfile => profileData.data?.merchantProfile;

  UserModel? get userData => profileData.data?.user;

  int get profileCompletionPercentage => merchantProfile?.profileCompletionPercentage ?? 0;

  List<BusinessHours> get businessHours => merchantProfile?.businessHours ?? [];

  List<Documents> get documents => merchantProfile?.documents ?? [];

  List<SiteLocation> get addressData =>
      Get.find<CommonController>().profileData.value.data?.siteLocations ?? [];

  String? get businessWebsite => merchantProfile?.businessWebsite;

  String? get currentAddress {
    if (addressData.isNotEmpty) {
      final currentAddress = addressData.first;
      return '${currentAddress.fullAddress ?? ''}, ${currentAddress.landmark ?? ''}';
    }
    return null;
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

  Future<void> certificateFetch() async {
    String? merchantID;
    // String? connectorID;

    try {
      //isLoading.value = true;

      log("Hy there ${storage.personaDetail}");
      final PersonaProfileModel? persona = storage.personaDetail;
      if (persona == null) {
        log("Yes Null");
      }
      log("Length ${persona!.personas!.length}");
      for (int i = 0; i < (persona.personas?.length ?? 0); i++) {
        if (persona.personas?[i].profileType == "merchant") {
          merchantID = persona.personas?[i].profileId;
        }
      }

      if (merchantID != null && merchantID.isNotEmpty) {
        profileResponse1.value = await _homeService.getMerchantProfile(merchantID);
      }
    } catch (e) {
      log('Error fetching profile: $e');
    } finally {
      //isLoading.value = false;
      log("Fetched");
    }
  }

  Future<void> updateCert(String t, String f) async {
    log("Updtae Ceert");
    try {
      final response = await _homeService.updateCertificates(
        fileName: f,
        title: t,
        profileID: storage.merchantID,
      );
      log("Yes $response");
      if (response) {
        log("Snckbrs");
        //loadMerchantCertificates();
        Get.back(result: true);
        SnackBars.successSnackBar(content: 'Document uploading successful');
      } else {
        log("Snckbrs123");
        SnackBars.errorSnackBar(content: 'Error uploading document');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Uploads all locally-selected certificate files to the server.
  /// Only uploads certificates whose [filePath] is a local path (not an http URL).
  /// Returns true if all uploads succeeded (or there was nothing to upload).
  Future<bool> uploadPendingCertificates() async {
    try {
      isLoading.value = true;

      // Collect certificates that have a NEW local file (not already uploaded)
      final toUpload = <CertificateModel>[];
      for (final cert in certificates) {
        final path = cert.filePath;
        if (path != null &&
            path.isNotEmpty &&
            !path.startsWith('http') &&
            !path.startsWith('https')) {
          toUpload.add(cert);
        }
      }

      if (toUpload.isEmpty) {
        // Nothing new to upload — allow proceeding to next tab
        return true;
      }

      int successCount = 0;
      for (final cert in toUpload) {
        final success = await _homeService.updateCertificates(
          fileName: cert.filePath!,
          title: cert.title,
          profileID: storage.merchantID,
        );
        if (success) {
          successCount++;
        } else {
          SnackBars.errorSnackBar(content: 'Failed to upload "${cert.title}". Please try again.');
          return false;
        }
      }

      if (successCount > 0) {
        SnackBars.successSnackBar(content: '$successCount certificate(s) uploaded successfully.');
        // Refresh the certificate list from the server
        await loadMerchantCertificates();
      }

      return true;
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error uploading certificates: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDocument(int documentId) async {
    try {
      isLoading.value = true;
      final response = await _documentService.deleteDocument(documentId);

      if (response.success == true) {
        SnackBars.successSnackBar(content: response.message ?? 'Document deleted successfully');
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

  RxList<AllCertificateModel> jsonCert = <AllCertificateModel>[].obs;

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

  Future<void> removeCertificate(int index) async {
    try {
      final response = await _homeService.deleteCertificate(
        profileType: "merchant",
        profileID: storage.merchantID,
        certKey: certs[index].key!,
      );
      if (response) {
        SnackBars.successSnackBar(content: "Successfully deleted the certificate");
      } else {
        SnackBars.errorSnackBar(content: "Deletion of certificate failed");
      }
      if (index >= 3) {
        certs.removeAt(index);
        certs.refresh();
      } else {
        certs[index].url = null;
        certs.refresh();
      }
    } catch (e) {
      log(e.toString());
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
            content: "Please select a file with a valid extension (PDF, JPG, PNG, DOC, TXT)",
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
            content: "Invalid certificate. Please upload only PDF or image files.",
          );
          return;
        }

        if (file.bytes != null) {
          final bytes = file.bytes!;
          final isValidFile = _validateFileType(bytes, fileExtension);

          if (!isValidFile) {
            SnackBars.errorSnackBar(
              content: "Invalid file format. Please select a valid PDF, JPG, or PNG file",
            );
            return;
          }
        }

        // Ensure lists are large enough to prevent RangeError
        while (jsonCert.length <= index) {
          jsonCert.add(AllCertificateModel(title: "", filePath: ""));
        }
        while (certificates.length <= index) {
          certificates.add(
            CertificateModel(title: certs.length > index ? certs[index].title ?? "" : ""),
          );
        }

        jsonCert[index].title = basename(file.path ?? "");
        jsonCert[index].filePath = file.path!;
        jsonCert.refresh();

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
        SnackBars.errorSnackBar(content: "File too large,please select a file smaller than 2 MB");
        return null;
      }

      final fileName = file.name.toLowerCase();
      final fileExtension = fileName.split('.').last;
      final allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

      if (!fileName.contains('.')) {
        SnackBars.errorSnackBar(
          content: "Please select a file with a valid extension (PDF, JPG, PNG, DOC, TXT)",
        );
        return null;
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
        return null;
      }

      if (!allowedExtensions.contains(fileExtension)) {
        SnackBars.errorSnackBar(
          content: "Only PDF, JPG, PNG, DOC, and TXT files are allowed for certificates",
        );
        return null;
      }

      if (file.bytes != null) {
        final bytes = file.bytes!;
        final isValidFile = _validateFileType(bytes, fileExtension);

        if (!isValidFile) {
          SnackBars.errorSnackBar(
            content: "Invalid file format. Please select a valid PDF, JPG, or PNG file",
          );
          return null;
        }
      }

      return file.path;
    }

    return null;
  }

  Rx<BusinessModel> businessModel = BusinessModel().obs;

  void handleBusinessHoursData() {
    log("Mer Hours ${storage.merchnatBizHours?.monday?.open}");
    _merBizHours.value = storage.merchnatBizHours;
    _merBizHours.refresh();
    log("Mer Hours123 ${_merBizHours.value?.monday?.open}");
    refreshBizHours(_merBizHours.value);
  }

  RxList<Map<int, MerchantDay?>> businessHoursData1 = <Map<int, MerchantDay?>>[].obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;
  EditProfileService editProfileService = EditProfileService();

  bool _validateFileType(List<int> bytes, String extension) {
    if (bytes.length < 4) return false;

    switch (extension.toLowerCase()) {
      case 'pdf':
        final pdfSignature = String.fromCharCodes(bytes.take(4));
        return pdfSignature == '%PDF';

      case 'jpg':
      case 'jpeg':
        return bytes.length >= 3 && bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;

      case 'png':
        return bytes.length >= 4 &&
            bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4E &&
            bytes[3] == 0x47;

      case 'doc':
      case 'docx':
        if (bytes.length >= 4) {
          if (bytes[0] == 0xD0 && bytes[1] == 0xCF && bytes[2] == 0x11 && bytes[3] == 0xE0) {
            return true;
          }
          if (bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x03 && bytes[3] == 0x04) {
            return true;
          }
        }
        return false;

      case 'txt':
        if (bytes.isEmpty) return true;
        int printableCount = 0;
        for (final int byte in bytes) {
          if (byte >= 32 && byte <= 126 || byte == 9 || byte == 10 || byte == 13) {
            printableCount++;
          }
        }
        return printableCount >= (bytes.length * 0.8);

      default:
        return false;
    }
  }

  String? _normalizeTime(dynamic time) {
    if (time == null || time.toString().isEmpty) return null;

    if (RegExp(r'^\d{2}:\d{2}$').hasMatch(time.toString())) {
      return time.toString();
    }

    try {
      final parsed = DateFormat.jm().parse(time.toString());
      return DateFormat.Hm().format(parsed);
    } catch (_) {
      return time.toString();
    }
  }

  Future<void> handleMerchantData() async {
    try {
      isLoading.value = true;

      final homeController = Get.find<CommonController>();
      final merchantProfile = homeController.profileData.value.data?.merchantProfile;
      final bool isUpdate;
      if (isSwitch.value) {
        isUpdate = false;
      } else {
        isUpdate = (merchantProfile?.businessEmail != null);
      }

      final formFields = <String, dynamic>{
        'business_name': businessModel.value.businessName ?? "",
        'gstin_number': businessModel.value.gstinNumber ?? "",
        'year_of_established': businessModel.value.year ?? "",
        'business_email': businessModel.value.businessEmail ?? "",
        if ((businessModel.value.alternativeBusinessEmail ?? "").isNotEmpty)
          'alternative_business_contact_number': businessModel.value.alternativeBusinessEmail ?? "",
        'business_contact_number': businessModel.value.businessContactNumber ?? "",
        'website': businessModel.value.website ?? "",
        'gstCount': gstCount.toString(),
        'msmeCount': msmeCount.toString(),
        'panCount': panCount.toString(),
      };

      final files = <String, String>{};
      final merchantLogo = businessModel.value.image ?? "";
      if (merchantLogo.isNotEmpty && !merchantLogo.contains("merchant-logo")) {
        files['merchant_logo'] = merchantLogo;
      }

      if (certificates.isNotEmpty &&
          (certificates[0].filePath ?? "").isNotEmpty &&
          !certificates[0].filePath!.startsWith("merchant-documents")) {
        files['gst_certificate'] = certificates[0].filePath!;
      }

      if (certificates.length > 1 &&
          (certificates[1].filePath ?? "").isNotEmpty &&
          !certificates[1].filePath!.startsWith("merchant-documents")) {
        files['udyam_certificate'] = certificates[1].filePath!;
      }

      if (certificates.length > 2 &&
          (certificates[2].filePath ?? "").isNotEmpty &&
          !certificates[2].filePath!.startsWith("merchant-documents")) {
        files['mtc_certificate'] = certificates[2].filePath!;
      }

      if (certificates.length > 3) {
        for (var i = 3; i < certificates.length; i++) {
          final certPath = certificates[i].filePath ?? "";
          if (certPath.isNotEmpty && !certPath.startsWith("merchant-documents")) {
            files[certificates[i].title] = certPath;
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

      // final response = isUpdate
      //     ? await editProfileService.updateMerchantData(
      //         formFields: formFields,
      //         files: files.isNotEmpty ? files : null,
      //       )
      //     : await editProfileService.submitMerchantData(
      //         formFields: formFields,
      //         files: files.isNotEmpty ? files : null,
      //       );

      // if (response['success'] == true) {
      //   try {
      //     Get.find<CommonController>().hasProfileComplete.value = true;
      //     if (isUpdate) {
      //       await homeController.fetchProfileData();
      //       Get.to(
      //         () => SuccessScreen(
      //           title: "Success!",
      //           header: "Profile update successfully!",
      //           onTap: () {
      //             Get.back();
      //             Get.back();
      //           },
      //         ),
      //       );
      //     } else {
      //       if (isSwitch.value) {
      //         Get.find<SwitchAccountController>().updateRole(role: "partner");
      //         myPref.role.val = "partner";

      //         Get.offAllNamed(Routes.MAIN);
      //       } else {
      //         await homeController.fetchProfileData();
      //         Get.to(
      //           () => SuccessScreen(
      //             title: "Success!",
      //             header: "Profile added successfully!",
      //             onTap: () {
      //               Get.back();
      //               Get.back();
      //             },
      //           ),
      //         );
      //       }
      //     }
      //   } catch (e) {
      //     log( 'Could not notify Home controller: $e');
      //     Get.back();
      //   }
      // } else {
      //   SnackBars.errorSnackBar(
      //     content: response['message'] ?? 'Failed to ${isUpdate ? 'update' : 'submit'} profile',
      //   );
      // }
      Get.back();
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

  CertificateModel({required this.title, this.filePath, this.name, this.isDefault = false});
}

class AllCertificateModel {
  String title;
  String filePath;

  AllCertificateModel({required this.title, required this.filePath});
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
