import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/ProductDetailsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/rating_model.dart';

class ProductDetailService {
  final ApiManager _apiManager = ApiManager();

  Future<ProductRatingModel?> fetchAllReview({required String id}) async {
    try {
      final response = await _apiManager.get(
        url: "${APIConstants.updateProduct}$id/ratings",
      );
      if (response != null) {
        return ProductRatingModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }

  Future<ProductDetailsModel> productDetails({
    required String id,
    required String longitude,
    required String latitude,
  }) async {
    try {
      final response = await _apiManager.get(
        url: "${APIConstants.productDetails}$id?latitude$latitude&longitude=$longitude",
      );
      return ProductDetailsModel.fromJson(response);
    } catch (e) {
      throw Exception('Error product details: $e');
    }
  }

  Future<ProductRatingModel?> fetchConnectorReview({required String id}) async {
    try {
      final response = await _apiManager.get(
        url: "${APIConstants.connectorGetProductReview}$id/ratings",
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
