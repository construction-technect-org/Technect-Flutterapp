import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';

class FeedbackService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRolemodel?> addFeedback({
    required int rating,
    required String text,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: myPref.role.val == "connector"
            ? APIConstants.connectorFeedback
            : APIConstants.merchantFeedback,
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

  static Future<AddRolemodel?> addConnectorFeedback({
    required int rating,
    required String text,
    required int id,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: "${APIConstants.connectorGetProductReview}$id/rating",
        body: {"rating": rating, "review_text": text, "is_anonymous": false},
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
