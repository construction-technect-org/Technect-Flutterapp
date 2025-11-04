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
  List<Media>? media;
  Reference? reference;

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
    this.media,
    this.reference,
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

    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }

    reference = json['reference'] != null
        ? Reference.fromJson(json['reference'])
        : null;
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

    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }

    if (reference != null) {
      data['reference'] = reference!.toJson();
    }

    return data;
  }
}

class Media {
  int? id;
  int? merchantServiceId;
  String? mediaType;
  String? mediaUrl;
  String? mediaS3Key;
  int? sortOrder;
  String? createdAt;

  Media({
    this.id,
    this.merchantServiceId,
    this.mediaType,
    this.mediaUrl,
    this.mediaS3Key,
    this.sortOrder,
    this.createdAt,
  });

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantServiceId = json['merchant_service_id'];
    mediaType = json['media_type'];
    mediaUrl = json['media_url'];
    mediaS3Key = json['media_s3_key'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_service_id'] = merchantServiceId;
    data['media_type'] = mediaType;
    data['media_url'] = mediaUrl;
    data['media_s3_key'] = mediaS3Key;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    return data;
  }
}

class Reference {
  int? id;
  int? merchantServiceId;
  String? referenceType;
  String? referenceUrl;
  String? referenceS3Key;
  String? title;
  String? description;
  int? sortOrder;
  String? createdAt;

  Reference({
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

  Reference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantServiceId = json['merchant_service_id'];
    referenceType = json['reference_type'];
    referenceUrl = json['reference_url'];
    referenceS3Key = json['reference_s3_key'];
    title = json['title'];
    description = json['description'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_service_id'] = merchantServiceId;
    data['reference_type'] = referenceType;
    data['reference_url'] = referenceUrl;
    data['reference_s3_key'] = referenceS3Key;
    data['title'] = title;
    data['description'] = description;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    return data;
  }
}
