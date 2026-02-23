class InventoryServiceModel {
  bool? success;
  String? message;
  InventoryServiceData? data;

  InventoryServiceModel({this.success, this.message, this.data});

  InventoryServiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? InventoryServiceData.fromJson(json['data']) : null;
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

class InventoryServiceData {
  int? id;
  int? merchantProfileId;
  int? mainCategoryId;
  int? subCategoryId;
  int? serviceCategoryId;
  String? units;
  String? price;
  String? gstPercentage;
  String? totalAmount;
  String? description;
  String? note;
  String? serviceReferenceUrl;
  bool? isActive;
  String? approvalStatus;
  String? createdAt;
  String? updatedAt;
  List<ServiceMedia>? images;
  ServiceMedia? video;
  ServiceReference? reference;
  List<ServiceFeature>? features;

  InventoryServiceData({
    this.id,
    this.merchantProfileId,
    this.mainCategoryId,
    this.subCategoryId,
    this.serviceCategoryId,
    this.units,
    this.price,
    this.gstPercentage,
    this.totalAmount,
    this.description,
    this.note,
    this.serviceReferenceUrl,
    this.isActive,
    this.approvalStatus,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.video,
    this.reference,
    this.features,
  });

  InventoryServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantProfileId = json['merchant_profile_id'];
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    serviceCategoryId = json['service_category_id'];
    units = json['units'];
    price = json['price']?.toString();
    gstPercentage = json['gst_percentage']?.toString();
    totalAmount = json['total_amount']?.toString();
    description = json['description'];
    note = json['note'];
    serviceReferenceUrl = json['service_reference_url'];
    isActive = json['is_active'];
    approvalStatus = json['approval_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <ServiceMedia>[];
      json['images'].forEach((v) {
        images!.add(ServiceMedia.fromJson(v));
      });
    }
    video = json['video'] != null ? ServiceMedia.fromJson(json['video']) : null;
    reference = json['reference'] != null ? ServiceReference.fromJson(json['reference']) : null;
    if (json['features'] != null) {
      features = <ServiceFeature>[];
      json['features'].forEach((v) {
        features!.add(ServiceFeature.fromJson(v));
      });
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
    data['total_amount'] = totalAmount;
    data['description'] = description;
    data['note'] = note;
    data['service_reference_url'] = serviceReferenceUrl;
    data['is_active'] = isActive;
    data['approval_status'] = approvalStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceMedia {
  int? id;
  String? mediaType;
  String? mediaUrl;
  String? mediaS3Key;
  int? sortOrder;
  String? createdAt;

  ServiceMedia({
    this.id,
    this.mediaType,
    this.mediaUrl,
    this.mediaS3Key,
    this.sortOrder,
    this.createdAt,
  });

  ServiceMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    mediaUrl = json['media_url'];
    mediaS3Key = json['media_s3_key'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
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

class ServiceReference {
  int? id;
  String? referenceType;
  String? referenceUrl;
  String? referenceS3Key;
  String? title;
  String? description;

  ServiceReference({
    this.id,
    this.referenceType,
    this.referenceUrl,
    this.referenceS3Key,
    this.title,
    this.description,
  });

  ServiceReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceType = json['reference_type'];
    referenceUrl = json['reference_url'];
    referenceS3Key = json['reference_s3_key'];
    title = json['title'];
    description = json['description'];
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

class ServiceFeature {
  int? id;
  int? merchantServiceId;
  String? feature;
  String? details;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;

  ServiceFeature({
    this.id,
    this.merchantServiceId,
    this.feature,
    this.details,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  ServiceFeature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantServiceId = json['merchant_service_id'];
    feature = json['feature'];
    details = json['details'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_service_id'] = merchantServiceId;
    data['feature'] = feature;
    data['details'] = details;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
