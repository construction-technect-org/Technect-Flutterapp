import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/create_service_requirement_model.dart';

class AddServiceRequirementService {
  ApiManager apiManager = ApiManager();

  Future<CreateServiceRequirementModel> createServiceRequirement({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.connectorCreateServiceRequirement,
        body: data,
      );
      return CreateServiceRequirementModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createServiceRequirement: $e , $st');
    }
  }

  Future<CreateServiceRequirementModel> updateServiceRequirement({
    required int serviceRequirementId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiManager.putObject(
        url:
            '${APIConstants.connectorUpdateServiceRequirement}/$serviceRequirementId',
        body: data,
      );
      return CreateServiceRequirementModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in updateServiceRequirement: $e , $st');
    }
  }
}
