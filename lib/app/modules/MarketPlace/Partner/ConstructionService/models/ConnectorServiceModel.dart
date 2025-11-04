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
  final List<ConnectorService>? services;
  final ServicePagination? pagination;

  ConnectorServiceData({this.services, this.pagination});

  factory ConnectorServiceData.fromJson(Map<String, dynamic> json) {
    return ConnectorServiceData(
      services: json['services'] != null
          ? (json['services'] as List)
                .map((e) => ConnectorService.fromJson(e))
                .toList()
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

class ConnectorService {
  final int? id;
  final int? merchantProfileId;
  final int? mainCategoryId;
  final int? subCategoryId;
  final int? serviceCategoryId;
  final String? units;
  final String? price;
  final String? gstPercentage;
  final String? gstAmount;
  final String? totalAmount;
  final String? description;
  final bool? isActive;
  final String? approvalStatus;
  final int? approvedBy;
  final String? approvedAt;
  final String? rejectionReason;
  final String? createdAt;
  final String? updatedAt;
  final String? mainCategoryName;
  final String? subCategoryName;
  final String? serviceCategoryName;
  final String? merchantName;
  final String? merchantEmail;
  final String? merchantPhone;
  final String? merchantBusinessPhone;
  final String? merchantAlternativePhone;
  final String? merchantGstNumber;
  final String? merchantLogo;
  final int? merchantYearOfEstablished;
  final List<ServiceMedia>? media;
  final ServiceReference? reference;
  final List<BusinessHours>? businessHours;
  final String? connectionRequestStatus;
  final String? distanceKm;

  ConnectorService({
    this.id,
    this.merchantProfileId,
    this.mainCategoryId,
    this.subCategoryId,
    this.serviceCategoryId,
    this.units,
    this.price,
    this.gstPercentage,
    this.gstAmount,
    this.totalAmount,
    this.description,
    this.isActive,
    this.approvalStatus,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryName,
    this.subCategoryName,
    this.serviceCategoryName,
    this.merchantName,
    this.merchantEmail,
    this.merchantPhone,
    this.merchantBusinessPhone,
    this.merchantAlternativePhone,
    this.merchantGstNumber,
    this.merchantLogo,
    this.merchantYearOfEstablished,
    this.media,
    this.reference,
    this.businessHours,
    this.connectionRequestStatus,
    this.distanceKm,
  });

  factory ConnectorService.fromJson(Map<String, dynamic> json) {
    return ConnectorService(
      id: json['id'],
      merchantProfileId: json['merchant_profile_id'],
      mainCategoryId: json['main_category_id'],
      subCategoryId: json['sub_category_id'],
      serviceCategoryId: json['service_category_id'],
      units: json['units'],
      price: json['price'],
      gstPercentage: json['gst_percentage'],
      gstAmount: json['gst_amount'],
      totalAmount: json['total_amount'],
      description: json['description'],
      isActive: json['is_active'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'],
      rejectionReason: json['rejection_reason'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mainCategoryName: json['main_category_name'],
      subCategoryName: json['sub_category_name'],
      serviceCategoryName: json['service_category_name'],
      merchantName: json['merchant_name'],
      merchantEmail: json['merchant_email'],
      merchantPhone: json['merchant_phone'],
      merchantBusinessPhone: json['merchant_business_phone'],
      merchantAlternativePhone: json['merchant_alternative_phone'],
      merchantGstNumber: json['merchant_gst_number'],
      merchantLogo: json['merchant_logo'],
      merchantYearOfEstablished: json['merchant_year_of_established'],
      media: json['media'] != null
          ? (json['media'] as List)
                .map((e) => ServiceMedia.fromJson(e))
                .toList()
          : null,
      reference: json['reference'] != null
          ? ServiceReference.fromJson(json['reference'])
          : null,
      businessHours: json['business_hours'] != null
          ? (json['business_hours'] as List)
                .map((e) => BusinessHours.fromJson(e))
                .toList()
          : null,
      connectionRequestStatus: json['connection_request_status'],
      distanceKm:
          json['distance_km']?.toString() ?? json['distanceKm']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "merchant_profile_id": merchantProfileId,
      "main_category_id": mainCategoryId,
      "sub_category_id": subCategoryId,
      "service_category_id": serviceCategoryId,
      "units": units,
      "price": price,
      "gst_percentage": gstPercentage,
      "gst_amount": gstAmount,
      "total_amount": totalAmount,
      "description": description,
      "is_active": isActive,
      "approval_status": approvalStatus,
      "approved_by": approvedBy,
      "approved_at": approvedAt,
      "rejection_reason": rejectionReason,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "main_category_name": mainCategoryName,
      "sub_category_name": subCategoryName,
      "service_category_name": serviceCategoryName,
      "merchant_name": merchantName,
      "merchant_email": merchantEmail,
      "merchant_phone": merchantPhone,
      "merchant_business_phone": merchantBusinessPhone,
      "merchant_alternative_phone": merchantAlternativePhone,
      "merchant_gst_number": merchantGstNumber,
      "merchant_logo": merchantLogo,
      "merchant_year_of_established": merchantYearOfEstablished,
      "media": media?.map((e) => e.toJson()).toList(),
      "reference": reference?.toJson(),
      "business_hours": businessHours?.map((e) => e.toJson()).toList(),
      "connection_request_status": connectionRequestStatus,
      "distance_km": distanceKm,
    };
  }
}

class ServiceMedia {
  final int? id;
  final int? merchantServiceId;
  final String? mediaType;
  final String? mediaUrl;
  final String? mediaS3Key;
  final int? sortOrder;
  final String? createdAt;

  ServiceMedia({
    this.id,
    this.merchantServiceId,
    this.mediaType,
    this.mediaUrl,
    this.mediaS3Key,
    this.sortOrder,
    this.createdAt,
  });

  factory ServiceMedia.fromJson(Map<String, dynamic> json) {
    return ServiceMedia(
      id: json['id'],
      merchantServiceId: json['merchant_service_id'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      mediaS3Key: json['media_s3_key'],
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "merchant_service_id": merchantServiceId,
      "media_type": mediaType,
      "media_url": mediaUrl,
      "media_s3_key": mediaS3Key,
      "sort_order": sortOrder,
      "created_at": createdAt,
    };
  }
}

class ServiceReference {
  final int? id;
  final int? merchantServiceId;
  final String? referenceType;
  final String? referenceUrl;
  final String? referenceS3Key;
  final String? title;
  final String? description;
  final int? sortOrder;
  final String? createdAt;

  ServiceReference({
    this.id,
    this.merchantServiceId,
    this.referenceType,
    this.referenceUrl,
    this.referenceS3Key,
    this.title,
    this.description,
    this.sortOrder,
    this.createdAt,
  });

  factory ServiceReference.fromJson(Map<String, dynamic> json) {
    return ServiceReference(
      id: json['id'],
      merchantServiceId: json['merchant_service_id'],
      referenceType: json['reference_type'],
      referenceUrl: json['reference_url'],
      referenceS3Key: json['reference_s3_key'],
      title: json['title'],
      description: json['description'],
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "merchant_service_id": merchantServiceId,
      "reference_type": referenceType,
      "reference_url": referenceUrl,
      "reference_s3_key": referenceS3Key,
      "title": title,
      "description": description,
      "sort_order": sortOrder,
      "created_at": createdAt,
    };
  }
}

class BusinessHours {
  final int? id;
  final int? dayOfWeek;
  final String? dayName;
  final String? openTime;
  final String? closeTime;
  final bool? isOpen;

  BusinessHours({
    this.id,
    this.dayOfWeek,
    this.dayName,
    this.openTime,
    this.closeTime,
    this.isOpen,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      id: json['id'],
      dayOfWeek: json['day_of_week'],
      dayName: json['day_name'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      isOpen: json['is_open'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "day_of_week": dayOfWeek,
      "day_name": dayName,
      "open_time": openTime,
      "close_time": closeTime,
      "is_open": isOpen,
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
