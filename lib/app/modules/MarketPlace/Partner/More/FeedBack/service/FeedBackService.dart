import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';

class FeedbackService {
  final ApiManager _apiManager = ApiManager();

  Future<AddRolemodel> addFeedback({
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

      return AddRolemodel.fromJson(response);
    } catch (e) {
      throw Exception('Error adding feedback: $e');
    }
  }

  Future<AddRolemodel> addConnectorFeedback({
    required int rating,
    required String text,
    required int id,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: "${APIConstants.connectorGetProductReview}$id/rating",
        body: {"rating": rating, "review_text": text, "is_anonymous": false},
      );

      return AddRolemodel.fromJson(response);
    } catch (e) {
      throw Exception('Error adding connector feedback: $e');
    }
  }
}
