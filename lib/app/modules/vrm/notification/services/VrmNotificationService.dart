import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/vrm/notification/model/vrm_notification_model.dart';

class VrmNotificationService {
  final ApiManager _apiManager = ApiManager();

  Future<VrmNotificationModel> fetchVrmNotifications() async {
    try {
      final response = await _apiManager.get(url: APIConstants.vrmNotification);
      if (response != null) {
        return VrmNotificationModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching VRM notifications: $e");
    }
    return VrmNotificationModel();
  }
}
