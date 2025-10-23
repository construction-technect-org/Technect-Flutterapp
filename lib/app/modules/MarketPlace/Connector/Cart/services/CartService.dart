import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/model/cart_model.dart';

class CartListServices {
  ApiManager apiManager = ApiManager();

  Future<AllCartModel> allCartList({String? status}) async {
    try {
      final data = {if ((status ?? "").isNotEmpty) "status": status};
      const String url = APIConstants.cartList;
      debugPrint('Calling API: $url');
      final response = (status??"").isNotEmpty? await apiManager.get(url: url, params: data):await apiManager.get(url: url);
      debugPrint('Response: $response');

      return AllCartModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}
