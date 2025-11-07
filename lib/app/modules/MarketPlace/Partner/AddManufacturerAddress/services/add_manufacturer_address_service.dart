import 'package:construction_technect/app/core/utils/imports.dart';

class AddManufacturerAddressService {
  static final ApiManager _apiManager = ApiManager();

  static Future submitManufacturerAddress(Object manufacturerAddress) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.manufacturerAddress,
        body: manufacturerAddress,
      );
      return response;
    } catch (e) {
      throw Exception('Error adding manufacturer address: $e');
    }
  }

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
}
