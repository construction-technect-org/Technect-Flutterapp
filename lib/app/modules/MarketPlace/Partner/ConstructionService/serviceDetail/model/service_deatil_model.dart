import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';

class ServiceDetailModel {
  bool? success;
  String? message;
  Data? data;

  ServiceDetailModel({this.success, this.message, this.data});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Service? service;
  List<Service>? similarServices;

  Data({this.service, this.similarServices});

  Data.fromJson(Map<String, dynamic> json) {
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['similar_services'] != null) {
      similarServices = <Service>[];
      json['similar_services'].forEach((v) {
        similarServices!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (similarServices != null) {
      data['similar_services'] =
          similarServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
