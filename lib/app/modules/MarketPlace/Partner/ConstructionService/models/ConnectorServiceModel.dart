import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';

class ConnectorServiceModel {
  final bool? success;
  final String? message;
  final ConnectorServiceData? data;

  ConnectorServiceModel({this.success, this.message, this.data});

  factory ConnectorServiceModel.fromJson(Map<String, dynamic> json) {
    return ConnectorServiceModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ConnectorServiceData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data?.toJson()};
  }
}

class ConnectorServiceData {
  final List<Service>? services;
  final ServicePagination? pagination;

  ConnectorServiceData({this.services, this.pagination});

  factory ConnectorServiceData.fromJson(Map<String, dynamic> json) {
    return ConnectorServiceData(
      services: json['services'] != null
          ? (json['services'] as List).map((e) => Service.fromJson(e)).toList()
          : null,
      pagination: json['pagination'] != null
          ? ServicePagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "services": services?.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson(),
    };
  }
}

class ServicePagination {
  final int? currentPage;
  final int? totalPages;
  final int? totalServices;
  final int? limit;
  final bool? hasNext;
  final bool? hasPrev;

  ServicePagination({
    this.currentPage,
    this.totalPages,
    this.totalServices,
    this.limit,
    this.hasNext,
    this.hasPrev,
  });

  factory ServicePagination.fromJson(Map<String, dynamic> json) {
    return ServicePagination(
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      totalServices: json['total_services'],
      limit: json['limit'],
      hasNext: json['has_next'],
      hasPrev: json['has_prev'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_page": currentPage,
      "total_pages": totalPages,
      "total_services": totalServices,
      "limit": limit,
      "has_next": hasNext,
      "has_prev": hasPrev,
    };
  }
}
