class AllServiceModel {
  bool? success;
  List<Service>? data;
  String? message;

  AllServiceModel({this.success, this.data, this.message});

  AllServiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Service>[];
      json['data'].forEach((v) {
        data!.add(Service.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Service {
  int? id;
  int? merchantProfileId;
  int? mainCategoryId;
  int? subCategoryId;
  int? serviceCategoryId;
  String? units;
  String? price;
  String? gstPercentage;
  String? gstAmount;
  String? totalAmount;
  String? description;
  bool? isActive;
  String? approvalStatus;
  int? approvedBy;
  String? approvedAt;
  String? rejectionReason;
  String? createdAt;
  String? updatedAt;
  String? mainCategoryName;
  String? subCategoryName;
  String? serviceCategoryName;
  String? merchantName;
  String? merchantEmail;
  String? merchantPhone;
  int? merchantUserId;
  String? merchantBusinessPhone;
  String? merchantAlternativePhone;
  int? merchantYearOfEstablished;
  String? merchantGstNumber;
  String? merchantLogo;
  String? merchantWebsite;
  int? connectionRequestId;
  String? connectionStatus;
  String? requestMessage;
  String? responseMessage;
  String? connectedAt;
  String? connectionCreatedAt;
  String? connectionUpdatedAt;
  String? connectionRequestStatus;
  double? distanceKm;
  List<ServiceMediaItem>? images;
  ServiceMediaItem? video;
  ServiceReferenceItem? reference;
  List<BusinessHoursItem>? businessHours;
  ConnectionRequest? connectionRequest;

  Service({
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
    this.merchantUserId,
    this.merchantBusinessPhone,
    this.merchantAlternativePhone,
    this.merchantYearOfEstablished,
    this.merchantGstNumber,
    this.merchantLogo,
    this.merchantWebsite,
    this.connectionRequestId,
    this.connectionStatus,
    this.requestMessage,
    this.responseMessage,
    this.connectedAt,
    this.connectionCreatedAt,
    this.connectionUpdatedAt,
    this.connectionRequestStatus,
    this.distanceKm,
    this.images,
    this.video,
    this.reference,
    this.businessHours,
    this.connectionRequest,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantProfileId = json['merchant_profile_id'];
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    serviceCategoryId = json['service_category_id'];
    units = json['units'];
    price = json['price']?.toString();
    gstPercentage = json['gst_percentage']?.toString();
    gstAmount = json['gst_amount']?.toString();
    totalAmount = json['total_amount']?.toString();
    description = json['description'];
    isActive = json['is_active'];
    approvalStatus = json['approval_status'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    rejectionReason = json['rejection_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mainCategoryName = json['main_category_name'];
    subCategoryName = json['sub_category_name'];
    serviceCategoryName = json['service_category_name'];
    merchantName = json['merchant_name'];
    merchantEmail = json['merchant_email'];
    merchantPhone = json['merchant_phone'];
    merchantUserId = json['merchant_user_id'];
    merchantBusinessPhone = json['merchant_business_phone'];
    merchantAlternativePhone = json['merchant_alternative_phone'];
    merchantYearOfEstablished = json['merchant_year_of_established'];
    merchantGstNumber = json['merchant_gst_number'];
    merchantLogo = json['merchant_logo'];
    merchantWebsite = json['merchant_website'];
    connectionRequestId = json['connection_request_id'];
    connectionStatus = json['connection_status'];
    requestMessage = json['request_message'];
    responseMessage = json['response_message'];
    connectedAt = json['connected_at'];
    connectionCreatedAt = json['connection_created_at'];
    connectionUpdatedAt = json['connection_updated_at'];
    connectionRequestStatus = json['connection_request_status'];
    distanceKm = json['distance_km'] != null
        ? (json['distance_km'] is num
              ? json['distance_km'].toDouble()
              : double.tryParse(json['distance_km'].toString()))
        : null;

    if (json['images'] != null) {
      images = <ServiceMediaItem>[];
      json['images'].forEach((v) {
        images!.add(ServiceMediaItem.fromJson(v));
      });
    }

    if (json['video'] != null) {
      video = ServiceMediaItem.fromJson(json['video']);
    }

    if (json['reference'] != null) {
      reference = ServiceReferenceItem.fromJson(json['reference']);
    }

    if (json['business_hours'] != null) {
      businessHours = <BusinessHoursItem>[];
      json['business_hours'].forEach((v) {
        businessHours!.add(BusinessHoursItem.fromJson(v));
      });
    }

    if (json['connection_request'] != null) {
      connectionRequest = ConnectionRequest.fromJson(
        json['connection_request'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_profile_id'] = merchantProfileId;
    data['main_category_id'] = mainCategoryId;
    data['sub_category_id'] = subCategoryId;
    data['service_category_id'] = serviceCategoryId;
    data['units'] = units;
    data['price'] = price;
    data['gst_percentage'] = gstPercentage;
    data['gst_amount'] = gstAmount;
    data['total_amount'] = totalAmount;
    data['description'] = description;
    data['is_active'] = isActive;
    data['approval_status'] = approvalStatus;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    data['rejection_reason'] = rejectionReason;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['main_category_name'] = mainCategoryName;
    data['sub_category_name'] = subCategoryName;
    data['service_category_name'] = serviceCategoryName;
    data['merchant_name'] = merchantName;
    data['merchant_email'] = merchantEmail;
    data['merchant_phone'] = merchantPhone;
    data['merchant_user_id'] = merchantUserId;
    data['merchant_business_phone'] = merchantBusinessPhone;
    data['merchant_alternative_phone'] = merchantAlternativePhone;
    data['merchant_year_of_established'] = merchantYearOfEstablished;
    data['merchant_gst_number'] = merchantGstNumber;
    data['merchant_logo'] = merchantLogo;
    data['merchant_website'] = merchantWebsite;
    data['connection_request_id'] = connectionRequestId;
    data['connection_status'] = connectionStatus;
    data['request_message'] = requestMessage;
    data['response_message'] = responseMessage;
    data['connected_at'] = connectedAt;
    data['connection_created_at'] = connectionCreatedAt;
    data['connection_updated_at'] = connectionUpdatedAt;
    data['connection_request_status'] = connectionRequestStatus;
    data['distance_km'] = distanceKm;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    if (businessHours != null) {
      data['business_hours'] = businessHours!.map((v) => v.toJson()).toList();
    }
    if (connectionRequest != null) {
      data['connection_request'] = connectionRequest!.toJson();
    }
    return data;
  }
}

class ServiceMediaItem {
  int? id;
  String? mediaType;
  String? mediaUrl;
  String? mediaS3Key;
  int? sortOrder;
  String? createdAt;

  ServiceMediaItem({
    this.id,
    this.mediaType,
    this.mediaUrl,
    this.mediaS3Key,
    this.sortOrder,
    this.createdAt,
  });

  factory ServiceMediaItem.fromJson(Map<String, dynamic> json) {
    return ServiceMediaItem(
      id: json['id'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      mediaS3Key: json['media_s3_key'],
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['media_url'] = mediaUrl;
    data['media_s3_key'] = mediaS3Key;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    return data;
  }
}

class ServiceReferenceItem {
  int? id;
  String? referenceType;
  String? referenceUrl;
  String? referenceS3Key;
  String? title;
  String? description;

  ServiceReferenceItem({
    this.id,
    this.referenceType,
    this.referenceUrl,
    this.referenceS3Key,
    this.title,
    this.description,
  });

  factory ServiceReferenceItem.fromJson(Map<String, dynamic> json) {
    return ServiceReferenceItem(
      id: json['id'],
      referenceType: json['reference_type'],
      referenceUrl: json['reference_url'],
      referenceS3Key: json['reference_s3_key'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference_type'] = referenceType;
    data['reference_url'] = referenceUrl;
    data['reference_s3_key'] = referenceS3Key;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class BusinessHoursItem {
  int? id;
  int? dayOfWeek;
  String? dayName;
  String? openTime;
  String? closeTime;
  bool? isOpen;

  BusinessHoursItem({
    this.id,
    this.dayOfWeek,
    this.dayName,
    this.openTime,
    this.closeTime,
    this.isOpen,
  });

  factory BusinessHoursItem.fromJson(Map<String, dynamic> json) {
    return BusinessHoursItem(
      id: json['id'],
      dayOfWeek: json['day_of_week'],
      dayName: json['day_name'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      isOpen: json['is_open'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day_of_week'] = dayOfWeek;
    data['day_name'] = dayName;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['is_open'] = isOpen;
    return data;
  }
}

class ConnectionRequest {
  int? id;
  String? status;
  String? requestMessage;
  String? responseMessage;
  String? connectedAt;
  String? createdAt;
  String? updatedAt;

  ConnectionRequest({
    this.id,
    this.status,
    this.requestMessage,
    this.responseMessage,
    this.connectedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ConnectionRequest.fromJson(Map<String, dynamic> json) {
    return ConnectionRequest(
      id: json['id'],
      status: json['status'],
      requestMessage: json['request_message'],
      responseMessage: json['response_message'],
      connectedAt: json['connected_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['request_message'] = requestMessage;
    data['response_message'] = responseMessage;
    data['connected_at'] = connectedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
