import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/services/add_service_requirement_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:intl/intl.dart';

class AddServiceRequirementController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final isLoading = false.obs;
  HomeController homeController = Get.find<HomeController>();

  final noteController = TextEditingController();

  RxList<ServiceCategoryData> mainCategories = <ServiceCategoryData>[].obs;
  RxList<ServicesSubCategories> subCategories = <ServicesSubCategories>[].obs;
  RxList<ServiceCategories> serviceCategories = <ServiceCategories>[].obs;

  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> serviceCategoryNames = <String>[].obs;

  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedServiceCategory = Rxn<String>();
  Rxn<int> selectedMainCategoryId = Rxn<int>();
  Rxn<int> selectedSubCategoryId = Rxn<int>();
  Rxn<int> selectedServiceCategoryId = Rxn<int>();

  RxList<SiteLocation> siteLocations = <SiteLocation>[].obs;
  RxInt selectedSiteAddressId = 0.obs;
  Rxn<SiteLocation> selectedSiteAddress = Rxn<SiteLocation>();

  Rxn<DateTime> estimateStartDate = Rxn<DateTime>();
  final estimateStartDateController = TextEditingController();

  final serviceRequirementService = AddServiceRequirementService();

  int? serviceRequirementId;

  @override
  void onInit() {
    super.onInit();
    _initializeServiceCategoryHierarchy();
    _fetchSiteAddresses().then((_) {
      _populateFromArguments(Get.arguments);
    });
  }

  void _initializeServiceCategoryHierarchy() {
    final cachedHierarchy = myPref.getServiceCategoryHierarchyModel();
    if (cachedHierarchy != null) {
      _populateCategoriesFromHierarchy(cachedHierarchy);
    }
  }

  void _populateCategoriesFromHierarchy(ServiceCategoryModel hierarchy) {
    mainCategories.value = hierarchy.data ?? [];
    mainCategoryNames.value = mainCategories
        .map((e) => e.name ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  void onMainCategorySelected(String? categoryName) {
    if (categoryName == null) {
      _clearSubCategories();
      return;
    }

    selectedMainCategory.value = categoryName;
    final selected = mainCategories.firstWhereOrNull(
      (c) => c.name == categoryName,
    );
    selectedMainCategoryId.value = selected?.id;

    if (selected != null && selected.subCategories != null) {
      subCategories.value = selected.subCategories!;
      subCategoryNames.value = subCategories
          .map((e) => e.name ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      _clearSubCategories();
    }
  }

  void onSubCategorySelected(String? subCategoryName) {
    if (subCategoryName == null) {
      _clearServiceCategories();
      return;
    }

    selectedSubCategory.value = subCategoryName;
    final selectedSub = subCategories.firstWhereOrNull(
      (s) => s.name == subCategoryName,
    );
    selectedSubCategoryId.value = selectedSub?.id;

    if (selectedSub != null && selectedSub.serviceCategories != null) {
      serviceCategories.value = selectedSub.serviceCategories!;
      serviceCategoryNames.value = serviceCategories
          .map((e) => e.name ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      _clearServiceCategories();
    }
  }

  void onServiceCategorySelected(String? serviceCategoryName) {
    if (serviceCategoryName == null) {
      selectedServiceCategory.value = null;
      selectedServiceCategoryId.value = null;
      return;
    }

    selectedServiceCategory.value = serviceCategoryName;
    final selected = serviceCategories.firstWhereOrNull(
      (s) => s.name == serviceCategoryName,
    );
    selectedServiceCategoryId.value = selected?.id;
  }

  void _clearSubCategories() {
    subCategories.clear();
    subCategoryNames.clear();
    selectedSubCategory.value = null;
    selectedSubCategoryId.value = null;
    _clearServiceCategories();
  }

  void _clearServiceCategories() {
    serviceCategories.clear();
    serviceCategoryNames.clear();
    selectedServiceCategory.value = null;
    selectedServiceCategoryId.value = null;
  }

  Future<void> _fetchSiteAddresses() async {
    siteLocations.value =
        homeController.profileData.value.data?.siteLocations ?? [];
    _syncSelectedSiteAddress();
  }

  void selectSiteAddress(SiteLocation? site) {
    if (site != null) {
      selectedSiteAddress.value = site;
      selectedSiteAddressId.value = site.id ?? 0;
    } else {
      selectedSiteAddress.value = null;
      selectedSiteAddressId.value = 0;
    }
  }

  void _syncSelectedSiteAddress() {
    if (selectedSiteAddressId.value > 0) {
      final site = siteLocations.firstWhereOrNull(
        (s) => s.id == selectedSiteAddressId.value,
      );
      selectedSiteAddress.value = site;
    } else {
      selectedSiteAddress.value = null;
    }
  }

  Future<void> selectEstimateStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: estimateStartDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      estimateStartDate.value = picked;
      estimateStartDateController.text = formattedEstimateStartDate;
    }
  }

  String get formattedEstimateStartDate {
    if (estimateStartDate.value == null) return '';
    return DateFormat('dd-MM-yyyy').format(estimateStartDate.value!);
  }

  String get formattedEstimateStartDateForApi {
    if (estimateStartDate.value == null) return '';
    return DateFormat('yyyy-MM-dd').format(estimateStartDate.value!);
  }

  Future<void> _populateFromArguments(dynamic args) async {
    if (args == null) return;

    if (args is Map) {
      serviceRequirementId = args['serviceRequirementId'];
      if (args['note'] != null) {
        noteController.text = args['note'];
      }

      if (args['estimate_start_date'] != null) {
        try {
          estimateStartDate.value = DateTime.parse(args['estimate_start_date']);
          estimateStartDateController.text = formattedEstimateStartDate;
        } catch (e) {
          Get.printError(info: 'Error parsing date: $e');
        }
      }

      if (args['site_address_id'] != null) {
        final siteId = args['site_address_id'] as int;
        selectedSiteAddressId.value = siteId;
        _syncSelectedSiteAddress();
      }

      if (args['main_category_id'] != null) {
        final mainCatId = args['main_category_id'] as int;
        final mainCat = mainCategories.firstWhereOrNull(
          (c) => c.id == mainCatId,
        );
        if (mainCat != null) {
          selectedMainCategoryId.value = mainCatId;
          selectedMainCategory.value = mainCat.name;

          if (mainCat.subCategories != null) {
            subCategories.value = mainCat.subCategories!;
            subCategoryNames.value = subCategories
                .map((e) => e.name ?? '')
                .where((name) => name.isNotEmpty)
                .toList();

            if (args['sub_category_id'] != null) {
              final subCatId = args['sub_category_id'] as int;
              final subCat = subCategories.firstWhereOrNull(
                (s) => s.id == subCatId,
              );
              if (subCat != null) {
                selectedSubCategoryId.value = subCatId;
                selectedSubCategory.value = subCat.name;

                if (subCat.serviceCategories != null) {
                  serviceCategories.value = subCat.serviceCategories!;
                  serviceCategoryNames.value = serviceCategories
                      .map((e) => e.name ?? '')
                      .where((name) => name.isNotEmpty)
                      .toList();

                  if (args['service_category_id'] != null) {
                    final serviceCatId = args['service_category_id'] as int;
                    final serviceCat = serviceCategories.firstWhereOrNull(
                      (s) => s.id == serviceCatId,
                    );
                    if (serviceCat != null) {
                      selectedServiceCategoryId.value = serviceCatId;
                      selectedServiceCategory.value = serviceCat.name;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  bool _validateForm() {
    if (selectedMainCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select main category");
      return false;
    }

    if (selectedSubCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select sub category");
      return false;
    }

    if (selectedServiceCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select service category");
      return false;
    }

    if (selectedSiteAddress.value == null) {
      SnackBars.errorSnackBar(content: "Please select site address");
      return false;
    }

    return true;
  }

  Map<String, dynamic> _buildFormData() {
    return {
      "main_category_id": selectedMainCategoryId.value,
      "sub_category_id": selectedSubCategoryId.value,
      "service_category_id": selectedServiceCategoryId.value,
      "site_address_id": selectedSiteAddressId.value,
      "estimate_start_date": formattedEstimateStartDateForApi.isNotEmpty
          ? formattedEstimateStartDateForApi
          : null,
      "note": noteController.text.trim(),
    };
  }

  Future<void> submitServiceRequirement() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final data = _buildFormData();

      if (serviceRequirementId != null) {
        await serviceRequirementService.updateServiceRequirement(
          serviceRequirementId: serviceRequirementId!,
          data: data,
        );
        Get.back();
        SnackBars.successSnackBar(
          content: "Service requirement updated successfully",
        );
      } else {
        await serviceRequirementService.createServiceRequirement(data: data);
        Get.back();
        SnackBars.successSnackBar(
          content: "Service requirement created successfully",
        );
      }
    } catch (e) {
      log(e.toString());
      SnackBars.errorSnackBar(content: "Failed to submit service requirement");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    noteController.dispose();
    estimateStartDateController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
