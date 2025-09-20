import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/modules/Connector/AddKyc/models/AddkycModel.dart';
import 'package:construction_technect/app/modules/Connector/AddKyc/services/AddKycService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddKycController extends GetxController {
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();

  final scrollController = ScrollController();
  final isLoading = false.obs;

  final selectedDocuments = <String, PlatformFile>{}.obs;
  final kycService = AddkycService();

  final kycId = RxnInt();
  bool _populatedFromArgs = false;

  @override
  void onInit() {
    super.onInit();
    populateFromArguments(Get.arguments);
  }

  /// Prefill from arguments
  void populateFromArguments(dynamic args) {
    if (_populatedFromArgs) return;
    if (args == null) return;

    if (args is Map && args['kycId'] != null) {
      if (args['kycId'] is int) {
        kycId.value = args['kycId'];
      } else if (args['kycId'] is String) {
        kycId.value = int.tryParse(args['kycId']);
      }

      // Fill text controllers
      aadhaarController.text = args['aadhaar_number'] ?? '';
      panController.text = args['pan_number'] ?? '';

      // Populate existing files for preview
      if (args['aadhaar_front'] != null) selectedDocuments['aadhaarFront'] = PlatformFile(name: 'aadhaar_front', path: args['aadhaar_front'], size: 5);
      if (args['aadhaar_back'] != null) selectedDocuments['aadhaarBack'] = PlatformFile(name: 'aadhaar_back', path: args['aadhaar_back'], size: 5);
      if (args['pan_front'] != null) selectedDocuments['panFront'] = PlatformFile(name: 'pan_front', path: args['pan_front'], size: 5);
      if (args['pan_back'] != null) selectedDocuments['panBack'] = PlatformFile(name: 'pan_back', path: args['pan_back'], size: 5);
    }

    _populatedFromArgs = true;
  }

  /// Pick file
  Future<void> pickFile(String key) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      selectedDocuments[key] = result.files.first;
    } else {
      SnackBars.errorSnackBar(content: "No file selected for $key");
    }
  }

  bool _validateKycDetails() {
    final aadhaar = aadhaarController.text.trim();
    final pan = panController.text.trim();

    final aadhaarReg = RegExp(r'^\d{12}$');
    if (aadhaar.isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter Aadhaar Number");
      return false;
    } else if (!aadhaarReg.hasMatch(aadhaar)) {
      SnackBars.errorSnackBar(content: "Invalid Aadhaar Number. Must be 12 digits");
      return false;
    }

    final panReg = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if (pan.isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter PAN Number");
      return false;
    } else if (!panReg.hasMatch(pan.toUpperCase())) {
      SnackBars.errorSnackBar(content: "Invalid PAN Number");
      return false;
    }

    if (!selectedDocuments.containsKey("aadhaarFront") ||
        !selectedDocuments.containsKey("aadhaarBack") ||
        !selectedDocuments.containsKey("panFront") ||
        !selectedDocuments.containsKey("panBack")) {
      SnackBars.errorSnackBar(content: "Please upload all required KYC documents");
      return false;
    }

    return true;
  }

  Map<String, dynamic> _buildFields() {
    return {
      "aadhaar_number": aadhaarController.text.trim(),
      "pan_number": panController.text.trim(),
    };
  }

  Map<String, String> _buildFiles() {
    final files = <String, String>{};
    if (selectedDocuments.containsKey("aadhaarFront")) files["aadhaar_front"] = selectedDocuments["aadhaarFront"]!.path!;
    if (selectedDocuments.containsKey("aadhaarBack")) files["aadhaar_back"] = selectedDocuments["aadhaarBack"]!.path!;
    if (selectedDocuments.containsKey("panFront")) files["pan_front"] = selectedDocuments["panFront"]!.path!;
    if (selectedDocuments.containsKey("panBack")) files["pan_back"] = selectedDocuments["panBack"]!.path!;
    return files;
  }

  Future<void> proceedKyc() async {
    if (!_validateKycDetails()) return;

    isLoading.value = true;
    try {
      final fields = _buildFields();
      final files = _buildFiles().isNotEmpty ? _buildFiles() : null;

      if (kycId.value != null) {
        final response = await kycService.updateProduct(fields: fields, files: files);
        if (response.success) {
          _setControllers(response.data);
          SnackBars.successSnackBar(content: "KYC Updated Successfully");
          Get.back(result: response.data);
        } else {
          SnackBars.errorSnackBar(content: response.message);
        }
      } else {
        final response = await kycService.connectorCreateProduct(fields: fields, files: files);
        if (response.success) {
          kycId.value = response.data.id;
          _setControllers(response.data);
          SnackBars.successSnackBar(content: "KYC Created Successfully");
          Get.back(result: response.data);
        } else {
          SnackBars.errorSnackBar(content: response.message);
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _setControllers(Addkyc data) {
    aadhaarController.text = data.aadhaarNumber;
    panController.text = data.panNumber;

    if (data.aadhaarFront != null) selectedDocuments['aadhaarFront'] = PlatformFile(name: 'aadhaar_front', path: data.aadhaarFront, size: 5);
    if (data.aadhaarBack != null) selectedDocuments['aadhaarBack'] = PlatformFile(name: 'aadhaar_back', path: data.aadhaarBack, size: 5);
    if (data.panFront != null) selectedDocuments['panFront'] = PlatformFile(name: 'pan_front', path: data.panFront, size: 5);
    if (data.panBack != null) selectedDocuments['panBack'] = PlatformFile(name: 'pan_back', path: data.panBack, size: 5);
  }
}
