import 'package:construction_technect/app/modules/ServiceManagement/model/service_model.dart';
import 'package:construction_technect/app/modules/ServiceManagement/service/service_management_service.dart';
import 'package:get/get.dart';

class ServiceManagementController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ServiceListModel> serviceModel = ServiceListModel().obs;
  RxList<Service> filteredServices = <Service>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  final ServiceManagementService _service = ServiceManagementService();

  void searchService(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      filteredServices.clear();
      filteredServices.addAll(serviceModel.value.data?.services ?? []);
    } else {
      filteredServices.clear();
      filteredServices.value = (serviceModel.value.data?.services ?? []).where((
        service,
      ) {
        return (service.serviceName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (service.serviceTypeName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            );
      }).toList();
    }
  }

  Future<void> fetchServices() async {
    try {
      isLoading(true);
      serviceModel.value = await _service.getServiceList();
      filteredServices.clear();
      filteredServices.addAll(serviceModel.value.data?.services ?? []);
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
