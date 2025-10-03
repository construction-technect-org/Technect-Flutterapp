import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';

class FeedbackService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRolemodel?> addFeedback({
    required int rating,
    required String text,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.merchantFeedback,
        body: {
          "rating": rating,
          "feedback_text": text,
          "feedback_type": "general",
          "is_anonymous": false,
        },
      );

      if (response != null) {
        return AddRolemodel.fromJson(response);
      } else {
        return AddRolemodel(
          success: false,
          data: null,
          message: "Null response from server",
        );
      }
    } catch (e) {
      log("❌ Error: $e");
      return AddRolemodel(success: false, data: null, message: e.toString());
    }
  }

}
