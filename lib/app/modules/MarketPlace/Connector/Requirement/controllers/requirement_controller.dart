import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/services/AddRequirementService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/services/requirement_services.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/AddServiceRequirement/models/get_service_requirement_model.dart';

class RequirementController extends GetxController {
  final AddRequirementService requirementService = AddRequirementService();
  final RequirementServices requirementServices = RequirementServices();

  RxBool isLoading = false.obs;
  RxInt selectedTabIndex = 0.obs; // 0 = Product, 1 = Service
  Rx<GetRequirementListModel> requirementListModel =
      GetRequirementListModel().obs;
  Rx<GetServiceRequirementListModel> serviceRequirementListModel =
      GetServiceRequirementListModel().obs;

  @override
  void onInit() {
    super.onInit();
    _loadRequirementsFromStorage();
    _loadServiceRequirementsFromStorage();
  }

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
  }

  void _loadRequirementsFromStorage() {
    final cachedRequirementList = myPref.getRequirementListModel();
    if ((cachedRequirementList?.data?.isNotEmpty ?? false) ||
        cachedRequirementList != null) {
      requirementListModel.value =
          cachedRequirementList ?? GetRequirementListModel();
    } else {
      fetchRequirementsList();
    }
  }

  void _loadServiceRequirementsFromStorage() {
    final cachedServiceRequirementList = myPref
        .getServiceRequirementListModel();
    if ((cachedServiceRequirementList?.data?.isNotEmpty ?? false) ||
        cachedServiceRequirementList != null) {
      serviceRequirementListModel.value =
          cachedServiceRequirementList ?? GetServiceRequirementListModel();
    } else {
      fetchServiceRequirementsList();
    }
  }

  Future<void> fetchRequirementsList() async {
    try {
      isLoading.value = true;

      final result = await requirementService.getRequirementsList();

      if (result.success == true) {
        requirementListModel.value = result;
        myPref.setRequirementListModel(result);
      } else {
        SnackBars.errorSnackBar(
          content: result.message ?? 'Failed to fetch requirements',
        );
      }
    } catch (e) {
      Get.printError(info: 'Error fetching requirements list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToEditRequirement(RequirementData? requirement) {
    log('requirement: ${requirement?.toJson()}');
    Get.toNamed(
      Routes.ADD_REQUIREMENT,
      arguments: {
        'requirementId': requirement?.id,
        'main_category_id': requirement?.mainCategoryId,
        'sub_category_id': requirement?.subCategoryId,
        'category_product_id': requirement?.categoryProductId,
        'product_sub_category_id': requirement?.productSubCategoryId,
        'quantity': requirement?.quantity,
        'uom': requirement?.uom,
        'site_address_id': requirement?.siteAddressId,
        'estimate_delivery_date': requirement?.estimateDeliveryDate,
        'note': requirement?.note,
      },
    );
  }

  void showDeleteConfirmationDialog(int requirementId) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF9D0CB)),
            color: const Color(0xFFFCECE9),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              'Delete Requirement',
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this requirement? This action cannot be undone.',
          style: MyTexts.medium14.copyWith(color: MyColors.gray54),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  onTap: () => Get.back(),
                  buttonName: 'Cancel',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: MyColors.grayCD,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: RoundedButton(
                  onTap: () => deleteRequirement(requirementId),
                  buttonName: 'Delete',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: const Color(0xFFE53D26),
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> deleteRequirement(int requirementId) async {
    try {
      isLoading.value = true;
      Get.back();

      await requirementService.deleteRequirement(requirementId: requirementId);

      await fetchRequirementsList();
    } catch (e) {
      Get.printError(info: 'Error deleting requirement: $e');
      SnackBars.errorSnackBar(content: 'Error deleting requirement');
    } finally {
      isLoading.value = false;
    }
  }

  // Service Requirement Methods
  Future<void> fetchServiceRequirementsList({
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      isLoading.value = true;

      final result = await requirementServices.getServiceRequirementsList(
        status: status,
        page: page,
        limit: limit,
      );

      if (result.success == true) {
        serviceRequirementListModel.value = result;
        myPref.setServiceRequirementListModel(result);
      } else {
        SnackBars.errorSnackBar(
          content: result.message ?? 'Failed to fetch service requirements',
        );
      }
    } catch (e) {
      Get.printError(info: 'Error fetching service requirements list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToEditServiceRequirement(
    ServiceRequirementData? serviceRequirement,
  ) {
    log('serviceRequirement: ${serviceRequirement?.toJson()}');
    Get.toNamed(
      Routes.ADD_SERVICE_REQUIREMENT,
      arguments: {
        'serviceRequirementId': serviceRequirement?.id,
        'main_category_id': serviceRequirement?.mainCategoryId,
        'sub_category_id': serviceRequirement?.subCategoryId,
        'service_category_id': serviceRequirement?.serviceCategoryId,
        'site_address_id': serviceRequirement?.siteAddressId,
        'estimate_start_date': serviceRequirement?.estimateStartDate,
        'note': serviceRequirement?.note,
      },
    )?.then((_) {
      fetchServiceRequirementsList();
    });
  }

  void showDeleteServiceRequirementConfirmationDialog(
    int serviceRequirementId,
  ) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF9D0CB)),
            color: const Color(0xFFFCECE9),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              'Delete Service Requirement',
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this service requirement? This action cannot be undone.',
          style: MyTexts.medium14.copyWith(color: MyColors.gray54),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  onTap: () => Get.back(),
                  buttonName: 'Cancel',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: MyColors.grayCD,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: RoundedButton(
                  onTap: () => deleteServiceRequirement(serviceRequirementId),
                  buttonName: 'Delete',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: const Color(0xFFE53D26),
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> deleteServiceRequirement(int serviceRequirementId) async {
    try {
      isLoading.value = true;
      Get.back();

      await requirementServices.deleteServiceRequirement(
        serviceRequirementId: serviceRequirementId,
      );

      await fetchServiceRequirementsList();
    } catch (e) {
      Get.printError(info: 'Error deleting service requirement: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
