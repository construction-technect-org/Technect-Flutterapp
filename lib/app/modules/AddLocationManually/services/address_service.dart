// import 'package:construction_technect/app/core/apiManager/api_constants.dart';
// import 'package:construction_technect/app/core/apiManager/api_manager.dart';

// class AddressService {
//   final ApiManager _apiManager = ApiManager();

//   /// Add address manually (without lat/lng)
//   Future<Map<String, dynamic>> addAddressManually({
//     required String addressLine1,
//     required String addressLine2,
//     required String landmark,
//     required String city,
//     required String state,
//     required String pinCode,
//     double? latitude,
//     double? longitude,
//     bool isDefault = true,
//     String addressType = 'work',
//   }) async {
//     try {
//       final body = {
//         'address_line1': addressLine1,
//         'address_line2': addressLine2,
//         'landmark': landmark,
//         'city': city,
//         'state': state,
//         'pin_code': pinCode,
//         'is_default': isDefault,
//         'address_type': addressType,
//       };

//       // Add lat/lng if provided
//       if (latitude != null && longitude != null) {
//         body['latitude'] = latitude;
//         body['longitude'] = longitude;
//       }

//       final response = await _apiManager.postObject(
//         url: APIConstants.address,
//         body: body,
//       );

//       return Map<String, dynamic>.from(response);
//     } catch (e) {
//       throw Exception('Error adding address: $e');
//     }
//   }

//   /// Update existing address
//   /// 
//   Future<Map<String, dynamic>> updateAddress({
//     required int addressId,
//     required String addressLine1,
//     required String addressLine2,
//     required String landmark,
//     required String city,
//     required String state,
//     required String pinCode,
//     double? latitude,
//     double? longitude,
//     bool isDefault = true,
//     String addressType = 'work',
//   }) async {
//     try {
//       final body = {
//         'address_line1': addressLine1,
//         'address_line2': addressLine2,
//         'landmark': landmark,
//         'city': city,
//         'state': state,
//         'pin_code': pinCode,
//         'is_default': isDefault,
//         'address_type': addressType,
//       };

//       // Add lat/lng if provided
//       if (latitude != null && longitude != null) {
//         body['latitude'] = latitude;
//         body['longitude'] = longitude;
//       }

//       final response = await _apiManager.putObject(
//         url: '${APIConstants.address}/$addressId',
//         body: body,
//       );

//       return Map<String, dynamic>.from(response);
//     } catch (e) {
//       throw Exception('Error updating address: $e');
//     }
//   }


// }



import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/AddLocationManually/models/SavedAddressesModel.dart';

class AddressService {
  final ApiManager _apiManager = ApiManager();

  /// Add address manually (without lat/lng)
  Future<Map<String, dynamic>> addAddressManually({
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String pinCode,
    double? latitude,
    double? longitude,
    bool isDefault = true,
    required String addressType,
  }) async {
    try {
      final body = {
        'address_line1': addressLine1,
        'address_line2': addressLine2,
        'landmark': landmark,
        'city': city,
        'state': state,
        'pin_code': pinCode,
        'is_default': isDefault,
        'address_type': addressType,
      };

      if (latitude != null && longitude != null) {
        body['latitude'] = latitude;
        body['longitude'] = longitude;
      }

      final response = await _apiManager.postObject(
        url: APIConstants.address,
        body: body,
      );

      return Map<String, dynamic>.from(response);
    } catch (e) {
      throw Exception('Error adding address: $e');
    }
  }

  /// Update existing address
  Future<Map<String, dynamic>> updateAddress({
    required int addressId,
    required String addressLine1,
    required String addressLine2,
    required String landmark,
    required String city,
    required String state,
    required String pinCode,
    double? latitude,
    double? longitude,
    bool isDefault = true,
    required String addressType,
  }) async {
    try {
      final body = {
        'address_line1': addressLine1,
        'address_line2': addressLine2,
        'landmark': landmark,
        'city': city,
        'state': state,
        'pin_code': pinCode,
        'is_default': isDefault,
        'address_type': addressType,
      };

      if (latitude != null && longitude != null) {
        body['latitude'] = latitude;
        body['longitude'] = longitude;
      }

      final response = await _apiManager.putObject(
        url: '${APIConstants.address}/$addressId',
        body: body,
      );

      return Map<String, dynamic>.from(response);
    } catch (e) {
      throw Exception('Error updating address: $e');
    }
  }



  Future<SavedAddressesModel> getProfile() async {
    try {
        final response = await _apiManager.get(url: APIConstants.address);

      return SavedAddressesModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
