import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ServiceManagement/controllers/service_management_controller.dart';
import 'package:construction_technect/app/modules/ServiceManagement/model/service_model.dart';
import 'package:construction_technect/app/modules/ServiceManagement/service/service_management_service.dart';

class ServiceDetailsController extends GetxController {
  Rx<Service> service = Service().obs;
  RxBool isLoading = false.obs;
  final ServiceManagementService _service = ServiceManagementService();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      service.value = Get.arguments["service"];
    }
  }

  Future<void> deleteService() async {
    try {
      isLoading.value = true;
      final response = await _service.deleteService(service.value.id ?? 0);

      if (response.success == true) {
        if (Get.isRegistered<ServiceManagementController>()) {
          await Get.find<ServiceManagementController>().fetchServices();
        }
        Get.back();
      } else {
        SnackBars.errorSnackBar(
          content: response.message ?? 'Failed to delete service',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting service: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showDeleteConfirmationDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: MyColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: DeleteConfirmationDialog(
          title: 'Are you sure?',
          subtitle: 'This cannot be un-done.',
          deleteButtonText: 'Delete service',
          onDelete: () => deleteService(),
        ),
      ),
    );
  }
}
