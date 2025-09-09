// To parse this JSON data, do
//
//     final getFilterModel = getFilterModelFromJson(jsonString);

import 'dart:convert';

GetFilterModel getFilterModelFromJson(String str) => GetFilterModel.fromJson(json.decode(str));

String getFilterModelToJson(GetFilterModel data) => json.encode(data.toJson());

class GetFilterModel {
  final bool? success;
  final List<FilterData>? data;
  final String? message;

  GetFilterModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetFilterModel.fromJson(Map<String, dynamic> json) => GetFilterModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<FilterData>.from(json["data"]!.map((x) => FilterData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class FilterData {
  final int? id;
  final int? subCategoryId;
  final String? filterName;
  final String? filterLabel;
  final String? filterType;
  final dynamic filterOptions;
  final String? unit;
  final bool? isRequired;
  final bool? isActive;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? subCategoryName;

  FilterData({
    this.id,
    this.subCategoryId,
    this.filterName,
    this.filterLabel,
    this.filterType,
    this.filterOptions,
    this.unit,
    this.isRequired,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.subCategoryName,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    filterName: json["filter_name"],
    filterLabel: json["filter_label"],
    filterType: json["filter_type"],
    filterOptions: json["filter_options"],
    unit: json["unit"],
    isRequired: json["is_required"],
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subCategoryName: json["sub_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "filter_name": filterName,
    "filter_label": filterLabel,
    "filter_type": filterType,
    "filter_options": filterOptions,
    "unit": unit,
    "is_required": isRequired,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sub_category_name": subCategoryName,
  };
}
