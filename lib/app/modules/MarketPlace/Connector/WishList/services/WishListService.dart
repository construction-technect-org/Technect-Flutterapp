import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/model/wishlist_model.dart';

class WishListServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> wishList({
    required int mID,
    required String status,
  }) async {
    try {
      final String url = "${APIConstants.wishList}/$status";
      final Map<String, dynamic> body = {"merchant_product_id": mID};
      debugPrint('Calling API: $url');
      // ✅ Send POST request via your apiManager
      final response = status == "add"
          ? await apiManager.postObject(url: url, body: body)
          : await apiManager.deleteObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<AllWishListModel> allWishList() async {
    try {
      const String url = "${APIConstants.wishList}/list";
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url);
      debugPrint('Response: $response');

      return AllWishListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}
