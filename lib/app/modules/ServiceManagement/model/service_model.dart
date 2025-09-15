// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) =>
    ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  final bool? success;
  final ServiceData? data;
  final String? message;

  ServiceListModel({this.success, this.data, this.message});

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    success: json["success"],
    data: json["data"] == null ? null : ServiceData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class ServiceData {
  final List<Service>? services;
  final ServiceStatistics? statistics;

  ServiceData({this.services, this.statistics});

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    services: json["services"] == null
        ? []
        : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    statistics: json["statistics"] == null
        ? null
        : ServiceStatistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "services": services == null
        ? []
        : List<dynamic>.from(services!.map((x) => x.toJson())),
    "statistics": statistics?.toJson(),
  };
}

class Service {
  final int? id;
  final int? merchantProfileId;
  final String? serviceName;
  final String? serviceImage;
  final int? serviceTypeId;
  final int? serviceId;
  final String? uom;
  final String? price;
  final String? gstPercentage;
  final String? gstPrice;
  final String? termsAndConditions;
  final String? description;
  final bool? isActive;
  final bool? isFeatured;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? serviceTypeName;
  final String? serviceNameStandard;

  Service({
    this.id,
    this.merchantProfileId,
    this.serviceName,
    this.serviceImage,
    this.serviceTypeId,
    this.serviceId,
    this.uom,
    this.price,
    this.gstPercentage,
    this.gstPrice,
    this.termsAndConditions,
    this.description,
    this.isActive,
    this.isFeatured,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.serviceTypeName,
    this.serviceNameStandard,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    merchantProfileId: json["merchant_profile_id"],
    serviceName: json["service_name"],
    serviceImage: json["service_image"],
    serviceTypeId: json["service_type_id"],
    serviceId: json["service_id"],
    uom: json["uom"],
    price: json["price"],
    gstPercentage: json["gst_percentage"],
    gstPrice: json["gst_price"],
    termsAndConditions: json["terms_and_conditions"],
    description: json["description"],
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    serviceTypeName: json["service_type_name"],
    serviceNameStandard: json["service_name_standard"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_profile_id": merchantProfileId,
    "service_name": serviceName,
    "service_image": serviceImage,
    "service_type_id": serviceTypeId,
    "service_id": serviceId,
    "uom": uom,
    "price": price,
    "gst_percentage": gstPercentage,
    "gst_price": gstPrice,
    "terms_and_conditions": termsAndConditions,
    "description": description,
    "is_active": isActive,
    "is_featured": isFeatured,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_type_name": serviceTypeName,
    "service_name_standard": serviceNameStandard,
  };
}

class ServiceStatistics {
  final String? totalServices;
  final String? featuredServices;
  final String? servicesWithPricing;
  final String? averagePrice;

  ServiceStatistics({
    this.totalServices,
    this.featuredServices,
    this.servicesWithPricing,
    this.averagePrice,
  });

  factory ServiceStatistics.fromJson(Map<String, dynamic> json) => ServiceStatistics(
    totalServices: json["total_services"],
    featuredServices: json["featured_services"],
    servicesWithPricing: json["services_with_pricing"],
    averagePrice: json["average_price"],
  );

  Map<String, dynamic> toJson() => {
    "total_services": totalServices,
    "featured_services": featuredServices,
    "services_with_pricing": servicesWithPricing,
    "average_price": averagePrice,
  };
}

// Service Type and Service dropdown models
class ServiceTypeModel {
  final bool? success;
  final List<ServiceType>? data;
  final String? message;

  ServiceTypeModel({this.success, this.data, this.message});

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) => ServiceTypeModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<ServiceType>.from(json["data"]!.map((x) => ServiceType.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ServiceType {
  final int? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceType({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class ServiceDropdownModel {
  final bool? success;
  final List<ServiceDropdown>? data;
  final String? message;

  ServiceDropdownModel({this.success, this.data, this.message});

  factory ServiceDropdownModel.fromJson(Map<String, dynamic> json) =>
      ServiceDropdownModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ServiceDropdown>.from(
                json["data"]!.map((x) => ServiceDropdown.fromJson(x)),
              ),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ServiceDropdown {
  final int? id;
  final int? serviceTypeId;
  final String? name;
  final String? description;
  final bool? isActive;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceDropdown({
    this.id,
    this.serviceTypeId,
    this.name,
    this.description,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceDropdown.fromJson(Map<String, dynamic> json) => ServiceDropdown(
    id: json["id"],
    serviceTypeId: json["service_type_id"],
    name: json["name"],
    description: json["description"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_type_id": serviceTypeId,
    "name": name,
    "description": description,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
