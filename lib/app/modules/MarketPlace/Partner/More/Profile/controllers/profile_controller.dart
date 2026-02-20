import 'dart:convert';
import 'dart:io';

import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
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
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';
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

  @override
  void onInit() {
    super.onInit();
    selectedTabIndex.value = 0;
    userMainModel = storage.user;
    if (Get.arguments != null) {
      isSwitch.value = true;
    }
    final merProfile = storage.bizMetrics;

    if (dashboardController.profileResponse.value.merchant != null) {
      businessModel.value.gstinNumber = storage.getNumber ?? '';
      businessModel.value.website = merProfile?["businessWebsite"] ?? '';
      businessModel.value.businessEmail = merProfile?["businessEmail"] ?? '';
      businessModel.value.year = merProfile?['yearOfEstablish'].toString() ?? '';
      businessModel.value.businessContactNumber = merProfile?['businessPhone'] ?? '';

      businessModel.value.businessName = merProfile?["businessName"] ?? '';
      businessModel.value.alternativeBusinessEmail = merProfile?["alternateBusinessPhone"] ?? '';
      //businessModel.value.image =
      //  dashboardController.profileResponse.value.merchant!.logoKey ?? "";

      _merBizHours?.value =
          storage.merchnatBizHours ??
          //dashboardController.profileResponse.value.merchant!.businessHours ??
          null;
      _merBizHours?.refresh();
      if (dashboardController.profileResponse.value.merchant!.businessHours != null) {
        print("Sunday ${_merBizHours?.value?.sunday}");
        businessHoursData1.add({6: _merBizHours?.value?.sunday});
        businessHoursData1.add({0: _merBizHours?.value?.monday});
        businessHoursData1.add({1: _merBizHours?.value?.tuesday});
        businessHoursData1.add({2: _merBizHours?.value?.wednesday});
        businessHoursData1.add({3: _merBizHours?.value?.thursday});
        businessHoursData1.add({4: _merBizHours?.value?.friday});
        businessHoursData1.add({5: _merBizHours?.value?.saturday});
      }
      businessHoursData1.refresh();

      loadMerchantCertificates();
    }
    businessModel.value.gstinNumber = homeController.profileData.value.data?.user?.gst ?? "";
    if (merchantProfile != null) {
      businessModel.value.website = merchantProfile?.website ?? "";
      businessModel.value.businessEmail = merchantProfile?.businessEmail ?? "";
      businessModel.value.year = merchantProfile?.yearsInBusiness != null
          ? merchantProfile?.yearsInBusiness.toString()
          : "";
      businessModel.value.businessContactNumber = merchantProfile?.businessContactNumber ?? "";
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

      businessModel.refresh();
    }
  }

  void refreshBizHours(MerchantBusninessHours? _mer) {
    businessHoursData1.clear();
    print("Sunday ${_mer?.monday?.open}");
    businessHoursData1.add({6: _mer?.sunday});
    businessHoursData1.add({0: _mer?.monday});
    businessHoursData1.add({1: _mer?.tuesday});
    businessHoursData1.add({2: _mer?.wednesday});
    businessHoursData1.add({3: _mer?.thursday});
    businessHoursData1.add({4: _mer?.friday});
    businessHoursData1.add({5: _mer?.saturday});
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
        print("certs in");
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

        print("Certs $certs");
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
  final Rx<MerchantBusninessHours?>? _merBizHours = Rx<MerchantBusninessHours?>(null);

  final HomeService _homeService = Get.find<HomeService>();

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
    String? merchantID, connectorID;

    try {
      //isLoading.value = true;

      print("Hy there ${storage.personaDetail}");
      final PersonaProfileModel? _persona = storage.personaDetail;
      if (_persona == null) {
        print("Yes Null");
      }
      print("Length ${_persona!.personas!.length}");
      for (int i = 0; i < _persona!.personas!.length; i++) {
        print("YEs ${_persona?.personas?[i].profileType}");
        if (_persona?.personas?[i].profileType == "merchant") {
          merchantID = _persona?.personas?[i].profileId;
        } else {
          connectorID = _persona?.personas?[i].profileId;
        }
      }

      if (merchantID != null && merchantID.isNotEmpty) {
        profileResponse1.value = await _homeService.getMerchantProfile(merchantID);
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      //isLoading.value = false;
      print("Fetched");
    }
  }

  Future<void> updateCert(String t, String f) async {
    print("Updtae Ceert");
    try {
      final response = await _homeService.updateCertificates(
        fileName: f,
        title: t,
        profileID: storage.merchantID,
      );
      print("Yes $response");
      if (response) {
        print("Snckbrs");
        //loadMerchantCertificates();
        Get.back(result: true);
        SnackBars.successSnackBar(content: 'Document uploading successful');
      } else {
        print("Snckbrs123");
        SnackBars.errorSnackBar(content: 'Error uploading document');
      }
    } catch (e) {
      print(e);
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
      print(e);
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
    print("Mer Hours ${storage.merchnatBizHours?.monday?.open}");
    _merBizHours?.value = storage.merchnatBizHours;
    _merBizHours?.refresh();
    print("Mer Hours123 ${_merBizHours?.value?.monday?.open}");
    refreshBizHours(_merBizHours?.value);
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
            Get.to(
              () => SuccessScreen(
                title: "Success!",
                header: "Profile update successfully!",
                onTap: () {
                  Get.back();
                  Get.back();
                },
              ),
            );
          } else {
            if (isSwitch.value) {
              Get.find<SwitchAccountController>().updateRole(role: "partner");
              myPref.role.val = "partner";

              Get.offAllNamed(Routes.MAIN);
            } else {
              await homeController.fetchProfileData();
              Get.to(
                () => SuccessScreen(
                  title: "Success!",
                  header: "Profile added successfully!",
                  onTap: () {
                    Get.back();
                    Get.back();
                  },
                ),
              );
            }
          }
        } catch (e) {
          Get.printError(info: 'Could not notify Home controller: $e');
          Get.back();
        }
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to ${isUpdate ? 'update' : 'submit'} profile',
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
