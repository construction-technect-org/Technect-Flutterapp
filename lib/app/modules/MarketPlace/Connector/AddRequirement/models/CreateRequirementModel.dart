import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';

class CreateRequirementModel {
  bool? success;
  String? message;
  RequirementData? data;

  CreateRequirementModel({this.success, this.message, this.data});

  factory CreateRequirementModel.fromJson(Map<String, dynamic> json) {
    return CreateRequirementModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? RequirementData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}
