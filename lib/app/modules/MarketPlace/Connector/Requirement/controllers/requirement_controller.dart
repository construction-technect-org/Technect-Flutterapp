import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/services/AddRequirementService.dart';

class RequirementController extends GetxController {
  final AddRequirementService requirementService = AddRequirementService();

  RxBool isLoading = false.obs;
  Rx<GetRequirementListModel> requirementListModel =
      GetRequirementListModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequirementsList();
  }

  Future<void> fetchRequirementsList() async {
    try {
      isLoading.value = true;
      final result = await requirementService.getRequirementsList();

      if (result.success == true) {
        requirementListModel.value = result;
      } else {
        SnackBars.errorSnackBar(
          content: result.message ?? 'Failed to fetch requirements',
        );
      }
    } catch (e) {
      Get.printError(info: 'Error fetching requirements list: $e');
      SnackBars.errorSnackBar(content: 'Error fetching requirements');
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
}
