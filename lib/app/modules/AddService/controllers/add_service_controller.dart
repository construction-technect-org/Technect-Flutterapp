import 'dart:developer';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ServiceManagement/controllers/service_management_controller.dart';
import 'package:construction_technect/app/modules/ServiceManagement/model/service_model.dart';
import 'package:construction_technect/app/modules/ServiceManagement/service/service_management_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceController extends GetxController {
  final pageController = PageController();
  Service service = Service();
  ServiceManagementController controller = Get.find();

  // ---------------- Form Controllers ----------------
  final serviceNameController = TextEditingController();
  final uomController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();
  final descriptionController = TextEditingController();

  // ---------------- DropDown Data ----------------
  RxList<ServiceType> serviceTypes = <ServiceType>[].obs;
  RxList<ServiceDropdown> servicesList = <ServiceDropdown>[].obs;

  // Reactive name lists for dropdowns
  RxList<String> serviceTypeNames = <String>[].obs;
  RxList<String> serviceNames = <String>[].obs;

  RxList<String> uomList = <String>["Hour", "Day", "Week", "Month", "Project"].obs;

  // ---------------- Selections ----------------
  Rxn<String> selectedServiceType = Rxn<String>();
  Rxn<String> selectedService = Rxn<String>();
  Rxn<String> selectedServiceTypeId = Rxn<String>();
  Rxn<String> selectedServiceId = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();

  // ---------------- State ----------------
  RxBool isLoading = false.obs;
  RxBool isEnabled = true.obs;
  RxString pickedFileName = "".obs;
  RxString pickedFilePath = ''.obs;
  RxBool isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServiceTypes();
  }

  final ServiceManagementService _service = ServiceManagementService();

  Future<void> fetchServiceTypes() async {
    try {
      final response = await _service.getServiceTypes();
      serviceTypes.clear();
      serviceTypes.addAll(response.data ?? []);
      serviceTypeNames.clear();
      serviceTypeNames.addAll(serviceTypes.map((e) => e.name ?? '').toList());
    } catch (e) {
      log('Error fetching service types: $e');
    }
  }

  Future<void> fetchServices(String serviceTypeId) async {
    try {
      final response = await _service.getServices(int.parse(serviceTypeId));
      servicesList.clear();
      servicesList.addAll(response.data ?? []);
      serviceNames.clear();
      serviceNames.addAll(servicesList.map((e) => e.name ?? '').toList());
    } catch (e) {
      log('Error fetching services: $e');
    }
  }

  void onServiceTypeSelected(String? value) {
    selectedServiceType.value = value;
    selectedServiceTypeId.value = serviceTypes
        .firstWhere((element) => element.name == value)
        .id
        .toString();

    // Clear service selection and fetch new services
    selectedService.value = null;
    selectedServiceId.value = null;
    serviceNames.clear();
    servicesList.clear();

    if (selectedServiceTypeId.value != null) {
      fetchServices(selectedServiceTypeId.value!);
    }
  }

  void onServiceSelected(String? value) {
    selectedService.value = value;
    selectedServiceId.value = servicesList
        .firstWhere((element) => element.name == value)
        .id
        .toString();
  }

  void onUomSelected(String? value) {
    selectedUom.value = value;
  }

  Future<void> pickImage() async {
    try {
      final XFile? result = await CommonConstant().pickImageFromGallery();

      if (result != null && result.path.isNotEmpty) {
        final XFile file = result;
        pickedFileName.value = file.name;
        pickedFilePath.value = file.path;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick file: $e', time: 3);
    }
  }

  void nextPage() {
    if (pageController.page == 0) {
      firstPartValidation().then((isValid) {
        if (isValid) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    } else {
      createServiceValidation();
    }
  }

  Future<bool> firstPartValidation() async {
    bool isRequired = false;
    if (pickedFilePath.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Service image is required');
      isRequired = false;
    } else if (serviceNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Service name is required');
      isRequired = false;
    } else if (selectedServiceTypeId.value == null) {
      SnackBars.errorSnackBar(content: 'Service type is required');
      isRequired = false;
    } else if (selectedServiceId.value == null) {
      SnackBars.errorSnackBar(content: 'Service is required');
      isRequired = false;
    } else if (selectedUom.value == null) {
      SnackBars.errorSnackBar(content: 'UOM is required');
      isRequired = false;
    } else if (priceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Price is required');
      isRequired = false;
    } else if (gstPriceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'GST price is required');
      isRequired = false;
    } else if (termsController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Terms is required');
      isRequired = false;
    } else {
      isRequired = true;
    }
    return isRequired;
  }

  void createServiceValidation() {
    if (descriptionController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Description is required');
    } else {
      createService();
    }
  }

  Future<void> createService() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    final Map<String, String> selectedFiles = {"service_image": pickedFilePath.value};

    fields = {
      "service_name": serviceNameController.text,
      "service_type_id": selectedServiceTypeId.value,
      "service_id": selectedServiceId.value,
      "price": priceController.text,
      "gst_percentage": gstController.text,
      "terms_and_conditions": termsController.text,
      "description": descriptionController.text,
      "uom": selectedUom.value,
      "is_active": isEnabled.value,
      "is_featured": false,
      "sort_order": "1",
    };

    log('fields $fields');
    try {
      final addServiceResponse = await _service.createService(
        fields: fields,
        files: selectedFiles,
      );

      if (addServiceResponse.success == true) {
        await controller.fetchServices();
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
        SnackBars.errorSnackBar(
          content: addServiceResponse.message ?? 'Something went wrong!!',
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    uomController.dispose();
    priceController.dispose();
    gstController.dispose();
    gstPriceController.dispose();
    termsController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
