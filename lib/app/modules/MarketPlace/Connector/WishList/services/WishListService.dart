import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/model/wishlist_model.dart';

class WishListServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> wishList({
    required dynamic wishlistItemId,
    required String connectorProfileId,
    required String moduleType,
    required bool isAdd,
  }) async {
    try {
      const String url = APIConstants.wishList;
      final Map<String, dynamic> body = {
        "connectorProfileId": connectorProfileId,
        "wishlistItemId": wishlistItemId,
        "moduleType": moduleType,
      };
      debugPrint('Calling API ($url) with Method: ${isAdd ? "POST" : "DELETE"}');
      debugPrint('Body: $body');

      final response = isAdd
          ? await apiManager.postObject(url: url, body: body)
          : await apiManager.deleteObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      rethrow;
    }
  }

  Future<AllWishListModel> allWishList({required String connectorProfileId}) async {
    try {
      final String url = "${APIConstants.wishList}?connectorProfileId=$connectorProfileId";
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url);
      debugPrint('Response: $response');

      return AllWishListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      rethrow;
    }
  }
}
