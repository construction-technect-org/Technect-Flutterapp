import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/models/manufacturer_address_model.dart';

class ManufacturerAddressService {
  static final ApiManager _apiManager = ApiManager();

  static Future updateManufacturerAddress(
    String addressId,
    Object manufacturerAddress,
  ) async {
    try {
      final response = await _apiManager.putObject(
        url: '${APIConstants.manufacturerAddress}/$addressId',
        body: manufacturerAddress,
      );
      return response;
    } catch (e) {
      throw Exception('Error updating manufacturer address: $e');
    }
  }

  static Future<ManufacturerAddressModel> deleteManufacturerAddress(
    String addressId,
  ) async {
    try {
      final response = await _apiManager.delete(
        url: '${APIConstants.manufacturerAddress}/$addressId',
      );
      return ManufacturerAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error deleting manufacturer address: $e');
    }
  }

  static Future<ManufacturerAddressModel> getManufacturerAddresses() async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.manufacturerAddress,
      );
      return ManufacturerAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching manufacturer addresses: $e');
    }
  }
}
