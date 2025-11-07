import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/models/AddkycModel.dart';

class AddKycService {
  ApiManager apiManager = ApiManager();
 Future<AddKycModel> connectorAddKYC({
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
      return AddKycModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createProduct: $e , $st');
    }
  }

}

   
