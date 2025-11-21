import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/models/ConnectorServiceModel.dart';

class ConstructionLineServices {
  ApiManager apiManager = ApiManager();

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

      final response = await apiManager.postObject(url: url, body: body);

      return ConnectorServiceModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }

  Future<ConnectorServiceModel> addServiceToConnect({
    int? mID,
    int? sID,
    String? message,
    String? radius,
    String? date,
  }) async {
    try {
      const String url = APIConstants.addToConnect;
      final Map<String, dynamic> body = {
        "merchant_profile_id": mID,
        "service_id": sID,
        "request_message":
            "Need professional electrical installation service for residential property",
        "estimate_start_date": date,
        "radius": radius,
        "note": message ?? "",
      };
      final response = await apiManager.postObject(url: url, body: body);

      return ConnectorServiceModel.fromJson(response);
    } catch (e) {
      throw Exception('Error sending service connection request: $e');
    }
  }
}
