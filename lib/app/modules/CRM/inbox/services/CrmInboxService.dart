import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/CRM/inbox/model/crm_inbox_model.dart';

class CrmInboxService {
  final ApiManager _apiManager = ApiManager();

  Future<CrmInboxModel> fetchCrmInbox() async {
    try {
      final response = await _apiManager.get(url: APIConstants.crmNotification);
      if (response != null) {
        return CrmInboxModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching CRM inbox: $e");
    }
    return CrmInboxModel();
  }
}
