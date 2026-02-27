import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/models/delivery_address_model.dart';

class DeliveryAddressService {
  static final ApiManager _apiManager = ApiManager();

  static Future createAddress(Object addressPayload) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.address,
        body: addressPayload,
      );
      return response;
    } catch (e) {
      throw Exception('Error adding address: $e');
    }
  }

  static Future updateAddress(String addressId, Object addressPayload) async {
    try {
      final response = await _apiManager.patchObject(
        url: '${APIConstants.address}/$addressId',
        body: addressPayload,
      );
      return response;
    } catch (e) {
      throw Exception('Error updating address: $e');
    }
  }

  static Future deleteAddress(String addressId) async {
    try {
      final response = await _apiManager.delete(url: '${APIConstants.address}/$addressId');
      return response;
    } catch (e) {
      throw Exception('Error deleting address: $e');
    }
  }

  static Future<DeliveryAddressModel> getAddresses() async {
    try {
      final response = await _apiManager.get(url: APIConstants.address);
      return DeliveryAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching addresses: $e');
    }
  }

  static Future setDefaultAddress(String addressId) async {
    try {
      final response = await _apiManager.patchObject(
        url: '${APIConstants.address}/$addressId/default',
        body: {},
      );
      return response;
    } catch (e) {
      throw Exception('Error setting default address: $e');
    }
  }
}
