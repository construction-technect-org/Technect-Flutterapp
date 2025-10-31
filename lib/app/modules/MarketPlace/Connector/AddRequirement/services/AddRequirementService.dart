import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/CreateRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';

class AddRequirementService {
  ApiManager apiManager = ApiManager();

  Future<CreateRequirementModel> createRequirement({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.connectorCreateRequirement,
        body: data,
      );
      return CreateRequirementModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createRequirement: $e , $st');
    }
  }

  Future<CreateRequirementModel> updateRequirement({
    required int requirementId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiManager.putObject(
        url: '${APIConstants.connectorUpdateRequirement}/$requirementId',
        body: data,
      );
      return CreateRequirementModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in updateRequirement: $e , $st');
    }
  }

  Future<RequirementData> getRequirement({required int requirementId}) async {
    try {
      final response = await apiManager.get(
        url: '${APIConstants.connectorGetRequirement}/$requirementId',
      );
      return RequirementData.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getRequirement: $e , $st');
    }
  }

  Future<GetRequirementListModel> getRequirementsList() async {
    try {
      final response = await apiManager.get(
        url: APIConstants.connectorGetRequirement,
      );
      return GetRequirementListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getRequirementsList: $e , $st');
    }
  }
}
