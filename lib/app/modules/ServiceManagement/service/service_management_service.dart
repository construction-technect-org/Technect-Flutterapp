import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ServiceManagement/model/service_model.dart';

class ServiceManagementService {
  ApiManager apiManager = ApiManager();

  Future<ServiceListModel> getServiceList() async {
    try {
      final response = await apiManager.get(url: APIConstants.getServiceList);
      return ServiceListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getServiceList: $e , $st');
    }
  }

  Future<ServiceTypeModel> getServiceTypes() async {
    try {
      final response = await apiManager.get(url: APIConstants.getServiceTypes);
      return ServiceTypeModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getServiceTypes: $e , $st');
    }
  }

  Future<ServiceDropdownModel> getServices(int serviceTypeId) async {
    try {
      final response = await apiManager.get(
        url: '${APIConstants.getServices}/$serviceTypeId',
      );
      return ServiceDropdownModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getServices: $e , $st');
    }
  }

  Future<CreateServiceResponse> createService({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.postMultipart(
        url: APIConstants.createService,
        fields: fields,
        files: files,
      );
      return CreateServiceResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in createService: $e , $st');
    }
  }

  Future<CreateServiceResponse> updateService({
    required int serviceId,
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final response = await apiManager.putMultipart(
        url: '${APIConstants.updateService}$serviceId',
        fields: fields,
        files: files,
      );
      return CreateServiceResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in updateService: $e , $st');
    }
  }
}

class CreateServiceResponse {
  final bool? success;
  final String? message;

  CreateServiceResponse({this.success, this.message});

  factory CreateServiceResponse.fromJson(Map<String, dynamic> json) =>
      CreateServiceResponse(success: json["success"], message: json["message"]);

  Map<String, dynamic> toJson() => {"success": success, "message": message};
}
