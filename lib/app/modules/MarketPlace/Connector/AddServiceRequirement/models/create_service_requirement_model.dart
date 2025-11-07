import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/get_service_requirement_model.dart';

class CreateServiceRequirementModel {
  bool? success;
  String? message;
  ServiceRequirementData? data;

  CreateServiceRequirementModel({this.success, this.message, this.data});

  factory CreateServiceRequirementModel.fromJson(Map<String, dynamic> json) {
    return CreateServiceRequirementModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ServiceRequirementData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}
