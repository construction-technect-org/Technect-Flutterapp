import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/models/notification_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();

  RxBool isLoading = false.obs;
  RxBool isConnector = false.obs;
  Rx<NotificationModel> notificationModel = NotificationModel().obs;

  @override
  void onInit() {
    super.onInit();
    // _loadNotificationsFromStorage();
    isConnector.value = myPref.getRole() == "connector";
    fetchNotifications();
  }

  Future<void> _loadNotificationsFromStorage() async {
    final cachedNotificationModel = myPref.getNotificationModel();
    if (cachedNotificationModel != null) {
      notificationModel.value = cachedNotificationModel;
    }
  }

  Future<void> fetchNotifications({
    int limit = 50,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    try {
      isLoading.value = true;
      final result = await _notificationService.fetchNotifications(
        isConnector: isConnector.value,
        limit: limit,
        offset: offset,
        unreadOnly: unreadOnly,
      );
      if (result.success == true) {
        notificationModel.value = result;
        myPref.setNotificationModel(result);
      } else {
        await _loadNotificationsFromStorage();
      }
    } catch (e) {
      await _loadNotificationsFromStorage();
      SnackBars.errorSnackBar(content: 'Failed to fetch notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }
}
