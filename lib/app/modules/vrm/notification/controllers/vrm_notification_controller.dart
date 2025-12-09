import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/notification/model/vrm_notification_model.dart';
import 'package:construction_technect/app/modules/vrm/notification/services/VrmNotificationService.dart';

enum VrmNotificationFilter { all, high, low }

class VrmNotificationController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  Rx<VrmNotificationModel> vrmNotificationList = VrmNotificationModel().obs;

  RxBool isLoading = false.obs;
  final VrmNotificationService _service = VrmNotificationService();

  // ✅ filter state
  Rx<VrmNotificationFilter> selectedFilter = VrmNotificationFilter.all.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      vrmNotificationList.value = await _service.fetchVrmNotifications();
    } finally {
      isLoading.value = false;
    }
  }

  List<VrmNotification> get filteredNotifications {
    final allItems = vrmNotificationList.value.data?.notifications ?? [];
    switch (selectedFilter.value) {
      case VrmNotificationFilter.high:
        return allItems.where((e) => e.priority?.toLowerCase() == "high").toList();
      case VrmNotificationFilter.low:
        return allItems.where((e) => e.priority?.toLowerCase() == "low").toList();
      default:
        return allItems;
    }
  }
}
