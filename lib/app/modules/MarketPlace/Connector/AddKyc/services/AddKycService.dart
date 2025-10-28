import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddKyc/models/AddkycModel.dart';

class AddkycService {
  ApiManager apiManager = ApiManager();
 Future<AddkycModel> connectorAddKYC({
    String? aadhaar,
    String? panCard,
  }) async {
    try {
      final data={
        "aadhaar_number":aadhaar??"",
        "pan_number":panCard??"",
      };
      final response = await apiManager.postObject(
        url: APIConstants.connectorCreate,
        body: data,
      );
      return AddkycModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createProduct: $e , $st');
    }
  }

  Future<AddkycModel> updateProduct({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.putMultipart(
        url: APIConstants.connectorUpdate,  
        fields: fields,
        files: files,
      );
      return AddkycModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in updateProduct: $e , $st');
    }
  }

}

   
