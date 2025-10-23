import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/model/wishlist_model.dart';

class CartListServices {
  ApiManager apiManager = ApiManager();

  Future<AllWishListModel> allCartList({String? status}) async {
    try {
      final data = {if ((status ?? "").isNotEmpty) "status": status};
      const String url = APIConstants.cartList;
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url, params: data);
      debugPrint('Response: $response');

      return AllWishListModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}
