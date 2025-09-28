import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/Notifications/models/notification_model.dart';

class NotificationService {
  final ApiManager _apiManager = ApiManager();

  Future<NotificationModel> fetchNotifications({
    int limit = 50,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    try {
      final response = await _apiManager.get(url: APIConstants.notifications);
      return NotificationModel.fromJson(response);
    } catch (e) {
      log("Error fetching notifications: $e");
      rethrow;
    }
  }
}
