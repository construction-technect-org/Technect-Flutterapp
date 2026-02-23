import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';

class EditProfileService {
  final ApiManager _apiManager = ApiManager();

  // Future<Map<String, dynamic>> submitMerchantData({
  //   required Map<String, dynamic> formFields,
  //   Map<String, String>? files,
  // }) async {
  //   try {
  //     final response = await _apiManager.postMultipart(
  //       url: APIConstants.merchantSubmit,
  //       fields: formFields,
  //       files: files,
  //     );

  //     return response as Map<String, dynamic>;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>> updateMerchantData({
  //   required Map<String, dynamic> formFields,
  //   Map<String, String>? files,
  // }) async {
  //   try {
  //     final response = await _apiManager.putMultipart(
  //       url: APIConstants.merchantUpdate,
  //       fields: formFields,
  //       files: files,
  //     );

  //     return response as Map<String, dynamic>;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future uploadKycDetails(Map<String, String> payload) async {}
}
