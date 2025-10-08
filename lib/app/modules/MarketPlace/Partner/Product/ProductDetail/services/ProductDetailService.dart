import 'dart:developer';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/rating_model.dart';

class ProductDetailService {
  final ApiManager _apiManager = ApiManager();

  Future<ProductRatingModel?> fetchAllReview({required String id}) async {
    try {
      final response = await _apiManager.get(
        url: "${APIConstants.updateProduct}$id/ratings?page=1&limit=10",
      );
      if (response != null) {
        return ProductRatingModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }
}
