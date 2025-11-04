import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/models/ConnectorServiceModel.dart';

class ConstructionLineServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> connectorProduct({
    String? mainCategoryId,
    String? subCategoryId,
    String? categoryProductId,
    String? productSubCategoryId,
    int? radius,
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      const String url = APIConstants.connectorProduct;
      final Map<String, dynamic> body = {
        if (mainCategoryId != null && mainCategoryId.isNotEmpty)
          "main_category_id": mainCategoryId,
        if (subCategoryId != null && subCategoryId.isNotEmpty)
          "sub_category_id": subCategoryId,
        if (categoryProductId != null && categoryProductId.isNotEmpty)
          "category_product_id": categoryProductId,
        if (productSubCategoryId != null && productSubCategoryId.isNotEmpty)
          "product_sub_category_id": productSubCategoryId,
        if (radius != null) "radius_km": radius,
        // "page": page,
        // "limit": limit,
        if (filters != null && filters.isNotEmpty) "filters": filters,
      };

      debugPrint('Calling API: $url');
      // ✅ Send POST request via your apiManager
      final response = await apiManager.postObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ConnectorSelectedProductModel> notifyMe({int? mID}) async {
    try {
      const String url = APIConstants.notifyME;
      final Map<String, dynamic> body = {"merchant_product_id": mID};
      debugPrint('Calling API: $url');
      // ✅ Send POST request via your apiManager
      final response = await apiManager.postObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ConnectorSelectedProductModel> addToConnect({
    int? mID,
    int? pID,
    String? message,
  }) async {
    try {
      const String url = APIConstants.addToConnect;
      final Map<String, dynamic> body = {
        "merchant_profile_id": mID,
        "product_id": pID,
        "message": message ?? "",
      };
      debugPrint('Calling API: $url');
      // ✅ Send POST request via your apiManager
      final response = await apiManager.postObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ConnectorServiceModel> connectorServices({
    required int mainCategoryId,
    required int subCategoryId,
    required int serviceCategoryId,
    int page = 1,
    int limit = 20,
    double radiusKm = 50,
  }) async {
    try {
      const String url = APIConstants.connectorServices;
      final Map<String, dynamic> body = {
        "main_category_id": mainCategoryId,
        "sub_category_id": subCategoryId,
        "service_category_id": serviceCategoryId,
        "page": page,
        "limit": limit,
        "radius_km": radiusKm,
      };

      debugPrint('Calling API: $url');
      debugPrint('Request Body: $body');
      final response = await apiManager.postObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorServiceModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching services: $e');
    }
  }

  Future<ConnectorServiceModel> addServiceToConnect({
    int? mID,
    int? sID,
    String? message,
  }) async {
    try {
      const String url = APIConstants.addToConnect;
      final Map<String, dynamic> body = {
        "merchant_profile_id": mID,
        "service_id": sID,
        "request_message": message ?? "",
      };
      debugPrint('Calling API: $url');
      debugPrint('Request Body: $body');
      final response = await apiManager.postObject(url: url, body: body);
      debugPrint('Response: $response');

      return ConnectorServiceModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error sending service connection request: $e');
    }
  }
}
