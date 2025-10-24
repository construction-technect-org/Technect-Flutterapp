import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/models/delivery_address_model.dart';

class DeliveryAddressService {
  static final ApiManager _apiManager = ApiManager();

  static Future submitDeliveryAddress(Object deliveryAddress) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.connectorSiteAddress,
        body: deliveryAddress,
      );
      return response;
    } catch (e) {
      throw Exception('Error adding delivery address: $e');
    }
  }

  static Future updateDeliveryAddress(String addressId, Object deliveryAddress) async {
    try {
      final response = await _apiManager.putObject(
        url: '${APIConstants.connectorSiteAddress}/$addressId',
        body: deliveryAddress,
      );
      return response;
    } catch (e) {
      throw Exception('Error updating delivery address: $e');
    }
  }

  static Future<DeliveryAddressModel> deleteDeliveryAddress(String addressId) async {
    try {
      final response = await _apiManager.delete(
        url: '${APIConstants.connectorSiteAddress}/$addressId',
      );
      return DeliveryAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error deleting delivery address: $e');
    }
  }

  static Future<DeliveryAddressModel> getDeliveryAddresses() async {
    try {
      final response = await _apiManager.get(url: APIConstants.connectorSiteAddress);
      return DeliveryAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching delivery addresses: $e');
    }
  }
}
