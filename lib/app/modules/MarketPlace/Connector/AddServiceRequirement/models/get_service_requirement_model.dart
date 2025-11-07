class GetServiceRequirementListModel {
  bool? success;
  String? message;
  List<ServiceRequirementData>? data;
  ServiceRequirementPagination? pagination;

  GetServiceRequirementListModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
  });

  factory GetServiceRequirementListModel.fromJson(Map<String, dynamic> json) {
    return GetServiceRequirementListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List)
                .map((item) => ServiceRequirementData.fromJson(item))
                .toList()
          : null,
      pagination: json['pagination'] != null
          ? ServiceRequirementPagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList() ?? [],
      'pagination': pagination?.toJson(),
    };
  }
}

class ServiceRequirementData {
  int? id;
  int? connectorUserId;
  int? mainCategoryId;
  int? subCategoryId;
  int? serviceCategoryId;
  int? siteAddressId;
  String? estimateStartDate;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mainCategoryName;
  String? subCategoryName;
  String? serviceCategoryName;
  ServiceRequirementSiteAddress? siteAddress;

  ServiceRequirementData({
    this.id,
    this.connectorUserId,
    this.mainCategoryId,
    this.subCategoryId,
    this.serviceCategoryId,
    this.siteAddressId,
    this.estimateStartDate,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryName,
    this.subCategoryName,
    this.serviceCategoryName,
    this.siteAddress,
  });

  factory ServiceRequirementData.fromJson(Map<String, dynamic> json) {
    return ServiceRequirementData(
      id: json['id'],
      connectorUserId: json['connector_user_id'],
      mainCategoryId: json['main_category_id'],
      subCategoryId: json['sub_category_id'],
      serviceCategoryId: json['service_category_id'],
      siteAddressId: json['site_address_id'],
      estimateStartDate: json['estimate_start_date'],
      note: json['note'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      mainCategoryName: json['main_category_name'],
      subCategoryName: json['sub_category_name'],
      serviceCategoryName: json['service_category_name'],
      siteAddress: json['site_address'] != null
          ? ServiceRequirementSiteAddress.fromJson(json['site_address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'connector_user_id': connectorUserId,
      'main_category_id': mainCategoryId,
      'sub_category_id': subCategoryId,
      'service_category_id': serviceCategoryId,
      'site_address_id': siteAddressId,
      'estimate_start_date': estimateStartDate,
      'note': note,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'main_category_name': mainCategoryName,
      'sub_category_name': subCategoryName,
      'service_category_name': serviceCategoryName,
      'site_address': siteAddress?.toJson(),
    };
  }
}

class ServiceRequirementSiteAddress {
  int? id;
  String? siteName;
  String? siteCode;
  String? fullAddress;
  String? landmark;
  double? latitude;
  double? longitude;

  ServiceRequirementSiteAddress({
    this.id,
    this.siteName,
    this.siteCode,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
  });

  factory ServiceRequirementSiteAddress.fromJson(Map<String, dynamic> json) {
    return ServiceRequirementSiteAddress(
      id: json['id'],
      siteName: json['site_name'],
      siteCode: json['site_code'],
      fullAddress: json['full_address'],
      landmark: json['landmark'],
      latitude: json['latitude'] != null
          ? (json['latitude'] is num
                ? json['latitude'].toDouble()
                : double.tryParse(json['latitude'].toString()))
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] is num
                ? json['longitude'].toDouble()
                : double.tryParse(json['longitude'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'site_name': siteName,
      'site_code': siteCode,
      'full_address': fullAddress,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class ServiceRequirementPagination {
  int? currentPage;
  int? totalPages;
  int? totalRequirements;
  int? limit;
  bool? hasNext;
  bool? hasPrev;

  ServiceRequirementPagination({
    this.currentPage,
    this.totalPages,
    this.totalRequirements,
    this.limit,
    this.hasNext,
    this.hasPrev,
  });

  factory ServiceRequirementPagination.fromJson(Map<String, dynamic> json) {
    return ServiceRequirementPagination(
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      totalRequirements: json['total_requirements'],
      limit: json['limit'],
      hasNext: json['has_next'],
      hasPrev: json['has_prev'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_requirements': totalRequirements,
      'limit': limit,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }
}
