import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/create_service_requirement_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/get_service_requirement_model.dart';
class RequirementServices {
  ApiManager apiManager = ApiManager();

  Future<GetServiceRequirementListModel> getServiceRequirementsList({
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (page != null) {
        queryParams['page'] = page.toString();
      }
      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }

      String url = APIConstants.connectorGetServiceRequirementList;
      if (queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
            .join('&');
        url = '$url?$queryString';
      }

      final response = await apiManager.get(url: url);
      return GetServiceRequirementListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getServiceRequirementsList: $e , $st');
    }
  }

  Future<CreateServiceRequirementModel> deleteServiceRequirement({
    required int serviceRequirementId,
  }) async {
    try {
      final response = await apiManager.delete(
        url:
            '${APIConstants.connectorCreateServiceRequirement}/$serviceRequirementId',
      );
      return CreateServiceRequirementModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in deleteServiceRequirement: $e , $st');
    }
  }
}
