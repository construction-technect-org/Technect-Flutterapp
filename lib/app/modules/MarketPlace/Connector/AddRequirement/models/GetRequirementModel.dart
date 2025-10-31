class GetRequirementListModel {
  bool? success;
  String? message;
  List<RequirementData>? data;
  PaginationData? pagination;

  GetRequirementListModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
  });

  factory GetRequirementListModel.fromJson(Map<String, dynamic> json) {
    return GetRequirementListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List)
                .map((item) => RequirementData.fromJson(item))
                .toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationData.fromJson(json['pagination'])
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

class RequirementData {
  int? id;
  int? connectorUserId;
  int? mainCategoryId;
  int? subCategoryId;
  int? categoryProductId;
  int? productSubCategoryId;
  int? quantity;
  String? uom;
  int? siteAddressId;
  String? estimateDeliveryDate;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mainCategoryName;
  String? subCategoryName;
  String? categoryProductName;
  String? productSubCategoryName;
  SiteAddressData? siteAddress;

  RequirementData({
    this.id,
    this.connectorUserId,
    this.mainCategoryId,
    this.subCategoryId,
    this.categoryProductId,
    this.productSubCategoryId,
    this.quantity,
    this.uom,
    this.siteAddressId,
    this.estimateDeliveryDate,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryName,
    this.subCategoryName,
    this.categoryProductName,
    this.productSubCategoryName,
    this.siteAddress,
  });

  factory RequirementData.fromJson(Map<String, dynamic> json) {
    return RequirementData(
      id: json['id'],
      connectorUserId: json['connector_user_id'],
      mainCategoryId: json['main_category_id'],
      subCategoryId: json['sub_category_id'],
      categoryProductId: json['category_product_id'],
      productSubCategoryId: json['product_sub_category_id'],
      quantity: json['quantity'],
      uom: json['uom'],
      siteAddressId: json['site_address_id'],
      estimateDeliveryDate: json['estimate_delivery_date'],
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
      categoryProductName: json['category_product_name'],
      productSubCategoryName: json['product_sub_category_name'],
      siteAddress: json['site_address'] != null
          ? SiteAddressData.fromJson(json['site_address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'connector_user_id': connectorUserId,
      'main_category_id': mainCategoryId,
      'sub_category_id': subCategoryId,
      'category_product_id': categoryProductId,
      'product_sub_category_id': productSubCategoryId,
      'quantity': quantity,
      'uom': uom,
      'site_address_id': siteAddressId,
      'estimate_delivery_date': estimateDeliveryDate,
      'note': note,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'main_category_name': mainCategoryName,
      'sub_category_name': subCategoryName,
      'category_product_name': categoryProductName,
      'product_sub_category_name': productSubCategoryName,
      'site_address': siteAddress?.toJson(),
    };
  }
}

class SiteAddressData {
  int? id;
  String? siteName;
  String? fullAddress;
  String? landmark;
  double? latitude;
  double? longitude;

  SiteAddressData({
    this.id,
    this.siteName,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
  });

  factory SiteAddressData.fromJson(Map<String, dynamic> json) {
    return SiteAddressData(
      id: json['id'],
      siteName: json['site_name'],
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
      'full_address': fullAddress,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PaginationData {
  int? currentPage;
  int? totalPages;
  int? totalRequirements;
  int? limit;
  bool? hasNext;
  bool? hasPrev;

  PaginationData({
    this.currentPage,
    this.totalPages,
    this.totalRequirements,
    this.limit,
    this.hasNext,
    this.hasPrev,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
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
