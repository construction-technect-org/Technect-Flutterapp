import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/model/approval_inbox_model.dart';

class ApprovalInboxService {
  final ApiManager _apiManager = ApiManager();

  Future<ApprovalInboxModel> fetchApprovalInbox() async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.notificationsProduct,
      );
      if (response != null) {
        return ApprovalInboxModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return ApprovalInboxModel();
  }
}
